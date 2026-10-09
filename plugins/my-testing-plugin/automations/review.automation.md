---
version: 1
id: testing-review
name: Testing review
description: "Review current workspace changes for regressions and missing test coverage without editing files or running tests."
schedule:
  kind: manual
---

Follow the consuming workspace's instructions. Review the current changes and relevant tests using the `test-reviewer` agent when available. If it is unavailable, apply its read-only review boundaries directly. Do not edit files, run test commands, install dependencies, access production services, or change infrastructure.

Establish the change scope using available read-only evidence. If no diff or change scope is available, request the intended files or comparison rather than assuming the whole repository changed. Prioritize correctness defects, regressions, security risks, missing edge-case assertions, flaky tests, and gaps in supplied test execution evidence.

Return findings ordered by severity with file and line references, concrete failing scenarios, and suggested focused checks. Say explicitly when no issues are found and identify checks that remain unexecuted. Never claim tests passed without actual runner evidence.