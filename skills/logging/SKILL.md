---
name: logging
description: Use when adding, reviewing, or debugging log statements in this Spring Boot Task API. Covers SLF4J usage, log levels, structured messages, and what should/shouldn't be logged in service and controller layers.
---

# Logging guidance for task-api

This project uses SLF4J via Spring Boot's default Logback. Follow the rules below whenever adding or modifying log statements.

## Logger declaration

Always declare loggers as `private static final` and use the enclosing class:

```java
private static final Logger log = LoggerFactory.getLogger(TaskService.class);
```

Do not use `System.out` / `System.err` anywhere in `src/main`.

## Levels

- `ERROR` — unrecoverable failures the operator must see (DB down, unexpected exceptions bubbling out of the service layer). Always include the `Throwable` as the last argument.
- `WARN` — recoverable issues or suspicious states (validation failure on a known-good code path, retry triggered).
- `INFO` — state changes worth seeing in production: task created, updated, deleted. Keep one INFO line per business action.
- `DEBUG` — diagnostic detail useful while developing or investigating an incident. Enabled in `application.properties` for `com.example.taskapi`.
- `TRACE` — only for short-term debugging. Do not commit TRACE statements that survive a feature.

## Message format

Use SLF4J parameterized messages — never string concatenation:

```java
// good
log.info("Created task id={} title={}", saved.getId(), saved.getTitle());

// bad — builds the string even when INFO is disabled
log.info("Created task id=" + saved.getId());
```

Prefer `key=value` style for fields so logs grep cleanly. Lowercase keys, no spaces.

## What to log

- Service layer: log INFO on every mutation (create / update / delete) with the entity id.
- Controller layer: do **not** add request-entry/exit logs by hand — Spring's access log and `DEBUG` on the web layer cover it.
- Exceptions caught and rethrown: log at the level appropriate for the rethrown type, and never lose the cause.

## What NOT to log

- No PII or request bodies that may contain user data.
- No full stack traces at INFO/DEBUG — use `log.error("msg", ex)` so Logback formats once.
- No log inside tight loops without a guard (`if (log.isDebugEnabled())`).

## Configuration

Levels live in `src/main/resources/application.properties`:

```
logging.level.root=INFO
logging.level.com.example.taskapi=DEBUG
```

When changing log behavior, update that file rather than scattering `Logger.setLevel` calls.
