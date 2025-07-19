package com.example.rmi.service;

import com.example.rmi.model.*;

import jakarta.ejb.*;
import jakarta.persistence.*;
import java.util.List;

@Singleton
@Startup
public class InterestCalculator {

    @PersistenceContext(unitName = "bankPU")
    private EntityManager em;

    // Run daily at midnight
    @Schedule(hour = "0", minute = "0", second = "0", persistent = false)
    public void applyDailyInterest() {
        List<Account> accounts = em.createQuery("SELECT a FROM Account a", Account.class).getResultList();

        for (Account acc : accounts) {
            double interest = acc.getBalance() * 0.01; // 1% interest
            acc.setBalance(acc.getBalance() + interest);
            em.merge(acc);

            Transaction tx = new Transaction();
            tx.setAccount(acc);
            tx.setAmount(interest);
            tx.setType("INTEREST");
            tx.setTimestamp(new java.sql.Timestamp(System.currentTimeMillis()));
            em.persist(tx);

            ScheduledTask task = new ScheduledTask();
            task.setTaskName("Daily Interest");
            task.setExecutedAt(new java.sql.Timestamp(System.currentTimeMillis()));
            task.setResult("Interest of " + interest + " applied to Account ID: " + acc.getId());
            em.persist(task);
        }

        System.out.println("✅ Daily Interest Applied");
    }
}
