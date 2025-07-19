package com.example.rmi.model;

import jakarta.persistence.*;

@Entity
@Table(name = "fund_transfers")
public class FundTransfer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "from_account_id")
    private Account fromAccount;

    @ManyToOne
    @JoinColumn(name = "to_account_id")
    private Account toAccount;

    private double amount;

    private String status;

    @Column(name = "scheduled_time")
    private java.sql.Timestamp scheduledTime;

    @Column(name = "executed_time")
    private java.sql.Timestamp executedTime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Account getFromAccount() {
        return fromAccount;
    }

    public void setFromAccount(Account fromAccount) {
        this.fromAccount = fromAccount;
    }

    public Account getToAccount() {
        return toAccount;
    }

    public void setToAccount(Account toAccount) {
        this.toAccount = toAccount;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public java.sql.Timestamp getScheduledTime() {
        return scheduledTime;
    }

    public void setScheduledTime(java.sql.Timestamp scheduledTime) {
        this.scheduledTime = scheduledTime;
    }

    public java.sql.Timestamp getExecutedTime() {
        return executedTime;
    }

    public void setExecutedTime(java.sql.Timestamp executedTime) {
        this.executedTime = executedTime;
    }
}