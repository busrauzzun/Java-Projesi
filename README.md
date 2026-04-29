# task-api

Spring Boot (Java 17) ile geliştirilmiş basit bir **Task CRUD REST API**.

- Framework: Spring Boot 3.3.4
- Modüller: Spring Web, Spring Data JPA, Validation
- Veritabanı: H2 (in-memory)

## İçerik

- [Proje Özeti](#proje-özeti)
- [Gereksinimler](#gereksinimler)
- [Kurulum ve Çalıştırma](#kurulum-ve-çalıştırma)
- [Konfigürasyon](#konfigürasyon)
- [API](#api)
- [Build ve Test](#build-ve-test)
- [Klasör Yapısı](#klasör-yapısı)
- [Release / Versiyonlama](#release--versiyonlama)

## Proje Özeti

Bu proje, `Task` entity’si için CRUD işlemlerini sağlayan bir REST API sunar.

- Base URL: `http://localhost:8080`
- API base path: `/api/tasks`
- Kalıcılık: Spring Data JPA + H2 in-memory (`jdbc:h2:mem:taskdb`)

## Gereksinimler

- Java 17
- Maven (veya projedeki Maven Wrapper: `./mvnw`)

## Kurulum ve Çalıştırma

### Uygulamayı çalıştırma

```bash
./mvnw spring-boot:run
```

Uygulama varsayılan olarak `http://localhost:8080` üzerinde ayağa kalkar (`server.port=8080`).

### Jar olarak çalıştırma

```bash
./mvnw clean package
java -jar target/task-api-0.0.1-SNAPSHOT.jar
```

### H2 Console

H2 Console aktiftir:

- URL: `http://localhost:8080/h2-console` (`spring.h2.console.path=/h2-console`)
- JDBC URL: `jdbc:h2:mem:taskdb` (`spring.datasource.url`)
- Kullanıcı adı: `sa` (`spring.datasource.username`)
- Şifre: (boş) (`spring.datasource.password`)

## Konfigürasyon

Konfigürasyon dosyası: `src/main/resources/application.properties`

Varsayılan ayarlar:

- Uygulama adı: `spring.application.name=task-api`
- Port: `server.port=8080`
- H2 (in-memory) datasource:
  - `spring.datasource.url=jdbc:h2:mem:taskdb`
  - `spring.datasource.driver-class-name=org.h2.Driver`
  - `spring.datasource.username=sa`
  - `spring.datasource.password=`
- JPA:
  - `spring.jpa.hibernate.ddl-auto=update`
  - `spring.jpa.show-sql=false`
- H2 Console:
  - `spring.h2.console.enabled=true`
  - `spring.h2.console.path=/h2-console`
- Logging:
  - `logging.level.root=INFO`
  - `logging.level.com.example.taskapi=DEBUG`
  - `logging.pattern.console=%d{yyyy-MM-dd HH:mm:ss} %-5level [%thread] %logger{36} - %msg%n`

## API

Base path: `/api/tasks`

### Model: `Task`

Alanlar (entity):

- `id: Long` (otomatik üretilir)
- `title: String` (zorunlu, `@NotBlank`, max 200)
- `description: String` (opsiyonel, max 2000)
- `completed: boolean`

### Endpoint’ler

- `GET /api/tasks`
  - Tüm task’leri listeler.
  - Opsiyonel filtre: `?completed=true|false`
  - `completed` parametresi `true/false` dışında bir değer alırsa **400** döner (`BadRequestException`).

- `GET /api/tasks/{id}`
  - Tek bir task döner.
  - Bulunamazsa **404** döner (`TaskNotFoundException`).

- `POST /api/tasks`
  - Yeni task oluşturur.
  - Body: `Task` (validasyon uygulanır).
  - Başarılı: **201** ve `Location: /api/tasks/{id}` header’ı.

- `PUT /api/tasks/{id}`
  - Var olan task’i günceller.
  - Body: `Task` (validasyon uygulanır).

- `DELETE /api/tasks/{id}`
  - Task’i siler.
  - Başarılı: **204**
  - ID yoksa **404**

### Örnek İstekler

Task oluşturma:

```bash
curl -i -X POST "http://localhost:8080/api/tasks" \
  -H "Content-Type: application/json" \
  -d '{"title":"learn spring","description":"do it","completed":false}'
```

Task listeleme:

```bash
curl -i "http://localhost:8080/api/tasks"
```

Listeleme (filtreli):

```bash
curl -i "http://localhost:8080/api/tasks?completed=true"
```

Task güncelleme:

```bash
curl -i -X PUT "http://localhost:8080/api/tasks/42" \
  -H "Content-Type: application/json" \
  -d '{"title":"learn spring","description":"updated","completed":true}'
```

Task silme:

```bash
curl -i -X DELETE "http://localhost:8080/api/tasks/42"
```

## Build ve Test

### Build / Paketleme

```bash
./mvnw clean package
```

### Test

```bash
./mvnw test
```

Alternatif olarak:

```bash
./mvnw clean verify
```

## Klasör Yapısı

- `src/main/java/com/example/taskapi`
  - `TaskApiApplication`: Spring Boot main class
  - `TaskController`: REST controller (`/api/tasks`)
  - `TaskService`: iş mantığı
  - `TaskRepository`: JPA repository
  - `Task`: JPA entity
  - `BadRequestException`, `TaskNotFoundException`: HTTP status mapping
- `src/main/resources/application.properties`: uygulama konfigürasyonu
- `src/test/java/com/example/taskapi/TaskControllerTest`: controller seviyesinde MockMvc testleri

## Release / Versiyonlama

- Maven artifact: `com.example:task-api:0.0.1-SNAPSHOT` (bkz. `pom.xml`).


