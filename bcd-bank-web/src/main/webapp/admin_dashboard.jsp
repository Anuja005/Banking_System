<%@ page import="com.example.rmi.model.Admin" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.rmi.model.Customer" %>
<%@ page import="com.example.rmi.service.AdminService" %>
<%@ page import="jakarta.ejb.EJB" %>
<%@ page session="true" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinBank Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        .app-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            padding: 2rem 1.5rem;
            transition: all 0.3s ease;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 3rem;
            padding: 1rem;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .logo i {
            font-size: 2rem;
            color: #fff;
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 0.8rem;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .logo h1 {
            color: #fff;
            font-size: 1.8rem;
            font-weight: 700;
            letter-spacing: -0.02em;
        }

        .nav-links {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .nav-links li a {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.25rem;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            border-radius: 12px;
            transition: all 0.3s ease;
            font-weight: 500;
            position: relative;
            overflow: hidden;
        }

        .nav-links li a::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: left 0.5s;
        }

        .nav-links li a:hover::before {
            left: 100%;
        }

        .nav-links li a:hover,
        .nav-links li a.active {
            color: #fff;
            background: rgba(255, 255, 255, 0.15);
            transform: translateX(8px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .nav-links li a i {
            font-size: 1.2rem;
            width: 24px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            margin: 1rem;
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            overflow: hidden;
        }

        /* Header */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 2rem;
            background: rgba(255, 255, 255, 0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-info img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 3px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .user-info h3 {
            color: #fff;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .logout-btn {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(255, 107, 107, 0.3);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 32px rgba(255, 107, 107, 0.4);
        }

        /* Dashboard Content */
        .dashboard-content {
            padding: 2rem;
        }

        .dashboard-title {
            color: #fff;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }

        .card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            margin-bottom: 2rem;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1.5rem 2rem;
            background: rgba(255, 255, 255, 0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .card-icon {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            width: 50px;
            height: 50px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        }

        .card-title {
            color: #fff;
            font-size: 1.2rem;
            font-weight: 700;
            letter-spacing: 0.1em;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .card-body {
            padding: 2rem;
        }

        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
            margin-bottom: 1.5rem;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 32px rgba(102, 126, 234, 0.4);
        }

        /* Table Styles */
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

        .table th,
        .table td {
            padding: 1rem 1.5rem;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .table th {
            color: #fff;
            font-weight: 700;
            font-size: 0.9rem;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }

        .table td {
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: scale(1.01);
        }

        /* Placeholder content */
        .placeholder-content {
            color: rgba(255, 255, 255, 0.7);
            font-size: 1.1rem;
            text-align: center;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            border: 2px dashed rgba(255, 255, 255, 0.2);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .app-container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                padding: 1rem;
            }

            .nav-links {
                flex-direction: row;
                overflow-x: auto;
                gap: 0.25rem;
            }

            .nav-links li a {
                flex-direction: column;
                text-align: center;
                padding: 0.75rem;
                min-width: 80px;
            }

            .nav-links li a span {
                font-size: 0.8rem;
            }

            .main-content {
                margin: 0.5rem;
                border-radius: 16px;
            }

            .dashboard-content {
                padding: 1rem;
            }

            .dashboard-title {
                font-size: 2rem;
            }

            header {
                padding: 1rem;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card {
            animation: fadeInUp 0.6s ease forwards;
        }

        .card:nth-child(1) { animation-delay: 0.1s; }
        .card:nth-child(2) { animation-delay: 0.2s; }
        .card:nth-child(3) { animation-delay: 0.3s; }
        .card:nth-child(4) { animation-delay: 0.4s; }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="logo">
            <i class="fas fa-university"></i>
            <h1>FinBank</h1>
        </div>
        <ul class="nav-links">
            <li><a href="#" class="active" onclick="showSection('dashboard')"><i class="fas fa-home"></i><span>Dashboard</span></a></li>
            <li><a href="all-customers"><i class="fas fa-users"></i><span>Customers</span></a></li>
            <li><a href="#" onclick="showSection('transactions')"><i class="fas fa-exchange-alt"></i><span>Transactions</span></a></li>
            <li><a href="#" onclick="showSection('notifications')"><i class="fas fa-bell"></i><span>Notifications</span></a></li>
            <li><a href="#" onclick="showSection('settings')"><i class="fas fa-cog"></i><span>Settings</span></a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <header>
            <div class="user-info">
                <img id="user-avatar" src="https://ui-avatars.com/api/?name=Admin&background=667eea&color=fff" alt="User">
                <div>
                    <h3 id="user-fullname">Administrator</h3>
                </div>
            </div>
            <div class="user-actions">
                <a href="login.jsp" class="btn logout-btn"><i class="fas fa-sign-out-alt"></i>Logout</a>
            </div>
        </header>

        <!-- Dashboard Content -->
        <div class="dashboard-content">
            <h1 class="dashboard-title">Admin Dashboard</h1>

            <!-- Transactions Container -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon"><i class="fas fa-exchange-alt"></i></div>
                    <div><p class="card-title">RECENT TRANSACTIONS</p></div>
                </div>
                <div class="card-body">
                    <div class="placeholder-content">
                        <i class="fas fa-chart-line" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                        <p>Transaction monitoring and analytics will be displayed here</p>
                    </div>
                </div>
            </div>

            <!-- Notifications Container -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon"><i class="fas fa-bell"></i></div>
                    <div><p class="card-title">SYSTEM NOTIFICATIONS</p></div>
                </div>
                <div class="card-body">
                    <div class="placeholder-content">
                        <i class="fas fa-bell-slash" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                        <p>System alerts and notifications will appear here</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Navigation functionality
    function showSection(section) {
        // Update active navigation
        document.querySelectorAll('.nav-links a').forEach(link => {
            link.classList.remove('active');
        });
        event.target.closest('a').classList.add('active');

        // Add subtle animation to cards
        document.querySelectorAll('.card').forEach((card, index) => {
            card.style.animation = 'none';
            setTimeout(() => {
                card.style.animation = `fadeInUp 0.6s ease forwards`;
                card.style.animationDelay = `${index * 0.1}s`;
            }, 10);
        });
    }

    // Add hover effects to table rows
    document.addEventListener('DOMContentLoaded', function() {
        const tableRows = document.querySelectorAll('.table tbody tr');
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.background = 'rgba(255, 255, 255, 0.1)';
            });
            row.addEventListener('mouseleave', function() {
                this.style.background = 'transparent';
            });
        });

        // Add click effects to buttons
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(btn => {
            btn.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;

                ripple.style.cssText = `
                        width: ${size}px;
                        height: ${size}px;
                        left: ${x}px;
                        top: ${y}px;
                        position: absolute;
                        border-radius: 50%;
                        background: rgba(255, 255, 255, 0.3);
                        transform: scale(0);
                        animation: ripple 0.6s ease-out;
                        pointer-events: none;
                    `;

                this.appendChild(ripple);
                setTimeout(() => ripple.remove(), 600);
            });
        });
    });

    // CSS for ripple animation
    const style = document.createElement('style');
    style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
            .btn {
                position: relative;
                overflow: hidden;
            }
        `;
    document.head.appendChild(style);
</script>
</body>
</html>
