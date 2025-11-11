<!--
Sync Impact Report:
- Version change: 1.2.0 -> 1.3.0
- List of modified principles:
  - Test Driven Development & Verification: Removed widget test requirement
  - Development Practices: Removed widget test requirement
- Added sections: None
- Removed sections: None
- Templates requiring updates:
  - .specify/templates/plan-template.md: ⚠ pending
  - .specify/templates/spec-template.md: ⚠ pending
  - .specify/templates/tasks-template.md: ⚠ pending
  - .specify/commands/speckit.analyze.toml: ⚠ pending
  - .specify/commands/speckit.checklist.toml: ⚠ pending
  - .specify/commands/speckit.clarify.toml: ⚠ pending
  - .specify/commands/speckit.constitution.toml: ⚠ pending
  - .specify/commands/speckit.implement.toml: ⚠ pending
  - .specify/commands/speckit.plan.toml: ⚠ pending
  - .specify/commands/speckit.specify.toml: ⚠ pending
  - .specify/commands/speckit.tasks.toml: ⚠ pending
  - README.md: ⚠ pending
- Follow-up TODOs: None
-->
# recurrent-checklist Constitution

## Core Principles

### Backend Service
The project MUST use Firebase as its primary backend service. The Firebase project ID is 'recurrent-checklist'.
The project MUST limit the usage of Firebase to Authentication and Firestore Database products only. Other Firebase products MUST NOT be used.

## Application Framework
The application MUST be built using the Flutter framework.

### Build Verification
Upon completion of any task, a successful `flutter build apk` MUST be executed to verify build correctness.

### Test Driven Development & Verification
All new features MUST include corresponding unit tests. Upon completion of any task, a successful `flutter test` MUST be executed to verify functionality correctness.

### Code Analysis and Linting
When a Dart/Flutter code file is modified, `flutter analyze` MUST be used to identify and fix potential linter issues.

## Technology Stack
The primary backend service is Firebase (Project ID: recurrent-checklist). The application framework is Flutter.

## Development Practices
All new features MUST include corresponding unit tests. Before marking a task as complete, `flutter test` and `flutter build apk` MUST be executed successfully. Additionally, `flutter analyze` MUST be run and any identified linter issues fixed when Dart/Flutter code files are modified.

## Governance
All PRs/reviews must verify compliance with these principles. Amendments to this constitution require documentation, approval, and a migration plan. This constitution supersedes all other practices.

**Version**: 1.3.0 | **Ratified**: 2025-11-10 | **Last Amended**: 2025-11-10