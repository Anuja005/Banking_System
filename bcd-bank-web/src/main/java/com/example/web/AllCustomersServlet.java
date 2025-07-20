package com.example.web;

import com.example.rmi.model.Customer;
import com.example.rmi.service.AdminService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/all_customers")
public class AllCustomersServlet extends HttpServlet {

    @EJB
    private AdminService adminService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Customer> customers = adminService.getAllCustomers();
        req.setAttribute("customers", customers);
        req.getRequestDispatcher("all_customers.jsp").forward(req, resp);
    }
}
