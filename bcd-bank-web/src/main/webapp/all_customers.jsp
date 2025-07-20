<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.example.rmi.service.AdminService" %>
<%@ page import="jakarta.ejb.EJB" %>
<%@ page import="com.example.rmi.model.Customer" %>
<%@ page import="java.util.List" %>
<%
    AdminService adminService = (AdminService) request.getAttribute("adminService");
    List<Customer> customers = adminService.getAllCustomers();
    request.setAttribute("customers", customers);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Customers</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #fff;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            overflow: hidden;
        }
        .table thead {
            background: rgba(255, 255, 255, 0.1);
        }
        .table th, .table td {
            padding: 1rem 1.5rem;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
        }
        .table th {
            font-weight: 700;
            font-size: 0.9rem;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }
        .table tbody tr:hover {
            background: rgba(255, 255, 255, 0.1);
        }
    </style>
</head>
<body>
<div class="container">
    <h2>All Customers</h2>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Created At</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="customer" items="${customers}">
            <tr>
                <td>${customer.id}</td>
                <td>${customer.username}</td>
                <td>${customer.fullName}</td>
                <td>${customer.email}</td>
                <td>${customer.createdAt}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
