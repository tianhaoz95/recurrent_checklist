# Recurrent Checklist Constitution
<!--
Sync Impact Report:
- Version change: 1.1.0 -> 1.1.1
- List of modified principles:
  - Development Workflow (clarified to include build and test checks during development)
- Added sections: N/A
- Removed sections: N/A
- Templates requiring updates:
  - .specify/templates/plan-template.md: ✅ (No direct changes needed, but process should align)
  - .specify/templates/spec-template.md: ✅ (No direct changes needed, but process should align)
  - .specify/templates/tasks-template.md: ✅ (No direct changes needed, but process should align)
  - README.md: ✅ (No direct changes needed, but content reflects principles)
- Follow-up TODOs: None
-->

## Core Principles

### I. User-Centric Design
All features and UI/UX decisions must prioritize the end-user experience, focusing on clarity, ease of use, and efficiency for managing recurrent tasks. The application should be intuitive and accessible.

### II. Data Integrity & Persistence
Checklist data must be stored reliably and synchronized consistently across devices. Firebase Firestore is the primary data store, and all data operations must ensure integrity, prevent loss, and handle conflicts gracefully.

### III. Cross-Platform Consistency
The application must provide a consistent look, feel, and functionality across all supported platforms (Android, iOS, Web, etc.). Platform-specific optimizations should not compromise the core user experience or introduce significant divergence.

### IV. Test-Driven Development (TDD)
All new features, bug fixes, and significant refactorings must adhere to a Test-Driven Development (TDD) workflow. Tests must be written and approved before implementation, ensuring comprehensive coverage and validating requirements. The Red-Green-Refactor cycle is strictly enforced.

### V. Security & Privacy
User authentication and data handling must adhere to best security practices. User data privacy is paramount, and all sensitive information must be protected through appropriate encryption and access controls.

## Technology Stack
The project is built using Flutter for the frontend and Firebase (Authentication, Firestore) for backend services. All new dependencies must be approved and align with the existing technology stack.

## Development Workflow
All code changes require a pull request (PR) before merging to the main branch. During each step in development, use 'flutter build apk' to check for build errors and 'flutter test' to check for logic errors. Automated tests (unit, widget, integration) must pass, and code quality checks (linting, formatting) must be clear. Deployment to production follows a staged release process.

## Governance
This Constitution supersedes all other development practices. Amendments require a formal proposal, team discussion, and majority approval. Versioning follows semantic versioning rules (MAJOR.MINOR.PATCH). Compliance reviews will be conducted quarterly.

**Version**: 1.1.1 | **Ratified**: 2025-11-12 | **Last Amended**: 2025-11-12