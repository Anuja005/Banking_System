<%@ page import="com.example.rmi.model.Customer" %>
<%@ page import="com.example.rmi.service.AdminService" %>
<%@ page import="jakarta.ejb.EJB" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String customerId = request.getParameter("id");
    if (customerId == null) {
        response.sendRedirect("admin_dashboard.jsp");
        return;
    }
    // This is not the right way to get the service, but it's a placeholder
    // until I can figure out how to properly inject it.
    AdminService adminService = null;
    Customer customer = adminService.getCustomerById(Integer.parseInt(customerId));
%>
<html>
<head>
    <title>Update Customer</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>Update Customer</h2>
    <form method="post" action="UpdateCustomerServlet">
        <input type="hidden" name="id" value="<%= customer.getId() %>">
        <div class="input-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" value="<%= customer.getUsername() %>" required>
        </div>
        <div class="input-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" value="<%= customer.getPassword() %>" required>
        </div>
        <div class="input-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" value="<%= customer.getFullName() %>" required>
        </div>
        <div class="input-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<%= customer.getEmail() %>" required>
        </div>
        <button type="submit">Update Customer</button>
    </form>
</div>
</body>
</html>
