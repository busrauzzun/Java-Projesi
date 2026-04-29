package com.example.taskapi;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaskService {

    private static final Logger log = LoggerFactory.getLogger(TaskService.class);

    private final TaskRepository repository;

    public TaskService(TaskRepository repository) {
        this.repository = repository;
    }

    public List<Task> findAll() {
        return repository.findAll();
    }

    public Task findById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new TaskNotFoundException(id));
    }

    public Task create(Task task) {
        Task saved = repository.save(task);
        log.info("Created task id={} title={}", saved.getId(), saved.getTitle());
        return saved;
    }

    public Task update(Long id, Task incoming) {
        Task existing = findById(id);
        existing.setTitle(incoming.getTitle());
        existing.setDescription(incoming.getDescription());
        existing.setCompleted(incoming.isCompleted());
        Task saved = repository.save(existing);
        log.info("Updated task id={}", saved.getId());
        return saved;
    }

    public void delete(Long id) {
        if (!repository.existsById(id)) {
            throw new TaskNotFoundException(id);
        }
        repository.deleteById(id);
        log.info("Deleted task id={}", id);
    }
}
