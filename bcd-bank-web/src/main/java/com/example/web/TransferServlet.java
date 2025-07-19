package com.example.web;

import com.example.rmi.model.*;
import com.example.rmi.service.BankService;

import jakarta.ejb.EJB;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class TransferServlet extends HttpServlet {

    @EJB
    private BankService bankService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int fromId = Integer.parseInt(req.getParameter("fromAccountId"));
        int toId = Integer.parseInt(req.getParameter("toAccountId"));
        double amount = Double.parseDouble(req.getParameter("amount"));

        Account from = bankService.findAccountById(fromId);
        Account to = bankService.findAccountById(toId);

        boolean success = bankService.transfer(from, to, amount);
        if (success) {
            req.setAttribute("message", "Transfer successful!");
        } else {
            req.setAttribute("error", "Transfer failed. Not enough funds.");
        }
        req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
    }
}