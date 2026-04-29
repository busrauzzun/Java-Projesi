# task-api

Basit bir **Task CRUD API** (Spring Boot + Spring Web + Spring Data JPA + H2).

## Görevler (Project Tasks)

### Geliştirme görevleri

- **Build**: Maven ile derleme/paketleme
  - `./mvnw clean package`
- **Test**: Unit/integration testlerini çalıştırma
  - `./mvnw test`
- **Run**: Uygulamayı lokal çalıştırma
  - `./mvnw spring-boot:run`

### Operasyonel görevler (config/log)

- **Konfigürasyon**: `src/main/resources/application.properties`
  - Port: `server.port=8080`
  - DB: In-memory H2 (`spring.datasource.url=jdbc:h2:mem:taskdb`)
  - H2 Console: `spring.h2.console.enabled=true`, path: `/h2-console`
- **Loglar**: Spring Boot logging ayarları `application.properties` içinde
  - Root level: `INFO`
  - `com.example.taskapi`: `DEBUG`
  - Console pattern: `logging.pattern.console=...`

### Kod kalitesi

- Projede **format/lint** için ayrı bir araç (Checkstyle/Spotless/PMD vb.) tanımlı değil (pom.xml içinde görünmüyor).
- Validasyon: `jakarta.validation` anotasyonları ile (`@Valid`, `@NotBlank`, `@Size`).

### API kullanımı

Controller: `com.example.taskapi.TaskController` (base path: `/api/tasks`)

- `GET /api/tasks`
  - Opsiyonel filtre: `?completed=true|false` (diğer değerlerde 400)
- `GET /api/tasks/{id}`
  - Bulunamazsa 404
- `POST /api/tasks`
  - Body: `Task` (validasyon var)
  - Başarılı: 201 + `Location: /api/tasks/{id}`
- `PUT /api/tasks/{id}`
  - Body: `Task` (validasyon var)
- `DELETE /api/tasks/{id}`
  - Başarılı: 204

### Katkı akışı

- Değişiklik öncesi/sonrası testleri çalıştırın: `./mvnw test`
- Küçük ve odaklı commit’ler tercih edin.
- Yeni endpoint/iş kuralı eklenirse ilgili testleri `src/test/java` altına ekleyin/güncelleyin.
