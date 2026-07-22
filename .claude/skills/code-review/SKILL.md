---
name: code-review
description: This skill should be used when the user wants to "review code", "perform code review", "analyze code quality", "check for security issues", "review functional coverage", or needs a comprehensive functional assessment of production code. Use this skill when the user requests analysis from a senior engineer perspective.
metadata:
  version: 1.0.0
---

# Code Review

This skill provides comprehensive functional code review from a senior engineer perspective, analyzing security, race conditions, test coverage, best practices, and design patterns.

## When to Use This Skill

Use this skill when the user requests:

- Code review or code analysis
- Security audit or vulnerability assessment
- Functional coverage analysis
- Best practices verification
- Review of production code quality
- Analysis of current changes for quality issues

## Input Requirements

### Required

- **Production Code Reference**: At least one entry point file or set of files to review
  - User may specify explicit files or folders
  - User may request review of "current changes" (use git diff to identify modified files)

### Optional

- **Test Files**: Explicit references to test files
  - If not provided, only flag if tests appear to be completely missing from the codebase

## Review Process

### 1. Determine Scope

First, clarify what code to review:

- If user mentions specific files/folders, use those as entry points
- If user says "review current changes" or "review my changes", use git diff to find modified files
- Analyze files referenced from entry points (imports, dependencies, etc.)

### 2. Gather Context

Before analyzing, collect:

- **Design Rules**: Check for `docs/` folder and read any design/architecture guidelines
- **Language/Framework**: Identify the tech stack to apply appropriate best practices
- **Existing Tests**: Search for test files (_.test._, _.spec._, _\_test._, test/_, tests/_)
- **Project Structure**: Understand the codebase organization

### 3. Analyze Code

Review the code systematically for:

#### Security Issues

- Input validation vulnerabilities
- Authentication/authorization flaws
- Data exposure risks
- Injection vulnerabilities (SQL, XSS, command injection)
- Insecure dependencies or configurations
- Secrets or credentials in code
- Cryptographic weaknesses

**Severity Guidelines:**

- **Critical**: Remote code execution, data breach potential, exposed secrets
- **High**: Authentication bypass, privilege escalation, significant data exposure
- **Medium**: Missing input validation, weak cryptography, insecure defaults
- **Low**: Information disclosure, security hardening opportunities

#### Race Conditions

- Concurrent access to shared resources
- Time-of-check to time-of-use (TOCTOU) issues
- Improper synchronization
- Deadlock potential
- Non-atomic operations that should be atomic

**Severity Guidelines:**

- **Critical**: Data corruption, financial inconsistency
- **High**: Frequent occurrence potential, user-facing impact
- **Medium**: Edge case conditions, difficult to trigger
- **Low**: Rare scenarios, minimal impact

#### Missing Test Coverage

- Critical functional paths without tests
- Edge cases not covered
- Error handling not tested
- Integration points lacking tests
- Business logic without validation

**Severity Guidelines:**

- **Critical**: Core business logic, payment flows, security features untested
- **High**: Main user workflows, data mutations untested
- **Medium**: Secondary features, error paths untested
- **Low**: Utility functions, simple getters/setters untested

#### Coding Best Practices

- Code smells and anti-patterns
- Inconsistent naming or style
- Poor error handling
- Lack of input validation
- Tight coupling and low cohesion
- Missing documentation for complex logic
- Performance issues
- Language/framework-specific violations

**Severity Guidelines:**

- **Critical**: Patterns that will cause production failures
- **High**: Maintainability risks, likely to cause bugs
- **Medium**: Code smells, technical debt
- **Low**: Style issues, minor optimizations

#### Design Rule Violations

- Violations of documented architecture patterns (from docs/)
- Inconsistency with established patterns in codebase
- Separation of concerns issues
- Architectural anti-patterns

**Severity Guidelines:**

- **Critical**: Violates core architectural principles
- **High**: Significant deviation from established patterns
- **Medium**: Minor inconsistencies with design docs
- **Low**: Style or organizational preferences

### 4. Provide Suggestions

For each issue identified, provide:

- **Clear explanation** of the problem
- **Impact description** (what could go wrong)
- **Code suggestion** showing how to fix it
- **Severity level** (Critical/High/Medium/Low)

## Output Format

Generate a report file named `REPORT.md` in the workspace root with the following structure:

### Report Structure

Use the template from [REPORT_TEMPLATE.md](REPORT_TEMPLATE.md) which includes:

1. **Executive Summary**
   - Overall code quality assessment
   - Key findings overview
   - Recommendation priority

2. **Issue Summary Table**
   - Breakdown by severity (Critical/High/Medium/Low) and category
   - Total counts for each combination

3. **Detailed Issues by Severity**
   - 🔴 Critical Issues
   - 🟠 High Priority Issues
   - 🟡 Medium Priority Issues
   - 🟢 Low Priority Issues

Each issue should include:

- Title and category
- File and line references (linked)
- Problem description
- Impact explanation
- Suggested fix with code examples
- Additional notes or context

4. **Summary and Recommendations**
   - Action items prioritized
   - Next steps

### After Generating Report

1. **Save REPORT.md** to the workspace root
2. **Update .gitignore**: Check if `REPORT.md` is already ignored. If not, add it:
   ```
   # Code review reports
   REPORT.md
   ```
3. **Inform user**: Let them know the report has been created and where to find it

## Best Practices

- **Be thorough but practical**: Focus on issues that matter, not nitpicks
- **Provide context**: Explain why something is an issue, not just what
- **Be constructive**: Frame issues as improvement opportunities
- **Prioritize**: Use severity levels consistently to help users focus on critical items first
- **Link to resources**: Reference official docs or security advisories when relevant
- **Consider the codebase**: Apply standards appropriate to the project's maturity and constraints

## Example Usage Scenarios

### Scenario 1: Review Specific File

```
User: "Review src/api/payment-handler.ts"
```

- Read the file
- Check for tests
- Analyze for issues
- Generate REPORT.md

### Scenario 2: Review Current Changes

```
User: "Review my current changes"
```

- Run git diff to find modified files
- Analyze those files and their dependencies
- Generate REPORT.md focused on the changes

### Scenario 3: Full Module Review

```
User: "Review the authentication module in src/auth/"
```

- Read all files in src/auth/
- Check for related tests
- Review design docs if available
- Generate comprehensive REPORT.md

### Scenario 4: Review with Test Files

```
User: "Review src/checkout/cart.ts and check tests/checkout/cart.test.ts"
```

- Review production code
- Review test coverage against production code
- Identify missing test cases
- Generate REPORT.md

## Notes

- Always read design documentation from `docs/` if it exists
- Adapt best practices to the specific language and framework being used
- Consider both functional correctness and maintainability
- Balance thoroughness with practicality - focus on meaningful issues
- When in doubt about severity, err on the side of higher severity for security issues
