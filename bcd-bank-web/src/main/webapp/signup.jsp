<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Your Account | Crown Capital Bank</title>
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top, #e3f2fd 0%, #90caf9 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .signup-wrapper {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 420px;
            position: relative;
        }

        .signup-wrapper::before {
            content: '';
            position: absolute;
            top: -60px;
            left: calc(50% - 30px);
            width: 60px;
            height: 60px;
            background-image: url('https://cdn-icons-png.flaticon.com/512/3447/3447640.png');
            background-size: cover;
            background-position: center;
            border-radius: 50%;
        }

        h2 {
            margin-top: 20px;
            font-size: 1.8em;
            text-align: center;
            color: #0d47a1;
        }

        form {
            margin-top: 30px;
        }

        label {
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
            display: block;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #b3e5fc;
            border-radius: 8px;
            font-size: 14px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 14px;
            background-color: #1e88e5;
            border: none;
            color: white;
            font-weight: bold;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #1565c0;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9em;
        }

        .login-link a {
            color: #0d47a1;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="signup-wrapper">
    <h2>Create Your Account</h2>
    <form action="RegisterServlet" method="post">
        <label for="name">Full Name</label>
        <input type="text" id="name" name="name" required>

        <label for="email">Email Address</label>
        <input type="email" id="email" name="email" required>

        <label for="username">Username</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>

        <label for="confirmPassword">Confirm Password</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>

        <input type="submit" value="Create Account">
    </form>
    <div class="login-link">
        <p>Already registered? <a href="login.jsp">Sign in here</a></p>
    </div>
</div>
</body>
</html>