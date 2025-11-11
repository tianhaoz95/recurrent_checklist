<!--
Version change: old → 1.0.0
List of modified principles:
- [PROJECT_NAME] -> recurrent_checklist
- [PRINCIPLE_1_NAME] -> I. Firebase Usage
- [PRINCIPLE_1_DESCRIPTION] -> The application will exclusively use Firebase Authentication and Firebase Firestore for backend services. The Firebase project ID is 'recurrent-checklist'. No other Firebase services or external backend solutions are permitted.
- [PRINCIPLE_2_NAME] -> II. Flutter Framework
- [PRINCIPLE_2_DESCRIPTION] -> The application will be developed using the Flutter framework, adhering to its best practices and conventions for UI and business logic.
- [PRINCIPLE_3_NAME] -> III. Unit Testing Only
- [PRINCIPLE_3_DESCRIPTION] -> All new features and bug fixes must be accompanied by comprehensive unit tests. Widget tests and integration tests are explicitly disallowed to streamline the testing process.
- [PRINCIPLE_4_NAME] -> IV. Post-Task Validation
- [PRINCIPLE_4_DESCRIPTION] -> After the implementation of each task, the following commands must be executed to ensure correctness and build integrity: 'flutter test' and 'flutter build apk'.
- [SECTION_2_NAME] -> Technology Stack
- [SECTION_2_CONTENT] -> The primary technology stack for this project includes Flutter for the frontend and Firebase (Authentication and Firestore) for the backend. The Firebase project ID is 'recurrent-checklist'.
- [SECTION_3_NAME] -> Quality Assurance
- [SECTION_3_CONTENT] -> All code changes must pass unit tests. The commands 'flutter test' and 'flutter build apk' must be run and pass successfully after each task completion. No widget or integration tests are to be written.
- [GOVERNANCE_RULES] -> This Constitution outlines the foundational principles and guidelines for the 'recurrent_checklist' project. All development activities, architectural decisions, and code contributions must adhere to these principles. Amendments to this Constitution require a formal review and approval process, documented changes, and a clear migration plan for any affected components. Compliance with these rules will be verified during code reviews and quality gates.
- [CONSTITUTION_VERSION] -> 1.0.0
- [RATIFICATION_DATE] -> TODO(RATIFICATION_DATE)
- [LAST_AMENDED_DATE] -> 2025-11-10

Added sections: None (placeholders were filled)
Removed sections: None (placeholders were filled)
Templates requiring updates:
- .specify/templates/plan-template.md ✅ updated
- .specify/templates/spec-template.md ⚠ pending (no direct changes, but implicitly aligned)
- .specify/templates/tasks-template.md ✅ updated
- .specify/templates/agent-file-template.md ⚠ pending (no direct changes, but implicitly aligned)
- .specify/templates/checklist-template.md ⚠ pending (no direct changes, but implicitly aligned)

Follow-up TODOs:
- TODO(PRINCIPLE_5_DESCRIPTION): Add a fifth core principle or remove this section if not needed.
- TODO(RATIFICATION_DATE): Original adoption date for the constitution.
-->
# recurrent_checklist Constitution

## Core Principles

### I. Firebase Usage
The application will exclusively use Firebase Authentication and Firebase Firestore for backend services. The Firebase project ID is 'recurrent-checklist'. No other Firebase services or external backend solutions are permitted.

### II. Flutter Framework
The application will be developed using the Flutter framework, adhering to its best practices and conventions for UI and business logic.

### III. Unit Testing Only
All new features and bug fixes must be accompanied by comprehensive unit tests. Widget tests and integration tests are explicitly disallowed to streamline the testing process.

### IV. Post-Task Validation
After the implementation of each task, the following commands must be executed to ensure correctness and build integrity: 'flutter test' and 'flutter build apk'.

### V. [PRINCIPLE_5_NAME]
TODO(PRINCIPLE_5_DESCRIPTION): Add a fifth core principle or remove this section if not needed.

## Technology Stack

The primary technology stack for this project includes Flutter for the frontend and Firebase (Authentication and Firestore) for the backend. The Firebase project ID is 'recurrent-checklist'.

## Quality Assurance

All code changes must pass unit tests. The commands 'flutter test' and 'flutter build apk' must be run and pass successfully after each task completion. No widget or integration tests are to be written.

## Governance

This Constitution outlines the foundational principles and guidelines for the 'recurrent_checklist' project. All development activities, architectural decisions, and code contributions must adhere to these principles. Amendments to this Constitution require a formal review and approval process, documented changes, and a clear migration plan for any affected components. Compliance with these rules will be verified during code reviews and quality gates.

**Version**: 1.0.0 | **Ratified**: TODO(RATIFICATION_DATE) | **Last Amended**: 2025-11-10