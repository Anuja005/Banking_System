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
    <title>Transfer Money</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="transfer-form">
    <h2>Transfer Funds</h2>
    <form method="post" action="TransferServlet">
        <input type="number" name="fromAccountId" placeholder="From Account ID" required/><br>
        <input type="number" name="toAccountId" placeholder="To Account ID" required/><br>
        <input type="number" name="amount" placeholder="Amount" step="0.01" required/><br>
        <button type="submit">Transfer</button>
    </form>
</div>
</body>
</html>
