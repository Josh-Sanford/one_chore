# Development Workflow

This document outlines the agile development workflow for OneChore, ensuring small, reviewable PRs and clean git history.

## Branch Strategy (Trunk-Based Development)

### The Trunk
- **`main`** - The trunk, always deployable, always working

### Feature Branches
- **Short-lived** (< 1-2 days, ideally < 1 day)
- **Small** (< 500 lines of code)
- **Merge directly to `main`**
- **Naming**: `feature/phase-X-description` or just `phase-X-description`

**Examples:**
- `phase-0-dependencies`
- `phase-1-theme-setup`
- `phase-2-chore-model`
- `phase-2-chore-repository`
- `phase-2-chore-ui-list`

### Branch Lifecycle
```
main (trunk)
 ├── feature/phase-0-dependencies → merge to main
 ├── feature/phase-1-theme-setup → merge to main
 └── feature/phase-2-chore-model → merge to main
```

**Key Principles:**
- All branches merge directly to `main`
- Keep branches short-lived (ideally same day)
- Small, frequent merges to `main`
- `main` is always in a deployable state

## Phase Breakdown into PRs

Each phase should be broken into **small, focused PRs**.

**PR Size Guidelines:**
- **Ideal**: < 500 lines (easy to review in one sitting)
- **Acceptable**: 500-1000 lines (if it's one logical unit)
- **Too Large**: > 1000 lines (should probably be split)

**Important**: Focus on **logical cohesion** over strict line counts. Some things make sense as one PR even if > 500 lines:
- Complete UI screen + widget tests (~600-800 lines)
- Repository with all CRUD methods + tests (~700 lines)
- Model + freezed + serialization + tests (~400-600 lines)

**When to split:**
- PR is doing multiple unrelated things
- PR is > 1000 lines
- Review is taking too long
- Hard to understand what changed

### Example: Phase 2 (Chore Management)

**Large Phase → Multiple Small PRs:**

1. **PR #1**: `feature/phase-2-chore-model`
   - Create `Chore` model with freezed
   - Add code generation
   - Unit tests for model
   - ~100 lines

2. **PR #2**: `feature/phase-2-chore-repository`
   - Define `ChoresRepository` interface
   - Implement `IsarChoresRepository`
   - Repository unit tests
   - ~200 lines

3. **PR #3**: `feature/phase-2-chore-providers`
   - Create Riverpod providers
   - `choresRepositoryProvider`
   - `pendingChoresProvider`
   - `choreListControllerProvider`
   - Provider tests
   - ~150 lines

4. **PR #4**: `feature/phase-2-chore-ui-list`
   - `ChoreListScreen`
   - `ChoreListItem` widget
   - Empty state
   - Widget tests
   - ~200 lines

5. **PR #5**: `feature/phase-2-chore-ui-add`
   - `AddChoreDialog`
   - Form validation
   - Widget tests
   - ~150 lines

6. **PR #6**: `feature/phase-2-chore-ui-edit`
   - `EditChoreDialog`
   - Widget tests
   - ~100 lines

**Total**: 6 small, reviewable PRs instead of 1 massive PR

## PR Workflow

### 1. Start New Feature
```bash
# Ensure main is up to date
git checkout main
git pull origin main

# Create short-lived feature branch
git checkout -b phase-X-description

# Start working...
```

### 2. Development Cycle
- Implement feature (keep it small!)
- Write tests (achieve 100% coverage)
- Run `flutter analyze` (must pass)
- Run `flutter test` (must pass)
- Commit frequently with clear messages
- **Goal**: Complete and merge within same day if possible

### 3. Commit Messages (Conventional Commits)
Follow [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>: <description>

[optional body]
[optional footer]
```

**Types:**
- `feat:` New feature
- `fix:` Bug fix
- `test:` Adding tests
- `refactor:` Code refactoring
- `docs:` Documentation
- `style:` Formatting, no code change
- `chore:` Maintenance tasks

**Examples:**
```
feat: add Chore model with freezed

- Create Chore class with all fields
- Add freezed annotation for immutability
- Add JSON serialization
- Generate code with build_runner

Closes #12
```

```
test: add ChoresRepository unit tests

- Test addChore success and error cases
- Test deleteChore with validation
- Test watchPendingChores stream
- Achieve 100% coverage for repository

Part of #15
```

```
feat: implement ChoreListScreen UI

- Create main list screen with pending chores
- Add empty state widget
- Add FAB for adding chores
- Add swipe-to-delete interaction
- Add widget tests

Closes #18
```

### 4. Before Creating PR
```bash
# Ensure all tests pass
flutter test

# Ensure no lint errors
flutter analyze

# Ensure code is formatted
dart format lib test

# Review your changes against main
git diff main

# Push branch
git push -u origin phase-X-description
```

### 5. Create Pull Request

**PR Title Format:**
```
[Phase X] Feature description
```

**Examples:**
- `[Phase 2] Add Chore model with freezed`
- `[Phase 2] Implement ChoresRepository with Isar`
- `[Phase 2] Build ChoreListScreen UI`

**PR Description Template:**
```markdown
## Summary
Brief description of what this PR does.

## Changes
- Bullet point list of changes
- What was added/modified/removed

## Testing
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] 100% coverage achieved for new code
- [ ] All tests pass locally
- [ ] `flutter analyze` passes

## Screenshots (if UI changes)
[Add screenshots here]

## Checklist
- [ ] Code follows project conventions
- [ ] Tests written and passing
- [ ] Documentation updated (if needed)
- [ ] No lint errors
- [ ] Ready for review

## Related Issues
Closes #XX
Part of #YY
```

### 6. PR Review & Merge

**Review Checklist:**
- Code quality and readability
- Tests are comprehensive (100% coverage)
- Follows architecture patterns
- No unnecessary complexity
- Proper error handling
- Accessible UI (if applicable)
- `main` remains deployable after merge

**Merge Strategy (Trunk-Based Development):**
- Merge directly to `main` (no develop branch)
- Use **Squash and Merge** for clean history
- Delete branch immediately after merge
- Pull latest `main` locally

```bash
# After PR is merged
git checkout main
git pull origin main
git branch -d phase-X-description  # Delete local branch
```

**Important:** In trunk-based development, `main` is the only long-lived branch. Everything merges to `main` and `main` is always deployable.

## Phase Workflow

### Starting a Phase

1. **Plan the PRs**
   - Break phase into small, logical PRs
   - Create GitHub issues for each PR
   - Assign issues to project board

2. **Work on PRs Sequentially (Trunk-Based)**
   - Complete PR #1 (implement + test + review + merge to `main`)
   - Pull latest `main`
   - Complete PR #2 (implement + test + review + merge to `main`)
   - Pull latest `main`
   - Continue until phase is complete

3. **Phase Completion**
   - All PRs merged to `main`
   - `main` is deployable with all phase features
   - Phase marked complete in IMPLEMENTATION_PLAN.md
   - Update CLAUDE.md "Current Development Status"

### Example: Starting Phase 2

**Step 1: Create Issues**
- Issue #10: Add Chore model
- Issue #11: Implement ChoresRepository
- Issue #12: Create Chore providers
- Issue #13: Build ChoreListScreen
- Issue #14: Add AddChoreDialog
- Issue #15: Add EditChoreDialog

**Step 2: Work Through Issues (Trunk-Based)**
```bash
# Work on Issue #10
git checkout main
git pull origin main
git checkout -b phase-2-chore-model

# Implement, test, commit
git commit -m "feat: add Chore model with freezed"
git push -u origin phase-2-chore-model

# Create PR, get review, merge to main

# Pull latest main before next PR
git checkout main
git pull origin main

# Repeat for each issue...
```

**Step 3: Complete Phase**
- All issues closed
- Update docs
- Move to Phase 3

## Working with Agents

Agents should follow this workflow:

**When starting work:**
1. Create feature branch
2. Implement feature
3. Write comprehensive tests
4. Run analysis and tests
5. Commit with clear message
6. Create PR with proper description

**Example prompt for agent:**
```
Use the flutter-frontend-engineer agent to:
1. Ensure main is up to date (git pull origin main)
2. Create branch: phase-2-chore-list-ui
3. Implement ChoreListScreen
4. Write widget tests
5. Ensure 100% coverage
6. Commit with message: "feat: implement ChoreListScreen UI"
7. Create PR targeting main branch

DO NOT merge - just create the PR for review.
```

## Best Practices

### ✅ Do This (Trunk-Based Development)
- Keep PRs small (< 500 lines ideal)
- Keep branches short-lived (< 1 day ideal, < 2 days max)
- Merge to `main` frequently (multiple times per day when possible)
- Write tests with implementation
- Commit frequently with conventional commits format
- Pull `main` before starting new work
- Create PR when ready for review
- Review your own PR before requesting review
- Update documentation when needed
- Ensure `main` stays deployable after every merge

### ❌ Don't Do This
- Massive PRs with multiple features
- Long-lived feature branches (> 2 days)
- Committing without tests
- Vague commit messages ("fix stuff", "updates")
- Committing directly to `main` (always use PR)
- Creating long-lived branches like `develop` (trunk-based = `main` only)
- Leaving branches open for weeks
- Skipping code review
- Merging without tests passing
- Breaking `main` (it must always be deployable)

## CI/CD Integration (Future)

When CI is set up:
- PRs must pass CI checks before merge
- Automated tests run on every push
- Code coverage reported
- Lint checks enforced

## Quick Reference (Trunk-Based Development)

```bash
# Start new feature
git checkout main && git pull origin main
git checkout -b phase-X-name

# Commit work (Conventional Commits)
git add .
git commit -m "feat: description"
# or: fix:, test:, docs:, refactor:, style:, chore:

# Push and create PR (merges to main)
git push -u origin phase-X-name
gh pr create --title "[Phase X] Title" --body "Description"

# After PR merged to main
git checkout main && git pull origin main
git branch -d phase-X-name

# Start next feature (repeat)
git checkout -b phase-X-next-name
```

## Conventional Commits Quick Reference

**Format:**
```
<type>: <description>

[optional body]
[optional footer]
```

**Types:**
- `feat:` - New feature (user-facing)
- `fix:` - Bug fix
- `test:` - Adding/updating tests
- `refactor:` - Code restructuring without changing behavior
- `docs:` - Documentation changes
- `style:` - Code formatting, no logic change
- `chore:` - Maintenance, dependencies, build config
- `perf:` - Performance improvements

**Examples:**
```
feat: add Chore model with freezed annotations
fix: handle null case in ChoreListScreen empty state
test: add ChoresRepository unit tests
docs: update README with setup instructions
refactor: extract ChoreCard to separate widget
style: format code with dart format
chore: update dependencies to latest versions
perf: add index to Isar createdAt field
```

**Breaking Changes:**
```
feat!: change Chore id field to UUID

BREAKING CHANGE: Chore.id is now String (UUID) instead of int
```

## Current Status (Trunk-Based Development)

- **Main Branch (`main`)**: The trunk - always deployable
- **No Develop Branch**: We use trunk-based development
- **Current Phase**: Phase 0 (not started)
- **Next Steps**:
  1. Ensure git repository initialized
  2. Start Phase 0 with first PR to `main`
  3. Keep branches short-lived (< 1 day)
  4. Merge frequently to `main`

---

**Remember**: Small, frequent PRs are easier to review, test, and debug than large monolithic ones. When in doubt, split it up! 🚀
