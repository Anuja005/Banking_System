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
import java.sql.Timestamp;
import java.util.Date;

@WebServlet("/AddCustomerServlet")
public class AddCustomerServlet extends HttpServlet {

    @EJB
    private AdminService adminService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        Customer customer = new Customer();
        customer.setUsername(username);
        customer.setPassword(password); // In a real application, you should hash the password
        customer.setFullName(fullName);
        customer.setEmail(email);
        customer.setCreatedAt(new Timestamp(new Date().getTime()));

        adminService.addCustomer(customer);

        response.sendRedirect("admin_dashboard.jsp");
    }
}
