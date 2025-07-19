<%@ page import="com.example.rmi.model.Customer" %>
<%@ page session="true" %>
<%
    Customer user = (Customer) session.getAttribute("customer");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="dashboard">
    <h2>Welcome, <%= user.getFullName() %></h2>
    <a href="transfer.jsp">Make a Transfer</a>
    <p style="color:green">${message}</p>
    <p style="color:red">${error}</p>
</div>
</body>
</html>