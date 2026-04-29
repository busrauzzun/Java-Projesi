---
name: testing
description: Use when writing or modifying tests for this Spring Boot Task API. Covers JUnit 5, MockMvc, @MockitoBean usage, naming conventions, and how to run the suite.
---

# Testing guidance for task-api

This project uses JUnit 5 + Spring Boot Test + MockMvc, all pulled in via `spring-boot-starter-test`. Mocking is done with Mockito's Spring integration (`@MockitoBean`).

## Layout

- All tests live under `src/test/java`, mirroring the package of the class under test.
- One test class per production class. Name it `<ClassName>Test`.
- Methods use camelCase describing the behavior, not the method (`createReturns201`, not `testCreate`).

## Choosing a test style

| Need                                           | Use                                      |
|------------------------------------------------|------------------------------------------|
| Plain logic, no Spring context needed          | Plain JUnit + Mockito                    |
| Controller wiring, validation, status codes    | `@SpringBootTest` + `@AutoConfigureMockMvc` |
| Repository queries against H2                  | `@DataJpaTest`                           |
| Full app with embedded server (rare)           | `@SpringBootTest(webEnvironment = RANDOM_PORT)` |

Default to the smallest slice that still exercises the seam you care about.

## Mocking dependencies

Use `@MockitoBean` (Spring Boot 3.4+) to replace beans in the application context:

```java
@MockitoBean
private TaskRepository repository;
```

Do **not** mix `@MockBean` (deprecated) and `@MockitoBean` in the same test class.

For pure unit tests with no Spring context, use `@ExtendWith(MockitoExtension.class)` + `@Mock` instead.

## MockMvc patterns

- Build JSON payloads with `ObjectMapper`, not hand-written strings.
- Assert on status first, then body via `jsonPath`.
- For 201 Created, also assert the `Location` header.
- For 400 validation cases, assert status only — don't lock in error message format unless the API contract requires it.

## What every CRUD endpoint test class should cover

1. Happy path for each verb (GET list, GET by id, POST, PUT, DELETE).
2. 404 for GET / PUT / DELETE on unknown id.
3. 400 for at least one invalid POST body (e.g. blank required field).
4. Verification that the repository was called when the side effect matters (`verify(repository).deleteById(1L)`).

## What to avoid

- No `Thread.sleep` in tests. If something is async, await on a deterministic signal.
- No reliance on database state from a previous test. Each test must set up what it needs.
- No assertions on log output. Logs are not part of the contract.
- No `@Disabled` without a linked issue and a reason in the annotation's value.

## Running

```bash
./mvnw test            # full suite
./mvnw -Dtest=TaskControllerTest test   # one class
```

CI must run the full suite; do not skip with `-DskipTests` in committed scripts.
