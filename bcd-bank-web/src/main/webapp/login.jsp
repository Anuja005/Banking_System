<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Bank Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="login-container">
    <div class="login-box">
        <h2>Login</h2>
        <form method="post" action="AuthServlet">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="input-group">
                <label for="role">User Role</label>
                <select id="role" name="role">
                    <option value="customer">Customer</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <button type="submit">Login</button>
            <p class="error-message" style="color:red">${error}</p>
        </form>
    </div>
</div>
</body>
</html>