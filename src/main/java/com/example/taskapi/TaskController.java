package com.example.taskapi;

import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/tasks")
public class TaskController {

    private final TaskService service;

    public TaskController(TaskService service) {
        this.service = service;
    }

    @GetMapping
    public List<Task> list(@RequestParam(required = false) String completed) {
        if (completed == null) {
            return service.findAll();
        }

        if (completed.equalsIgnoreCase("true")) {
            return service.findAllByCompleted(true);
        }
        if (completed.equalsIgnoreCase("false")) {
            return service.findAllByCompleted(false);
        }

        throw new BadRequestException("Invalid completed value: " + completed);
    }

    @GetMapping("/{id}")
    public Task get(@PathVariable Long id) {
        return service.findById(id);
    }

    @PostMapping
    public ResponseEntity<Task> create(@Valid @RequestBody Task task) {
        Task created = service.create(task);
        return ResponseEntity
                .created(URI.create("/api/tasks/" + created.getId()))
                .body(created);
    }

    @PutMapping("/{id}")
    public Task update(@PathVariable Long id, @Valid @RequestBody Task task) {
        return service.update(id, task);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
