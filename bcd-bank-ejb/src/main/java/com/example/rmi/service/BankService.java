package com.example.rmi.service;

import com.example.rmi.model.*;

import jakarta.ejb.Stateless;
import jakarta.persistence.*;
import java.util.List;

@Stateless
public class BankService {

    @PersistenceContext(unitName = "bankPU")
    private EntityManager em;

    // 🔐 Validate login
    public Customer login(String username, String password) {
        try {
            return em.createQuery("SELECT c FROM Customer c WHERE c.username = :u AND c.password = :p", Customer.class)
                    .setParameter("u", username)
                    .setParameter("p", password)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    // 💰 Deposit
    public void deposit(Account account, double amount) {
        account.setBalance(account.getBalance() + amount);
        em.merge(account);

        Transaction tx = new Transaction();
        tx.setAccount(account);
        tx.setType("DEPOSIT");
        tx.setAmount(amount);
        tx.setTimestamp(new java.sql.Timestamp(System.currentTimeMillis()));
        em.persist(tx);
    }

    // 💸 Withdraw
    public boolean withdraw(Account account, double amount) {
        if (account.getBalance() >= amount) {
            account.setBalance(account.getBalance() - amount);
            em.merge(account);

            Transaction tx = new Transaction();
            tx.setAccount(account);
            tx.setType("WITHDRAW");
            tx.setAmount(amount);
            tx.setTimestamp(new java.sql.Timestamp(System.currentTimeMillis()));
            em.persist(tx);
            return true;
        }
        return false;
    }

    // 🔁 Transfer
    public boolean transfer(Account from, Account to, double amount) {
        if (withdraw(from, amount)) {
            deposit(to, amount);

            FundTransfer ft = new FundTransfer();
            ft.setFromAccount(from);
            ft.setToAccount(to);
            ft.setAmount(amount);
            ft.setStatus("COMPLETED");
            ft.setExecutedTime(new java.sql.Timestamp(System.currentTimeMillis()));
            em.persist(ft);
            return true;
        }
        return false;
    }

    public Account findAccountById(int id) {
        return em.find(Account.class, id);
    }

    public List<Transaction> getTransactionsByAccount(Account account) {
        return em.createQuery("SELECT t FROM Transaction t WHERE t.account = :acc", Transaction.class)
                .setParameter("acc", account)
                .getResultList();
    }
}