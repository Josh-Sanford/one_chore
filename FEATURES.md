# OneChore - Feature Specifications

Detailed specifications for each feature in the OneChore app.

---

## Feature 1: Chore List Management

### User Stories
- As a user, I want to add new chores to my list so I can track things I need to do
- As a user, I want to see all my pending chores in one place
- As a user, I want to delete chores I no longer need to do
- As a user, I want to optionally add descriptions to chores for more context
- As a user, I want to see when chores were created

### Technical Requirements

**Data Model:**
```dart
@freezed
class Chore with _$Chore {
  const factory Chore({
    required String id,              // UUID
    required String title,           // Required, 1-100 chars
    String? description,             // Optional, max 500 chars
    required DateTime createdAt,     // Auto-set on creation
    DateTime? completedAt,           // Set when marked complete
    @Default(false) bool isCompleted,
  }) = _Chore;
  
  factory Chore.fromJson(Map<String, dynamic> json) => _$ChoreFromJson(json);
}
```

**Repository Interface:**
```dart
abstract class ChoresRepository {
  Future<void> addChore(Chore chore);
  Future<void> deleteChore(String choreId);
  Future<void> updateChore(Chore chore);
  Future<Chore> getChoreById(String choreId);
  Future<List<Chore>> getChores();
  Stream<List<Chore>> watchPendingChores();
  Future<void> markChoreComplete(String choreId);
}
```

**Providers Needed:**
- `choresRepositoryProvider` - Singleton repository instance
- `pendingChoresProvider` - Stream of pending (non-completed) chores
- `choreListControllerProvider` - Controller for add/delete/update operations

**UI Components:**
- `ChoreListScreen` - Main screen showing all pending chores
- `AddChoreDialog` - Dialog for adding new chore with form validation
- `ChoreListItem` - Individual chore list item with swipe-to-delete
- `EmptyStateWidget` - Shown when no chores exist

**Validation Rules:**
- Title: Required, 1-100 characters
- Description: Optional, max 500 characters
- ID: Auto-generated UUID
- CreatedAt: Auto-set to current time

**UI Requirements:**
- Floating action button (FAB) to add chore
- List view sorted by creation date (newest first)
- Swipe left to delete with confirmation
- Empty state with illustration and "Add your first chore" message
- Loading indicator while operations in progress
- Error handling with user-friendly messages

**Testing Requirements:**
- Unit tests for Chore model (fromJson, toJson, copyWith, equality)
- Repository tests (add, delete, update, get, stream)
- Controller tests (add, delete operations with error cases)
- Widget tests (display list, add dialog, delete interaction, empty state)
- 100% test coverage

---

## Feature 2: Daily Chore Selection

### User Stories
- As a user, I want to select one chore for today so I know what to focus on
- As a user, I want the app to randomly select today's chore for me if I can't decide
- As a user, I want to see today's chore prominently displayed on the home screen
- As a user, I want to mark today's chore as complete with a satisfying interaction
- As a user, I want to change today's chore if I decide to do something else

### Technical Requirements

**Data Model:**
```dart
@freezed
class DailyChore with _$DailyChore {
  const factory DailyChore({
    required String choreId,         // Reference to Chore
    required DateTime date,          // Date this chore is selected for
    required bool isCompleted,       
    DateTime? completedAt,           // When user marked it complete
  }) = _DailyChore;
  
  factory DailyChore.fromJson(Map<String, dynamic> json) => 
    _$DailyChoreFromJson(json);
}
```

**Repository Interface:**
```dart
abstract class DailyChoreRepository {
  Future<DailyChore?> getDailyChore(DateTime date);
  Future<void> setDailyChore(DailyChore dailyChore);
  Future<void> completeDailyChore(DateTime date);
  Future<void> changeDailyChore(DateTime date, String newChoreId);
  Stream<DailyChore?> watchTodaysDailyChore();
}
```

**Business Logic:**
- Only ONE chore can be selected per day (enforced)
- Random selection picks from pending chores only
- If user completes chore, it's marked complete in both Chore and DailyChore
- If user doesn't complete, chore remains pending for future selection
- Can change today's chore at any time (replaces selection, doesn't delete)

**Providers Needed:**
- `dailyChoreRepositoryProvider` - Singleton repository
- `todaysDailyChoreProvider` - Stream of today's selected chore
- `dailyChoreControllerProvider` - Controller for selection and completion
- `randomChorePickerProvider` - Logic for random selection

**UI Components:**
- `DailyChoreScreen` - Home screen (main app screen)
- `DailyChoreCard` - Large card showing today's chore
- `ChoreSelectorDialog` - Dialog to manually choose from pending chores
- `CompletionButton` - Large button to mark complete with animation
- `NoDailyChoreView` - Empty state when no chore selected yet

**UI Requirements:**

**When no chore selected:**
- Large empty state with message
- "Pick for me" button (primary)
- "I'll choose" button (secondary)

**When chore selected:**
- Large card with:
  - Chore title (large, prominent)
  - Chore description (if exists)
  - Creation date
  - "Change chore" button (small, secondary)
  - "Mark Complete" button (large, primary, prominent)

**On completion:**
- Satisfying animation (confetti, checkmark, scale up)
- Success message
- Show completion time
- Option to see visualization

**Selection Dialog:**
- List of all pending chores
- Search/filter if many chores
- Tap to select
- Cancel option

**Testing Requirements:**
- Unit tests for DailyChore model
- Repository tests (get, set, complete, change)
- Controller tests (select, complete, change with error cases)
- Random selection logic tests
- Widget tests (all UI states, interactions, animations)
- 100% test coverage

---

## Feature 3: Notifications & Reminders

### User Stories
- As a user, I want daily reminders to complete my chore
- As a user, I want reminders that are encouraging but push me to take action
- As a user, I want to set what time I receive reminders
- As a user, I want to disable reminders if I don't want them
- As a user, I want the reminders to have personality and variety

### Technical Requirements

**Data Model:**
```dart
@freezed
class ReminderSettings with _$ReminderSettings {
  const factory ReminderSettings({
    @Default(true) bool enabled,
    @Default(TimeOfDay(hour: 9, minute: 0)) TimeOfDay reminderTime,
    @Default(true) bool allowEdgyMessages,
  }) = _ReminderSettings;
  
  factory ReminderSettings.fromJson(Map<String, dynamic> json) => 
    _$ReminderSettingsFromJson(json);
}
```

**Message Generator:**
```dart
enum MessageCategory {
  encouraging,  // 60% of messages
  humorous,     // 25% of messages
  edgy,         // 15% of messages
}

class MessageGenerator {
  static String getRandomMessage({required bool allowEdgy}) {
    // Implementation that randomly selects from categories
  }
  
  static const encouragingMessages = [
    "You got this! Just one thing today. 💪",
    "One chore down, productivity crown. Let's go! 👑",
    // ... more messages
  ];
  
  static const humorousMessages = [
    "Your chore called. It misses you. (It's lying.) 📞",
    // ... more messages
  ];
  
  static const edgyMessages = [
    "Still putting it off? It's ONE chore, not climbing Everest. 🏔️",
    // ... more messages
  ];
}
```

**Repository Interface:**
```dart
abstract class NotificationRepository {
  Future<void> scheduleDaily(TimeOfDay time, String message);
  Future<void> cancelAll();
  Future<bool> areNotificationsEnabled();
  Future<void> requestPermissions();
}

abstract class SettingsRepository {
  Future<ReminderSettings> getReminderSettings();
  Future<void> saveReminderSettings(ReminderSettings settings);
  Stream<ReminderSettings> watchReminderSettings();
}
```

**Notification Logic:**
- Schedule notification for specified time each day
- Generate random message based on category distribution
- Include chore title in notification if chore selected
- Handle time zone changes
- Handle app updates (reschedule notifications)
- Request permissions on first use

**Providers Needed:**
- `notificationRepositoryProvider`
- `settingsRepositoryProvider`
- `reminderSettingsProvider`
- `notificationControllerProvider`

**UI Components:**
- `NotificationSettingsScreen` - Settings for reminders
- `TimePickerWidget` - Pick reminder time
- `MessagePreviewWidget` - Show example messages

**UI Requirements:**
- Toggle switch to enable/disable notifications
- Time picker for daily reminder time
- Toggle for allowing edgy messages
- Preview button to see example messages
- Test notification button
- Permission request handling with explanation

**Platform Requirements:**
- iOS: Request notification permissions
- Android: Create notification channel
- Handle background notifications
- Handle notification tap (open app to daily chore screen)

**Testing Requirements:**
- Unit tests for message generator (category distribution)
- Repository tests (schedule, cancel, permissions)
- Settings tests (save, load, stream)
- Widget tests (settings UI, time picker)
- Test notification scheduling logic
- 100% test coverage

---

## Feature 4: Progress Visualization

### User Stories
- As a user, I want to see how many chores I have pending
- As a user, I want to see a timeline showing when I'll be done (1 per day)
- As a user, I want to see my completion streak (consecutive days)
- As a user, I want to see my overall completion rate
- As a user, I want to toggle between different time views (week, month, all)

### Technical Requirements

**Data Models:**
```dart
@freezed
class Statistics with _$Statistics {
  const factory Statistics({
    required int totalPending,
    required int totalCompleted,
    required int currentStreak,
    required int longestStreak,
    required double completionRate,  // 0.0 to 1.0
    required int daysUntilClear,
  }) = _Statistics;
}

@freezed
class TimelineDay with _$TimelineDay {
  const factory TimelineDay({
    required DateTime date,
    String? choreId,
    String? choreTitle,
    required bool isCompleted,
  }) = _TimelineDay;
}
```

**Repository Interface:**
```dart
abstract class StatsRepository {
  Future<Statistics> getStatistics();
  Future<List<TimelineDay>> getTimeline({
    required int days,
  });
  Future<int> getCurrentStreak();
  Future<double> getCompletionRate({
    required int days,
  });
}
```

**Calculation Logic:**
- **Pending Count**: Count of non-completed chores
- **Days Until Clear**: Pending count ÷ 1 (one per day)
- **Current Streak**: Consecutive days with completed chore (from today backwards)
- **Completion Rate**: Completed ÷ (Completed + Days where chore was selected but not completed)
- **Timeline**: Project pending chores forward (1 per day) starting from tomorrow

**Providers Needed:**
- `statsRepositoryProvider`
- `statisticsProvider`
- `timelineProvider`
- `visualizationControllerProvider`

**UI Components:**
- `VisualizationScreen` - Main visualization screen
- `StatsCard` - Individual stat display (pending, streak, rate)
- `TimelineChart` - Chart showing projected completion
- `StreakIndicator` - Visual streak counter with fire emoji
- `TimeViewToggle` - Toggle between week/2-week/month/all views

**Chart Requirements:**
- Use fl_chart package
- X-axis: Dates
- Y-axis: Chores (or just show bars/dots)
- Show completed vs pending in different colors
- Interactive (tap to see details)
- Smooth animations
- Responsive to different screen sizes

**UI Layout:**
- Top section: Key stats cards (3 cards in a row)
  - Total Pending
  - Current Streak (with 🔥 if > 0)
  - Completion Rate
- Middle section: "Days until clear" big number
- Bottom section: Timeline chart
- Bottom: Time view toggle (Week | 2 Weeks | Month | All)

**Visual Design:**
- Use app color scheme (blue theme)
- Completed items in success green
- Pending items in primary blue
- Current day highlighted
- Stats cards with subtle shadows
- Big, readable numbers

**Testing Requirements:**
- Unit tests for calculation logic (streak, rate, days until clear)
- Repository tests (get stats, timeline)
- Widget tests (all components, different data scenarios)
- Chart rendering tests
- Edge case tests (no chores, no completions, etc.)
- 100% test coverage

---

## Feature 5: App Routing & Navigation

### Technical Requirements

**Routes:**
```dart
- '/' (home) → DailyChoreScreen
- '/chores' → ChoreListScreen
- '/visualization' → VisualizationScreen
- '/settings' → SettingsScreen
```

**Navigation Pattern:**
- Bottom navigation bar on main screens (Home, Chores, Visualization)
- Settings accessible via icon in app bar
- Modal dialogs for add/edit operations
- Back navigation support
- Deep linking support (future)

**Providers:**
- `goRouterProvider` - Router configuration

**UI Components:**
- `AppScaffold` - Scaffold with bottom nav bar
- Bottom nav items: Home, My Chores, Progress

---

## Feature 6: Theme & Common Widgets

### Technical Requirements

**Theme:**
- Dark theme with semi-dark blue color scheme
- Consistent spacing, typography, colors
- Accessible (high contrast, readable)
- Material Design 3

**Common Widgets:**
- `PrimaryButton` - Main action buttons
- `SecondaryButton` - Secondary actions
- `EmptyStateWidget` - Generic empty states
- `ErrorView` - Generic error display
- `LoadingIndicator` - Consistent loading indicator

**Testing Requirements:**
- Widget tests for all common widgets
- Theme consistency tests
- 100% test coverage

---

## Implementation Order

**Phase 1: Foundation**
1. Project setup
2. Dependencies
3. Folder structure
4. Theme + common widgets
5. Hive initialization
6. Router setup

**Phase 2: Core Features**
1. Chore management (models, repository, UI)
2. Daily chore selection (models, repository, UI)
3. Basic navigation

**Phase 3: Enhancement**
1. Notifications system
2. Settings
3. Visualization

**Phase 4: Polish**
1. Animations
2. Error handling
3. Edge cases
4. Performance optimization
5. App store prep

---

## Non-Functional Requirements

**Performance:**
- App launch < 2 seconds
- UI interactions < 100ms response
- Smooth 60fps animations

**Reliability:**
- No data loss
- Graceful error handling
- Offline-first (local storage)

**Usability:**
- Intuitive navigation
- Clear error messages
- Accessible UI
- Consistent design

**Testability:**
- 100% test coverage
- Fast test execution
- Reliable tests (no flakiness)

**Maintainability:**
- Clean code
- Good documentation
- Consistent patterns
- Easy to extend
