# task-api

Spring Boot (Java 17) ile geliştirilmiş basit bir **Task CRUD REST API** (H2 in-memory).

## Özet

- Base URL: `http://localhost:8080`
- Task API: `/api/tasks`
- Health: `GET /api/health` → `{"status":"UP"}`
- Health v2: `GET /api/health/v2` → `{"status":"UP","timestamp":"...","appName":"task-api","version":"0.0.1-SNAPSHOT"}`

## Gereksinimler

- Java 17
- Maven veya Maven Wrapper (`./mvnw`)

## Komutlar

```bash
# build
./mvnw clean package

# run
./mvnw spring-boot:run
# veya
java -jar target/task-api-0.0.1-SNAPSHOT.jar

# test
./mvnw test
# veya
./mvnw verify
```

## Key Endpoints

Base path: `/api/tasks`

- `GET /api/tasks` (opsiyonel: `?completed=true|false`)
- `GET /api/tasks/{id}`
- `POST /api/tasks`
- `PUT /api/tasks/{id}`
- `DELETE /api/tasks/{id}`

Notlar:
- H2 Console: `http://localhost:8080/h2-console` (JDBC: `jdbc:h2:mem:taskdb`, user: `sa`, password: boş)


