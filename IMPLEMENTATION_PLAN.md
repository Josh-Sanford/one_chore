# OneChore Implementation Plan

**Last Updated:** 2025-11-15

This plan outlines the phased approach to building the OneChore app. It's a living document—adjust as we learn and iterate.

---

## Technical Decisions

### Storage
**Choice: Isar**
- Faster than Hive (10x performance claims)
- Better query system for filtering/sorting
- Built-in indexes for date queries
- Great for stats calculations

### Animations
**Choice: Lottie + Flutter built-ins**
- Lottie for celebration/confetti animations (use LottieFiles.com)
- Flutter AnimatedContainer, Hero, etc. for micro-interactions
- Custom animations where needed

### State Management
**Choice: Riverpod with code generation**
- Using riverpod_generator for providers
- Freezed for immutable data models

### Routing
**Choice: go_router**
- Declarative routing
- Deep linking support
- Type-safe navigation

---

## Phase 0: Dependencies & Architecture Setup
**Goal:** Set up all required packages and core architecture

### Dependencies to Add:
```yaml
dependencies:
  # Data modeling
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0

  # Storage
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.4

  # Routing
  go_router: ^14.6.2

  # Visualization
  fl_chart: ^0.69.2

  # Notifications
  flutter_local_notifications: ^18.0.1

  # Animations
  lottie: ^3.2.0

  # Utilities
  uuid: ^4.5.1

dev_dependencies:
  # Code generation
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  isar_generator: ^3.1.0+1
```

### Folder Structure:
```
lib/
  core/
    theme/
      app_theme.dart
      color_palette.dart
      text_styles.dart
      spacing.dart
    widgets/
      primary_button.dart
      secondary_button.dart
      empty_state_widget.dart
      error_view.dart
      loading_indicator.dart
    constants/
      app_constants.dart

  chore_list/
    models/
      chore.dart
    providers/
      chore_repository_provider.dart
      pending_chores_provider.dart
      chore_list_controller_provider.dart
    repository/
      chores_repository.dart
      isar_chores_repository.dart
    view/
      chore_list_screen.dart
    widgets/
      add_chore_dialog.dart
      edit_chore_dialog.dart           # NEW: For editing
      chore_list_item.dart

  daily_chore/
    models/
      daily_chore.dart
    providers/
      daily_chore_repository_provider.dart
      todays_daily_chore_provider.dart
      daily_chore_controller_provider.dart
      random_chore_picker_provider.dart
    repository/
      daily_chore_repository.dart
      isar_daily_chore_repository.dart
    view/
      daily_chore_screen.dart
    widgets/
      no_daily_chore_view.dart
      daily_chore_card.dart
      chore_selector_dialog.dart
      completion_button.dart
      completion_animation.dart

  history/                             # NEW: Chore history feature
    models/
      (reuse Chore model)
    providers/
      completed_chores_provider.dart
    view/
      history_screen.dart
    widgets/
      completed_chore_item.dart

  notifications/
    models/
      reminder_settings.dart
      message_category.dart
    providers/
      notification_repository_provider.dart
      settings_repository_provider.dart
      reminder_settings_provider.dart
      notification_controller_provider.dart
    repository/
      notification_repository.dart
      settings_repository.dart
    services/
      message_generator.dart
      notification_scheduler.dart

  visualization/
    models/
      statistics.dart
      timeline_day.dart
    providers/
      stats_repository_provider.dart
      statistics_provider.dart
      timeline_provider.dart
    repository/
      stats_repository.dart
      isar_stats_repository.dart
    view/
      visualization_screen.dart
    widgets/
      stats_card.dart
      timeline_chart.dart
      streak_indicator.dart
      time_view_toggle.dart

  settings/
    models/
      (reuse reminder_settings)
    providers/
      (reuse from notifications)
    view/
      settings_screen.dart
    widgets/
      time_picker_widget.dart
      message_preview_widget.dart
```

### Tasks:
1. Add all dependencies to `pubspec.yaml`
2. Run `flutter pub get`
3. Create folder structure
4. Initialize Isar in `bootstrap.dart`
5. Set up build_runner watch mode for code generation

---

## Phase 1: Foundation (Theme & Common Widgets)
**Goal:** Build the design system and reusable components

### Tasks:

**1. Theme Setup:**
- Create `lib/core/theme/app_theme.dart`:
  - Light and dark theme configurations
  - Semi-dark blue color scheme (already have seed color)
  - Define named colors (primary, secondary, success, error, etc.)

- Create `lib/core/theme/text_styles.dart`:
  - Heading styles (h1, h2, h3)
  - Body text styles
  - Caption styles
  - Button text styles

- Create `lib/core/theme/spacing.dart`:
  - Consistent spacing constants (xs, s, m, l, xl)
  - Padding/margin helpers

**2. Common Widgets:**
- `PrimaryButton` - Large, prominent action button with loading state
- `SecondaryButton` - Subtle action button
- `EmptyStateWidget` - Generic empty state with icon + message + optional action
- `ErrorView` - Error display with retry button
- `LoadingIndicator` - Consistent loading spinner

**3. App Scaffold:**
- `AppScaffold` with bottom navigation bar placeholder
- Navigation items: Home, My Chores, Progress, History (4 items)

**4. Testing:**
- Widget tests for all common widgets
- Theme consistency tests

---

## Phase 2: Chore Management (Core Feature)
**Goal:** Implement full CRUD for chores with Isar storage

### Tasks:

**1. Data Layer:**
- Create `Chore` model with freezed + Isar annotations:
  ```dart
  @freezed
  @Collection(ignore: {'copyWith'})
  class Chore with _$Chore {
    const factory Chore({
      @Index(unique: true) required String id,
      required String title,
      String? description,
      required DateTime createdAt,
      DateTime? completedAt,
      @Default(false) bool isCompleted,
    }) = _Chore;
  }
  ```

- Create `ChoresRepository` interface
- Implement `IsarChoresRepository`:
  - `addChore(Chore chore)`
  - `deleteChore(String choreId)`
  - `updateChore(Chore chore)`  # NEW: For editing
  - `getChoreById(String choreId)`
  - `getChores()`
  - `watchPendingChores()` - Stream
  - `watchCompletedChores()` - Stream  # NEW: For history
  - `markChoreComplete(String choreId)`
  - `unmarkChoreComplete(String choreId)`  # NEW: For undo

- Write repository unit tests

**2. State Management:**
- `choresRepositoryProvider` - Singleton Isar repository
- `pendingChoresProvider` - Stream of pending chores
- `completedChoresProvider` - Stream of completed chores  # NEW
- `choreListControllerProvider` - Controller for CRUD operations
- Write provider tests

**3. UI Layer:**
- `ChoreListScreen` - Shows pending chores
  - List view sorted by creation date (newest first)
  - FAB to add chore
  - Empty state when no chores
  - Pull-to-refresh

- `AddChoreDialog` - Form to add new chore
  - Title field (required, 1-100 chars)
  - Description field (optional, max 500 chars)
  - Validation
  - Cancel/Add buttons

- `EditChoreDialog` - Form to edit existing chore  # NEW
  - Pre-populated fields
  - Same validation as add
  - Cancel/Save buttons

- `ChoreListItem` - Individual chore in list
  - Shows title, description, creation date
  - Swipe left to delete (with confirmation)
  - Tap to open edit dialog  # NEW

- Write widget tests for all UI components

**4. Navigation:**
- Set up initial go_router with `/chores` route
- Add "My Chores" tab to bottom navigation

---

## Phase 3: Daily Chore Selection (Core Feature)
**Goal:** Implement the "one chore per day" feature - the heart of OneChore

### Tasks:

**1. Data Layer:**
- Create `DailyChore` model with Isar:
  ```dart
  @freezed
  @Collection(ignore: {'copyWith'})
  class DailyChore with _$DailyChore {
    const factory DailyChore({
      required String choreId,
      @Index(unique: true) required DateTime date,  // Index for queries
      @Default(false) bool isCompleted,
      DateTime? completedAt,
    }) = _DailyChore;
  }
  ```

- Create `DailyChoreRepository` interface
- Implement `IsarDailyChoreRepository`:
  - `getDailyChore(DateTime date)`
  - `setDailyChore(DailyChore dailyChore)`
  - `completeDailyChore(DateTime date)`
  - `changeDailyChore(DateTime date, String newChoreId)`
  - `watchTodaysDailyChore()` - Stream
  - `getAllDailyChores()` - For stats/history

- Write repository tests

**2. Business Logic:**
- Random chore picker:
  - Only selects from pending chores
  - Returns null if no pending chores
  - Uses UUID for randomness

- One-per-day enforcement:
  - Check if today already has a chore selected
  - Replace if user changes selection

- Completion logic:
  - Update `DailyChore.isCompleted = true`
  - Update `Chore.isCompleted = true`
  - Set both `completedAt` timestamps
  - Transaction to ensure both update

- Write business logic unit tests

**3. State Management:**
- `dailyChoreRepositoryProvider`
- `todaysDailyChoreProvider` - Stream of today's DailyChore
- `todaysChoreProvider` - Combines DailyChore + actual Chore data
- `dailyChoreControllerProvider` - select/complete/change actions
- `randomChorePickerProvider` - Random selection logic
- Write provider tests

**4. UI Layer:**
- `DailyChoreScreen` - Home screen (main screen of app)
  - Shows different states based on data
  - Beautiful, prominent design

- `NoDailyChoreView` - Empty state (no chore selected yet)
  - Welcoming message
  - "Pick for me" button (primary, large)
  - "I'll choose" button (secondary)

- `DailyChoreCard` - Large card showing today's chore
  - Title (large, bold)
  - Description (if exists)
  - Creation date
  - "Change chore" button (small, top right)
  - "Mark Complete" button (large, bottom, prominent)

- `ChoreSelectorDialog` - Manual chore selection
  - List of pending chores
  - Tap to select
  - Search/filter if many chores
  - Cancel button

- `CompletionButton` - Large button to mark complete
  - Loading state
  - Success animation trigger

- `CompletionAnimation` - Celebration when chore completed
  - Lottie confetti animation
  - Success message
  - Show completion time
  - "View Progress" button
  - Auto-dismiss after few seconds

- Write widget tests

**5. Navigation:**
- Set up `/` (home) route → `DailyChoreScreen`
- Add "Home" tab to bottom navigation (make it first)

---

## Phase 4: Navigation & Routing
**Goal:** Complete the navigation structure with all routes

### Tasks:

**1. Router Setup:**
- Configure `go_router` with all routes:
  ```dart
  GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => DailyChoreScreen()),
      GoRoute(path: '/chores', builder: (context, state) => ChoreListScreen()),
      GoRoute(path: '/history', builder: (context, state) => HistoryScreen()),
      GoRoute(path: '/visualization', builder: (context, state) => VisualizationScreen()),
      GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
    ],
  )
  ```

**2. Bottom Navigation:**
- Complete `AppScaffold` with 4 bottom nav items:
  - Home (/)
  - My Chores (/chores)
  - Progress (/visualization)
  - History (/history)  # NEW

- Highlight active tab
- Handle tab switching
- Preserve state per tab

**3. App Bar:**
- Settings icon in app bar (all screens)
- Back button where appropriate
- Screen titles

**4. Testing:**
- Navigation flow tests
- Deep link tests (if needed)

---

## Phase 5: History Feature
**Goal:** Show list of completed chores

### Tasks:

**1. State Management:**
- `completedChoresProvider` - Stream of completed chores (already created in Phase 2)
- `historyControllerProvider` - Actions like undo completion

**2. UI Layer:**
- `HistoryScreen`:
  - List of completed chores
  - Sorted by completion date (newest first)
  - Shows title, description, completion date
  - Empty state when no completed chores
  - Swipe to undo completion (moves back to pending)  # OPTIONAL

- `CompletedChoreItem`:
  - Similar to ChoreListItem but read-only
  - Shows completion checkmark
  - Shows completion date/time
  - Optional: Tap to undo

- Write widget tests

**3. Navigation:**
- Add to bottom nav as 4th item
- Test navigation

---

## Phase 6: Progress Visualization
**Goal:** Show stats, streak, and timeline projection

### Tasks:

**1. Data Layer:**
- Create models:
  ```dart
  @freezed
  class Statistics with _$Statistics {
    const factory Statistics({
      required int totalPending,
      required int totalCompleted,
      required int currentStreak,
      required int longestStreak,
      required double completionRate,  // 0.0 to 1.0
      required int daysUntilClear,    // pending count
    }) = _Statistics;
  }

  @freezed
  class TimelineDay with _$TimelineDay {
    const factory TimelineDay({
      required DateTime date,
      String? choreId,
      String? choreTitle,
      required bool isCompleted,
      required bool isProjected,  // vs actual
    }) = _TimelineDay;
  }
  ```

- Create `StatsRepository` interface
- Implement `IsarStatsRepository`:
  - Query Isar for calculations
  - Efficient queries with indexes

- Calculation logic:
  - **Pending**: Count chores where `isCompleted = false`
  - **Completed**: Count chores where `isCompleted = true`
  - **Current Streak**: Query DailyChores backwards from today, count consecutive completed
  - **Longest Streak**: Query all DailyChores, find longest consecutive sequence
  - **Completion Rate**: Completed ÷ Total selected (from DailyChores)
  - **Days Until Clear**: Total pending (assuming 1 per day)
  - **Timeline**: Combine actual (from DailyChores) + projected (pending chores)

- Write calculation unit tests with edge cases

**2. State Management:**
- `statsRepositoryProvider`
- `statisticsProvider` - Auto-updates when chores change
- `timelineProvider(int days)` - Takes days parameter
- Write provider tests

**3. UI Layer:**
- `VisualizationScreen`:
  - Top: 3 stats cards in a row
  - Middle: Big "X days until clear" number
  - Bottom: Timeline chart
  - Bottom: Time view toggle

- `StatsCard`:
  - Icon + label + value
  - Three variants: Pending, Streak (with 🔥), Completion %
  - Subtle shadow/elevation
  - Tap for more details (future)

- `StreakIndicator`:
  - Shows current streak number
  - 🔥 emoji if > 0
  - Color changes based on streak (cold → hot)

- `TimelineChart`:
  - Use fl_chart (BarChart or LineChart)
  - X-axis: Dates
  - Y-axis: Completion status
  - Color: Green (completed), Blue (projected), Gray (pending past)
  - Interactive: Tap bar to see details
  - Smooth animations
  - Responsive

- `TimeViewToggle`:
  - SegmentedButton or ToggleButtons
  - Options: 7 days | 14 days | 30 days | All
  - Updates timeline chart

- Write widget tests

**4. Testing:**
- Chart rendering tests
- Different data scenarios (no data, partial data, full data)
- Edge cases

---

## Phase 7: Notifications & Settings
**Goal:** Daily reminders with personality

### Tasks:

**1. Message System:**
- Create `MessageGenerator` class:
  - 20-30 messages per category
  - Distribution: 60% encouraging, 25% humorous, 15% edgy
  - Random selection weighted by distribution
  - Option to disable edgy messages

- Message examples:
  - **Encouraging**: "You got this! Just one thing today. 💪"
  - **Humorous**: "Your chore called. It misses you. (It's lying.) 📞"
  - **Edgy**: "Still putting it off? It's ONE chore, not climbing Everest. 🏔️"

- Write message generator tests (test distribution)

**2. Data Layer:**
- Create `ReminderSettings` model with Isar:
  ```dart
  @freezed
  @Collection(ignore: {'copyWith'})
  class ReminderSettings with _$ReminderSettings {
    const factory ReminderSettings({
      @Default(true) bool enabled,
      @Default(9) int reminderHour,      // 0-23
      @Default(0) int reminderMinute,    // 0-59
      @Default(true) bool allowEdgyMessages,
    }) = _ReminderSettings;
  }
  ```

- Create `NotificationRepository` interface
- Implement `FlutterLocalNotificationsRepository`:
  - `scheduleDaily(TimeOfDay time, String message)`
  - `cancelAll()`
  - `requestPermissions()`
  - `areNotificationsEnabled()`

- Create `SettingsRepository` for persistence
- Implement `IsarSettingsRepository`
- Write repository tests

**3. Notification Logic:**
- Schedule recurring daily notification
- Generate random message based on settings
- Include today's chore title if available
- Handle time zone changes
- Handle app updates (reschedule)
- Handle notification tap (deep link to home)

**4. State Management:**
- `notificationRepositoryProvider`
- `settingsRepositoryProvider`
- `reminderSettingsProvider`
- `notificationControllerProvider` - Enable/disable, update time
- Write provider tests

**5. UI Layer:**
- `SettingsScreen`:
  - Enable/disable toggle
  - Time picker for reminder time
  - Allow edgy messages toggle
  - Preview messages button
  - Send test notification button
  - Permissions explanation if denied

- `TimePickerWidget`:
  - Native time picker
  - Shows current time
  - Updates on change

- `MessagePreviewWidget`:
  - Shows 3-5 random messages
  - Refresh button for more examples
  - Helps user decide on edgy messages

- Write widget tests

**6. Platform Setup:**
- iOS:
  - Request notification permissions
  - Handle permissions states
  - Update Info.plist

- Android:
  - Create notification channel
  - Handle notification icons
  - Update AndroidManifest.xml

**7. Testing:**
- Notification scheduling tests
- Permission handling tests
- Message generation tests
- Widget tests

---

## Phase 8: Polish & Testing
**Goal:** Animations, error handling, edge cases, full test coverage

### Tasks:

**1. Animations:**
- Add Lottie completion animation
  - Download confetti/celebration animation from LottieFiles
  - Add to assets
  - Integrate into completion flow
  - Test on different devices

- Add micro-animations:
  - Button press feedback (scale)
  - List item entry animations (fade in)
  - Screen transitions (Hero animations)
  - Loading shimmer effects
  - Success/error feedback animations

**2. Error Handling:**
- Wrap all async operations in try-catch
- Show user-friendly error messages
- Retry mechanisms for failures
- Graceful degradation (offline mode)
- Log errors for debugging

**3. Loading States:**
- Loading indicators for all async operations
- Skeleton screens where appropriate
- Disable buttons during operations
- Prevent double-submission

**4. Edge Cases:**
- No chores in list
- No internet connection (not applicable, fully offline)
- App sent to background/brought to foreground
- Time zone changes
- Date changes (midnight)
- Notification permissions denied
- Very long chore titles/descriptions
- Many chores in list (performance)
- Rapid button tapping
- Incomplete state scenarios

**5. Performance:**
- Minimize unnecessary rebuilds (use select, watch)
- Optimize Isar queries
- Image/animation optimization
- App size optimization
- Test on real devices (iOS and Android)

**6. Testing:**
- Achieve 100% test coverage
- Unit tests for all models, repositories, controllers
- Widget tests for all UI components
- Integration tests for critical flows
- Golden tests for UI consistency
- Performance tests
- Manual QA on multiple devices

**7. Accessibility:**
- Semantic labels for screen readers
- Sufficient color contrast
- Touch target sizes (min 48x48)
- Keyboard navigation (if applicable)
- Test with TalkBack/VoiceOver

**8. Final Polish:**
- App icon design
- Splash screen
- App name finalization
- Store screenshots
- Privacy policy (if needed)
- App store descriptions

---

## Success Criteria

### Functional Requirements:
- ✅ Users can add/edit/delete chores
- ✅ Users can select one chore per day (manual or random)
- ✅ Users can mark chore as complete with satisfying animation
- ✅ Users can view completed chore history
- ✅ Users can see progress stats and timeline
- ✅ Users receive daily reminders with personality
- ✅ All data persists offline (Isar)

### Non-Functional Requirements:
- ✅ 100% test coverage
- ✅ App launch < 2 seconds
- ✅ UI interactions < 100ms response time
- ✅ Smooth 60fps animations
- ✅ No data loss
- ✅ Graceful error handling
- ✅ Accessible UI
- ✅ Works on iOS and Android

### User Experience:
- ✅ Intuitive navigation
- ✅ Beautiful, cohesive design
- ✅ Satisfying interactions
- ✅ Clear feedback for all actions
- ✅ Delightful animations

---

## Phase 1 Review: Future Improvements

**Code Review Date:** 2025-12-03
**Reviewer:** flutter-frontend-engineer agent
**Grade:** A- (92/100)

### Completed Improvements
- [x] Add tooltips to bottom nav items for accessibility
- [x] Use `package_info_plus` for dynamic version in Settings
- [x] Add "Coming soon" visual state to disabled Settings tiles

### Future Improvements (Low Priority)

These are minor enhancements to implement in later phases:

| Item | Phase | Description | Effort |
|------|-------|-------------|--------|
| **Subtle nav transitions** | Phase 3+ | Add 50-100ms crossfade between tabs for polish | 30 min |
| **Focus management** | Phase 8 | Move focus to AppBar title on tab change for screen readers | 30 min |
| **Semantic announcements** | Phase 8 | Use `Semantics(liveRegion: true)` for empty states | 1 hr |
| **Deep link support** | Phase 4+ | Add `redirect` handlers for notifications → specific screens | 1-2 hrs |
| **Error boundary widget** | Phase 3+ | Global error handling for unexpected navigation failures | 1 hr |
| **Reduced motion support** | Phase 8 | Respect `MediaQuery.disableAnimations` when adding animations | 30 min |
| **Theme switching** | Phase 4+ | Implement actual light/dark mode toggle with Riverpod state | 1-2 hrs |

### Architecture Notes
- Global navigator keys in `app_router.dart` are acceptable for single-instance app
- Consider wrapping in a provider/service for better testability in future
- ShellRoute pattern is correct for persistent bottom navigation

---

## Notes & Future Enhancements

**Possible Future Features:**
- Priority/tags for chores
- Smart suggestions based on history
- Chore templates
- Recurring chores (daily, weekly)
- Shared chores (family mode)
- Themes/customization
- Widgets (iOS/Android home screen)
- Apple Watch companion
- Export data
- Achievements/badges
- Social sharing of streaks

**Technical Debt to Watch:**
- Isar migration strategy if schema changes
- Notification reliability across OS versions
- Performance with 1000+ chores
- Battery impact of notifications

**Learning Opportunities:**
- Isar database (you'll learn this)
- Lottie animations (you'll learn this)
- flutter_local_notifications (you'll learn this)
- go_router advanced features
- fl_chart customization
- Riverpod advanced patterns

---

## How to Use This Plan

1. **We'll work phase by phase** - Complete each phase fully before moving on
2. **We'll test as we go** - Write tests alongside features, not after
3. **We'll iterate** - This plan will evolve as we learn and build
4. **We'll ask questions** - If something is unclear, we'll clarify before implementing
5. **We'll celebrate wins** - Each phase completion is a milestone!

Ready to start with Phase 0? 🚀
