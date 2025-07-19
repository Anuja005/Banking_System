package com.example.web;

import com.example.rmi.model.Customer;
import com.example.rmi.service.BankService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AuthServlet extends HttpServlet {

    @EJB
    private BankService bankService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Customer customer = bankService.login(username, password);
        if (customer != null) {
            HttpSession session = req.getSession();
            session.setAttribute("customer", customer);
            resp.sendRedirect("dashboard.jsp");
        } else {
            req.setAttribute("error", "Invalid username or password.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
