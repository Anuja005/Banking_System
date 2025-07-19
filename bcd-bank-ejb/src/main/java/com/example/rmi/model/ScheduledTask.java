package com.example.rmi.model;

import jakarta.persistence.*;

@Entity
@Table(name = "scheduled_tasks")
public class ScheduledTask {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "task_name")
    private String taskName;

    @Column(name = "executed_at")
    private java.sql.Timestamp executedAt;

    private String result;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public java.sql.Timestamp getExecutedAt() {
        return executedAt;
    }

    public void setExecutedAt(java.sql.Timestamp executedAt) {
        this.executedAt = executedAt;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
}
