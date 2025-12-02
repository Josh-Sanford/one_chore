# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

OneChore is a productivity app that helps users accomplish one task per day by limiting them to a single chore/task/to-do. Built with Flutter and follows Very Good Ventures architecture patterns.

## Project Philosophy

**Core Concept:** Many people have overwhelming to-do lists that cause paralysis and procrastination. OneChore solves this by enforcing a single constraint: **one task per day**. This limitation reduces decision fatigue and makes progress feel manageable.

**Target User:** People who get overwhelmed by long to-do lists and end up putting everything off. The app helps them build momentum by completing just one thing at a time.

**App Personality:**
- **Encouraging** - Supportive and motivational (60% of messaging)
- **Humorous** - Light-hearted and fun (25% of messaging)
- **Edgy** - Gently pushes user to take action, not too nice (15% of messaging, optional)

**Key Features:**
- Add/edit/delete chores to a list
- Select one chore per day (manually or randomly)
- Mark daily chore as complete with satisfying animation
- View completion history and progress statistics
- Daily reminders with personality
- Timeline visualization showing "days until clear"

**See Also:**
- `FEATURES.md` - Detailed feature specifications
- `IMPLEMENTATION_PLAN.md` - Phased development plan

## Developer Context

**Developer:** Flutter engineer at Very Good Ventures (VGV)

**Development Philosophy:**
- Implementation first, then write tests development with 100% coverage (required)
- Smooth, delightful animations and interactions
- Excellent UX with clear feedback and error handling
- Follow VGV best practices and architecture patterns combined with Andrea Bizzotto (from codewithandrea.com) best practices and riverpod architecture patterns
- Write clean, maintainable, well-documented code

**Development Approach:**
- Implement features phase-by-phase (see IMPLEMENTATION_PLAN.md)
- Write tests alongside feature development, not after
- Use code generation for boilerplate (freezed, riverpod_generator, isar_generator)
- Run `dart run build_runner watch` during active development
- Maintain high code quality with very_good_analysis

## Technical Decisions

### Storage: Isar
- **Why:** 10x faster than Hive, better query system, built-in indexes
- **Use Case:** Filtering pending chores, date-based queries, calculating streaks and statistics
- **Setup:** Initialize in `bootstrap.dart` before app runs
- **Code Generation:** `isar_generator` for schema classes

### Animations: Lottie + Flutter Built-ins
- **Lottie:** For celebration/confetti animations on chore completion (download from LottieFiles.com)
- **Flutter Animations:** For micro-interactions (button press, list items, transitions)
- **Goal:** Smooth, satisfying, 60fps animations throughout

### Routing: go_router
- **Why:** Declarative routing, type-safe navigation, deep linking support
- **Routes:** Home (/), Chores (/chores), History (/history), Visualization (/visualization), Settings (/settings)
- **Navigation:** Bottom nav bar for main screens, app bar settings icon

### Visualization: fl_chart
- **Why:** Mature, customizable charting library
- **Use Case:** Timeline chart showing completed vs projected chores

### Notifications: flutter_local_notifications
- **Why:** Cross-platform local notifications
- **Use Case:** Daily reminders with personality (encouraging/humorous/edgy messages)
- **Message Generator:** Random selection weighted by category distribution

## Design Principles

**Visual Design:**
- Semi-dark blue color scheme (`Color(0xFF2C5F8D)`) as seed color
- Material 3 design system
- Default to dark mode (matches "cool color scheme" vision)
- High contrast, accessible, readable typography
- Subtle shadows and elevations for depth

**Interaction Design:**
- Large, prominent primary actions (e.g., "Mark Complete" button)
- Satisfying feedback for all actions (animations, haptics if applicable)
- Clear loading states and error messages
- Empty states with helpful messaging and clear next actions
- Swipe gestures for common actions (swipe-to-delete)

**Animation Principles:**
- Smooth transitions between screens (Hero animations)
- Delightful micro-interactions (button scale on press)
- Celebratory completion animation (Lottie confetti)
- 60fps performance target
- Purposeful, not gratuitous

## Git Workflow (Trunk-Based Development)

**IMPORTANT:** Follow trunk-based development with small, frequent PRs to `main`. See `WORKFLOW.md` for complete details.

### Branch Strategy
- **`main`** - The trunk, always deployable (ONLY long-lived branch)
- **`phase-X-description`** - Short-lived feature branches (< 1-2 days)

### Trunk-Based Development Principles
- All branches merge directly to `main`
- Keep branches short-lived (ideally < 1 day)
- Small, frequent merges to `main`
- `main` is always in a deployable state
- No `develop` or other long-lived branches

### Creating PRs
1. Pull latest `main`: `git checkout main && git pull origin main`
2. Create feature branch: `git checkout -b phase-X-description`
3. Implement feature + write tests
4. Run `flutter analyze` and `flutter test` (must pass)
5. Commit with Conventional Commits: `feat:`, `fix:`, `test:`, etc.
6. Push and create PR to `main`: `gh pr create --title "[Phase X] Title"`
7. **DO NOT merge** - PRs are for review

### PR Guidelines
- **Keep PRs small** (< 500 lines ideal)
- **Keep branches short** (< 1 day ideal, < 2 days max)
- **One feature per PR** - Break phases into multiple PRs
- **Example**: Phase 2 should be ~6 small PRs, not 1 large PR
- **100% test coverage required** before creating PR
- **Merge to `main` only** (no develop branch)
- Use PR template from WORKFLOW.md

### Conventional Commits Format
```
<type>: <description>

feat: add Chore model with freezed
test: add ChoresRepository unit tests
fix: handle null case in ChoreListScreen
docs: update README with Isar setup
refactor: extract ChoreCard widget
chore: update dependencies
```

**Types:** feat, fix, test, docs, refactor, style, chore, perf

**See WORKFLOW.md for complete git workflow and Conventional Commits reference.**

## Current Development Status

**Current Phase:** Phase 0 - Dependencies & Architecture Setup (not started)

**Git Status (Trunk-Based Development):**
- Repository initialized
- Using `main` as the trunk (no `develop` branch)
- Ready to create first short-lived feature branch

**Completed:**
- ✅ Project scaffolding with very_good_cli
- ✅ Riverpod configuration (replaced Bloc)
- ✅ Initial theme setup (semi-dark blue)
- ✅ CLAUDE.md, FEATURES.md, IMPLEMENTATION_PLAN.md, WORKFLOW.md documentation
- ✅ Agent team created (4 specialized agents)

**Next Steps (Trunk-Based Workflow):**
1. Start Phase 0 with small PRs to `main`:
   - PR #1: Add dependencies to pubspec.yaml (~50 lines)
   - PR #2: Create folder structure (~20 lines)
   - PR #3: Initialize Isar in bootstrap.dart (~100 lines)
   - PR #4: Set up code generation config (~50 lines)
2. Keep each PR small and merge to `main` quickly
3. Pull `main` before each new branch

**Track Progress:** See IMPLEMENTATION_PLAN.md for detailed phase breakdown and WORKFLOW.md for git workflow

## State Management

This project uses **Riverpod** (not Bloc) for state management:
- **flutter_riverpod**: Core Riverpod functionality
- **riverpod_annotation**: For code generation with `@riverpod` annotations
- **riverpod_generator**: Code generator for providers
- **riverpod_lint**: Custom lint rules enforcing Riverpod best practices

### Provider Logging

The app includes a `ProviderLogger` in `lib/bootstrap.dart` that logs all provider updates and failures for debugging. All apps are wrapped in a `ProviderScope` with this observer.

## Architecture

### Flavor-Based Entry Points

The app uses three flavors with separate entry points:
- `lib/main_development.dart` - Development flavor
- `lib/main_staging.dart` - Staging flavor
- `lib/main_production.dart` - Production flavor

All flavors call the `bootstrap()` function from `lib/bootstrap.dart`, which:
1. Sets up Flutter error handling
2. Wraps the app in a `ProviderScope` with `ProviderLogger`
3. Initializes the app widget

### Feature Organization

Features should be organized by domain in `lib/` using a feature-first structure (similar to VGV patterns):
```
lib/
  feature_name/
    models/
    providers/
    view/
    widgets/
```

## Development Commands

### Running the App

```sh
# Development flavor
flutter run --flavor development --target lib/main_development.dart

# Staging flavor
flutter run --flavor staging --target lib/main_staging.dart

# Production flavor
flutter run --flavor production --target lib/main_production.dart
```

### Code Generation

This project uses code generation for multiple packages:
- `freezed` - Immutable data models
- `riverpod_generator` - Providers with `@riverpod` annotations
- `isar_generator` - Database schema classes
- `json_serializable` - JSON serialization (if needed)

```sh
# Watch mode (recommended during development)
dart run build_runner watch --delete-conflicting-outputs

# One-time generation
dart run build_runner build --delete-conflicting-outputs
```

**Note:** Always run build_runner in watch mode during active development to automatically regenerate code as you make changes.

### Testing

```sh
# Run all tests with coverage
very_good test --coverage --test-randomize-ordering-seed random

# Generate and view coverage report
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

### Linting and Analysis

```sh
# Run analyzer (includes custom_lint with riverpod_lint)
flutter analyze

# Format code
dart format lib test
```

## Internationalization (l10n)

- ARB files located in `lib/l10n/arb/`
- Generated localization files in `lib/l10n/gen/` (excluded from analysis)
- Access localizations via `context.l10n` (from `package:one_chore/l10n/l10n.dart`)
- To regenerate: `flutter gen-l10n --arb-dir="lib/l10n/arb"` (or run `flutter run` for automatic generation)

## Theme

The app uses a semi-dark blue color scheme (`Color(0xFF2C5F8D)`) with Material 3, defaulting to dark mode. Theme configuration is in `lib/app/view/app.dart`.

## Analysis Configuration

- Uses `very_good_analysis` for strict linting rules
- `public_member_api_docs` rule is disabled
- `custom_lint` plugin enabled for Riverpod-specific rules
- Excludes generated l10n files from analysis
