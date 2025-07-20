<%@ page import="com.example.rmi.model.Customer" %>
<%@ page session="true" %>
<%
    Customer user = (Customer) session.getAttribute("customer");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Extract first name from full name
    String firstName = user.getFullName().split(" ")[0];
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banking Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --secondary: #8b5cf6;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #1e293b;
            --light: #f8fafc;
            --gray: #64748b;
            --card-bg: #ffffff;
            --sidebar-bg: #1e293b;
            --header-height: 70px;
        }

        body {
            background-color: #f1f5f9;
            color: var(--dark);
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background: var(--sidebar-bg);
            color: white;
            padding: 20px 0;
            height: 100vh;
            position: fixed;
            overflow-y: auto;
        }

        .logo {
            display: flex;
            align-items: center;
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .logo h1 {
            font-size: 22px;
            font-weight: 700;
            margin-left: 12px;
        }

        .logo i {
            font-size: 28px;
            color: var(--primary);
        }

        .nav-links {
            margin-top: 30px;
            padding: 0 15px;
        }

        .nav-links li {
            list-style: none;
            margin-bottom: 10px;
        }

        .nav-links a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            text-decoration: none;
            color: #cbd5e1;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .nav-links a:hover, .nav-links a.active {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .nav-links a i {
            margin-right: 15px;
            font-size: 20px;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 260px;
        }

        /* Header */
        header {
            height: var(--header-height);
            background: var(--card-bg);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 12px;
            object-fit: cover;
            border: 2px solid var(--primary);
        }

        .user-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-actions .btn {
            padding: 8px 20px;
            border-radius: 6px;
            border: none;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            transition: all 0.3s;
            text-decoration: none;
        }

        .user-actions .logout-btn {
            background: var(--danger);
            color: white;
        }

        .user-actions .logout-btn:hover {
            background: #dc2626;
        }

        .user-actions .transfer-btn {
            background: var(--primary);
            color: white;
        }

        .user-actions .transfer-btn:hover {
            background: var(--primary-dark);
        }

        .user-actions .btn i {
            margin-right: 8px;
        }

        /* Dashboard Content */
        .dashboard-content {
            padding: 30px;
        }

        .dashboard-title {
            font-size: 28px;
            margin-bottom: 25px;
            color: var(--dark);
        }

        .welcome-message {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 16px;
            padding: 25px;
            color: white;
            margin-bottom: 30px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .welcome-message h2 {
            font-size: 22px;
            margin-bottom: 10px;
        }

        .welcome-message p {
            opacity: 0.9;
            font-size: 16px;
        }

        /* Dashboard Cards */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            position: relative;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
        }

        .card.customer-portal::before {
            background: linear-gradient(90deg, var(--primary), var(--secondary));
        }

        .card.total-balance::before {
            background: var(--success);
        }

        .card.today-deposits::before {
            background: var(--warning);
        }

        .card.today-withdrawals::before {
            background: var(--danger);
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .customer-portal .card-icon {
            background: rgba(37, 99, 235, 0.1);
        }

        .total-balance .card-icon {
            background: rgba(16, 185, 129, 0.1);
        }

        .today-deposits .card-icon {
            background: rgba(245, 158, 11, 0.1);
        }

        .today-withdrawals .card-icon {
            background: rgba(239, 68, 68, 0.1);
        }

        .card-icon i {
            font-size: 24px;
        }

        .customer-portal .card-icon i {
            color: var(--primary);
        }

        .total-balance .card-icon i {
            color: var(--success);
        }

        .today-deposits .card-icon i {
            color: var(--warning);
        }

        .today-withdrawals .card-icon i {
            color: var(--danger);
        }

        .card-title {
            font-size: 16px;
            color: var(--gray);
            font-weight: 500;
        }

        .card-value {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .card-footer {
            font-size: 14px;
            color: var(--gray);
            display: flex;
            align-items: center;
        }

        .card-footer i {
            margin-right: 8px;
        }

        .positive {
            color: var(--success);
        }

        .negative {
            color: var(--danger);
        }

        .portal-btn {
            margin-top: 15px;
            background: var(--primary);
            color: white;
            text-decoration: none;
            padding: 12px 15px;
            border-radius: 10px;
            text-align: center;
            font-weight: 500;
            transition: all 0.3s;
            display: block;
        }

        .portal-btn:hover {
            background: var(--primary-dark);
        }

        /* Messages */
        .messages {
            margin-top: 30px;
        }

        .message {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .message.success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border-left: 4px solid var(--success);
        }

        .message.error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }

        .message i {
            margin-right: 10px;
            font-size: 20px;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
            }

            .logo h1, .nav-links span {
                display: none;
            }

            .logo {
                justify-content: center;
            }

            .nav-links a {
                justify-content: center;
            }

            .nav-links a i {
                margin-right: 0;
                font-size: 24px;
            }

            .main-content {
                margin-left: 80px;
            }
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                height: auto;
                padding: 15px;
            }

            .user-info {
                margin-bottom: 15px;
            }

            .user-actions {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .cards-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-content {
                padding: 20px 15px;
            }
        }
    </style>
</head>
<body>
<!-- Sidebar Navigation -->
<div class="sidebar">
    <div class="logo">
        <i class="fas fa-university"></i>
        <h1>FinBank</h1>
    </div>

    <ul class="nav-links">
        <li>
            <a href="#" class="active">
                <i class="fas fa-home"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-wallet"></i>
                <span>Accounts</span>
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-exchange-alt"></i>
                <span>Transactions</span>
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-credit-card"></i>
                <span>Cards</span>
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-chart-line"></i>
                <span>Reports</span>
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Header -->
    <header>
        <div class="user-info">
            <%
                // Generate avatar URL based on user's name
                String avatarUrl = "https://ui-avatars.com/api/?name=" +
                        user.getFullName().replace(" ", "+") +
                        "&background=2563eb&color=fff";
            %>
            <img id="user-avatar" src="<%= avatarUrl %>" alt="User">
            <div>
                <h3 id="user-fullname"><%= user.getFullName() %></h3>

            </div>
        </div>

        <div class="user-actions">
            <a href="transfer.jsp" class="btn transfer-btn">
                <i class="fas fa-exchange-alt"></i>
                Make a Transfer
            </a>
            <a href="login.jsp" class="btn logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                Logout
            </a>
        </div>
    </header>

    <!-- Dashboard Content -->
    <div class="dashboard-content">
        <h1 class="dashboard-title">Dashboard</h1>

        <div class="welcome-message">
            <h2>Welcome back, <%= firstName %>!</h2>
            <p>Here's what's happening with your accounts today.</p>
        </div>

        <!-- Dashboard Cards -->
        <div class="cards-grid">
            <!-- Customer Portal Card -->
            <div class="card customer-portal">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-user-circle"></i>
                    </div>
                    <div>
                        <p class="card-title">CUSTOMER PORTAL</p>
                    </div>
                </div>
                <div class="card-value">Manage Your Profile</div>
                <div class="card-footer">
                    <i class="fas fa-arrow-right"></i>
                    <span>Access all your personal details</span>
                </div>
            </div>

            <!-- Total Balance Card -->
            <div class="card total-balance">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-piggy-bank"></i>
                    </div>
                    <div>
                        <p class="card-title">TOTAL BALANCE</p>
                    </div>
                </div>
                <div class="card-value">$4259</div>
                <div class="card-footer">
                    <i class="fas fa-arrow-up positive"></i>
                    <span class="positive">+2.3% from last month</span>
                </div>
            </div>

            <!-- Today's Deposits Card -->
            <div class="card today-deposits">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-arrow-down"></i>
                    </div>
                    <div>
                        <p class="card-title">TODAY'S DEPOSITS</p>
                    </div>
                </div>
                <div class="card-value">$12</div>
                <div class="card-footer">
                    <i class="fas fa-exchange-alt"></i>
                    <span>3 deposit transactions today</span>
                </div>
            </div>

            <!-- Today's Withdrawals Card -->
            <div class="card today-withdrawals">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-arrow-up"></i>
                    </div>
                    <div>
                        <p class="card-title">TODAY'S WITHDRAWALS</p>
                    </div>
                </div>
                <div class="card-value">$450.50</div>
                <div class="card-footer">
                    <i class="fas fa-exchange-alt"></i>
                    <span>2 withdrawal transactions today</span>
                </div>
            </div>
        </div>

        <!-- Messages -->
        <div class="messages">
            <% if (request.getAttribute("message") != null) { %>
            <div class="message success">
                <i class="fas fa-check-circle"></i>
                <p><%= request.getAttribute("message") %></p>
            </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
            <div class="message error">
                <i class="fas fa-exclamation-circle"></i>
                <p><%= request.getAttribute("error") %></p>
            </div>
            <% } %>
        </div>
    </div>
</div>

<script>
    // Simulate dynamic data updates
    setInterval(() => {
        const deposits = Math.floor(Math.random() * 1000) + 500;
        if (document.querySelector('.today-deposits .card-value')) {
            document.querySelector('.today-deposits .card-value').textContent = `$${deposits.toFixed(2)}`;
        }

        const withdrawals = Math.floor(Math.random() * 500) + 100;
        if (document.querySelector('.today-withdrawals .card-value')) {
            document.querySelector('.today-withdrawals .card-value').textContent = `$${withdrawals.toFixed(2)}`;
        }
    }, 5000);
</script>
</body>
</html>