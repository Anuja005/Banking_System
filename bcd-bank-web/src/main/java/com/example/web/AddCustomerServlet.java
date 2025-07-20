package com.example.web;

import com.example.rmi.model.Customer;
import com.example.rmi.service.AdminService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/AddCustomerServlet")
public class AddCustomerServlet extends HttpServlet {

    @EJB
    private AdminService adminService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");

        Customer customer = new Customer();
        customer.setUsername(username);
        customer.setPassword(password);
        customer.setFullName(fullName);
        customer.setEmail(email);

        adminService.addCustomer(customer);

        resp.sendRedirect("admin_dashboard.jsp");
    }
}
