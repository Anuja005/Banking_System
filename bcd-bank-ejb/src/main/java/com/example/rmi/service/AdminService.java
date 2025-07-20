package com.example.rmi.service;

import com.example.rmi.model.Customer;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class AdminService {

    @PersistenceContext(unitName = "bankPU")
    private EntityManager em;

    public void addCustomer(Customer customer) {
        em.persist(customer);
    }

    public void updateCustomer(Customer customer) {
        em.merge(customer);
    }

    public void deleteCustomer(int customerId) {
        Customer customer = em.find(Customer.class, customerId);
        if (customer != null) {
            em.remove(customer);
        }
    }

    public List<Customer> getAllCustomers() {
        return em.createQuery("SELECT c FROM Customer c", Customer.class).getResultList();
    }

    public Customer getCustomerById(int customerId) {
        return em.find(Customer.class, customerId);
    }

    public List<Customer> getLatestCustomers(int maxResults) {
        return em.createQuery("SELECT c FROM Customer c ORDER BY c.createdAt DESC", Customer.class)
                .setMaxResults(maxResults)
                .getResultList();
    }
}
