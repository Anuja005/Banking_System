<%@ page import="com.example.rmi.model.Admin" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.rmi.model.Customer" %>
<%@ page import="com.example.rmi.service.AdminService" %>
<%@ page import="jakarta.naming.InitialContext" %>
<%@ page session="true" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    AdminService adminService = (AdminService) new InitialContext().lookup("java:global/bcd-bank-ear/bcd-bank-ejb/AdminService");
    List<Customer> customers = adminService.getLatestCustomers(5);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<!-- Sidebar Navigation -->
<div class="sidebar">
    <div class="logo">
        <i class="fas fa-university"></i>
        <h1>FinBank</h1>
    </div>
    <ul class="nav-links">
        <li><a href="#" class="active"><i class="fas fa-home"></i><span>Dashboard</span></a></li>
        <li><a href="#"><i class="fas fa-users"></i><span>Customers</span></a></li>
        <li><a href="#"><i class="fas fa-exchange-alt"></i><span>Transactions</span></a></li>
        <li><a href="#"><i class="fas fa-bell"></i><span>Notifications</span></a></li>
        <li><a href="#"><i class="fas fa-cog"></i><span>Settings</span></a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Header -->
    <header>
        <div class="user-info">
            <img id="user-avatar" src="https://ui-avatars.com/api/?name=Admin&background=1e293b&color=fff" alt="User">
            <div>
                <h3 id="user-fullname"><%= admin.getFullName() %></h3>
            </div>
        </div>
        <div class="user-actions">
            <a href="login.jsp" class="btn logout-btn"><i class="fas fa-sign-out-alt"></i>Logout</a>
        </div>
    </header>

    <!-- Dashboard Content -->
    <div class="dashboard-content">
        <h1 class="dashboard-title">Admin Dashboard</h1>

        <!-- Customer Portal Container -->
        <div class="card customer-portal">
            <div class="card-header">
                <div class="card-icon"><i class="fas fa-users"></i></div>
                <div><p class="card-title">CUSTOMER MANAGEMENT</p></div>
            </div>
            <div class="card-body">
                <a href="add_customer.jsp" class="btn btn-primary">Add Customer</a>
                <table class="table">
                    <thead>
                    <tr>
                        <th>Username</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Customer customer : customers) { %>
                    <tr>
                        <td><%= customer.getUsername() %></td>
                        <td><%= customer.getFullName() %></td>
                        <td><%= customer.getEmail() %></td>
                        <td>
                            <a href="update_customer.jsp?id=<%= customer.getId() %>" class="btn btn-sm btn-primary">Update</a>
                            <a href="DeleteCustomerServlet?id=<%= customer.getId() %>" class="btn btn-sm btn-danger">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Transactions Container -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon"><i class="fas fa-exchange-alt"></i></div>
                <div><p class="card-title">TRANSACTIONS</p></div>
            </div>
            <div class="card-body">
                <p>Transaction details will be displayed here.</p>
            </div>
        </div>

        <!-- Notifications Container -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon"><i class="fas fa-bell"></i></div>
                <div><p class="card-title">NOTIFICATIONS</p></div>
            </div>
            <div class="card-body">
                <p>Notification details will be displayed here.</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
