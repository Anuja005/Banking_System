<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinBank - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #0f0f23 0%, #1a1a3e 50%, #2d1b69 100%);
            min-height: 100vh;
            color: #ffffff;
            overflow-x: hidden;
        }

        /* Animated background particles */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image:
                    radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                    radial-gradient(circle at 80% 20%, rgba(255, 118, 117, 0.15) 0%, transparent 50%),
                    radial-gradient(circle at 40% 40%, rgba(120, 119, 198, 0.1) 0%, transparent 50%);
            z-index: -1;
            animation: float 20s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border-right: 1px solid rgba(255, 255, 255, 0.1);
            padding: 2rem 0;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .logo {
            display: flex;
            align-items: center;
            padding: 0 2rem;
            margin-bottom: 3rem;
        }

        .logo i {
            font-size: 2.5rem;
            color: #6366f1;
            margin-right: 1rem;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        .logo h1 {
            font-size: 1.8rem;
            font-weight: 700;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-links {
            list-style: none;
        }

        .nav-links li {
            margin: 0.5rem 0;
        }

        .nav-links a {
            display: flex;
            align-items: center;
            padding: 1rem 2rem;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-links a::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            transform: translateX(-100%);
            transition: transform 0.3s ease;
        }

        .nav-links a:hover,
        .nav-links a.active {
            color: #ffffff;
            background: rgba(255, 255, 255, 0.1);
        }

        .nav-links a:hover::before,
        .nav-links a.active::before {
            transform: translateX(0);
        }

        .nav-links a i {
            font-size: 1.2rem;
            margin-right: 1rem;
            width: 24px;
        }

        .main-content {
            margin-left: 280px;
            min-height: 100vh;
            padding: 2rem;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 2rem;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 2rem;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 1rem;
            border: 3px solid rgba(99, 102, 241, 0.3);
            transition: all 0.3s ease;
        }

        .user-info img:hover {
            border-color: #6366f1;
            transform: scale(1.1);
        }

        .user-info h3 {
            font-size: 1.2rem;
            font-weight: 600;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            padding: 0.75rem 1.5rem;
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(239, 68, 68, 0.3);
        }

        .logout-btn i {
            margin-right: 0.5rem;
        }

        .dashboard-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            background: linear-gradient(135deg, #ffffff, #a855f7);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
        }

        .card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 2rem;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            border-color: rgba(99, 102, 241, 0.3);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.1);
        }

        .card-header {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.1), rgba(139, 92, 246, 0.1));
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from { box-shadow: 0 0 20px rgba(99, 102, 241, 0.5); }
            to { box-shadow: 0 0 30px rgba(139, 92, 246, 0.7); }
        }

        .card-icon i {
            font-size: 1.5rem;
            color: white;
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .card-body {
            padding: 2rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
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
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            margin-bottom: 1.5rem;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(99, 102, 241, 0.3);
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            margin: 0 0.25rem;
        }

        .btn-danger {
            background: linear-gradient(135deg, #ef4444, #dc2626);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(239, 68, 68, 0.3);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .table th,
        .table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .table th {
            background: rgba(255, 255, 255, 0.05);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.875rem;
            color: rgba(255, 255, 255, 0.8);
        }

        .table tr {
            transition: all 0.3s ease;
        }

        .table tr:hover {
            background: rgba(99, 102, 241, 0.1);
            transform: scale(1.02);
        }

        .customer-portal {
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.05), rgba(139, 92, 246, 0.05));
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 1.5rem;
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            border-color: rgba(99, 102, 241, 0.3);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat-label {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 0.5rem;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .main-content {
                margin-left: 0;
                padding: 1rem;
            }

            .dashboard-title {
                font-size: 2rem;
            }

            header {
                flex-direction: column;
                gap: 1rem;
            }
        }

        /* Loading animation for table */
        .table tbody tr {
            animation: fadeInUp 0.5s ease forwards;
            opacity: 0;
            transform: translateY(20px);
        }

        .table tbody tr:nth-child(1) { animation-delay: 0.1s; }
        .table tbody tr:nth-child(2) { animation-delay: 0.2s; }
        .table tbody tr:nth-child(3) { animation-delay: 0.3s; }
        .table tbody tr:nth-child(4) { animation-delay: 0.4s; }
        .table tbody tr:nth-child(5) { animation-delay: 0.5s; }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Scrollbar styling */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #4f46e5, #7c3aed);
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
        <li><a href="#" class="active"><i class="fas fa-home"></i><span>Dashboard</span></a></li>
        <li><a href="#"><i class="fas fa-users"></i><span>Customers</span></a></li>
        <li><a href="#"><i class="fas fa-exchange-alt"></i><span>Transactions</span></a></li>
        <li><a href="#"><i class="fas fa-chart-line"></i><span>Analytics</span></a></li>
        <li><a href="#"><i class="fas fa-bell"></i><span>Notifications</span></a></li>
        <li><a href="#"><i class="fas fa-cog"></i><span>Settings</span></a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Header -->
    <header>
        <div class="user-info">
            <img id="user-avatar" src="https://ui-avatars.com/api/?name=Admin+User&background=6366f1&color=fff" alt="Admin">
            <div>
                <h3 id="user-fullname">Anuja Rashmika</h3>
                <p style="color: rgba(255, 255, 255, 0.6); font-size: 0.875rem;">System Administrator</p>
            </div>
        </div>
        <div class="user-actions">
            <a href="login.jsp" class="logout-btn"><i class="fas fa-sign-out-alt"></i>Logout</a>
        </div>
    </header>

    <!-- Dashboard Content -->
    <div class="dashboard-content">
        <h1 class="dashboard-title">Admin Dashboard</h1>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-value">1,247</div>
                <div class="stat-label">Total Customers</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">$2.4M</div>
                <div class="stat-label">Total Balance</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">892</div>
                <div class="stat-label">Transactions Today</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">99.8%</div>
                <div class="stat-label">System Uptime</div>
            </div>
        </div>

        <!-- Customer Portal Container -->
        <div class="card customer-portal">
            <div class="card-header">
                <div class="card-icon"><i class="fas fa-users"></i></div>
                <p class="card-title">Customer Management</p>
            </div>
            <div class="card-body">
                <a href="add_customer.jsp" class="btn btn-primary">
                    <i class="fas fa-plus" style="margin-right: 0.5rem;"></i>
                    Add New Customer
                </a>
                <table class="table">
                    <thead>
                    <tr>
                        <th>Username</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Balance</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>john_doe</td>
                        <td>John Doe</td>
                        <td>john.doe@email.com</td>
                        <td>$12,450.00</td>
                        <td><span style="background: linear-gradient(135deg, #22c55e, #16a34a); padding: 0.25rem 0.75rem; border-radius: 12px; font-size: 0.75rem; text-transform: uppercase;">Active</span></td>
                        <td>
                            <a href="#" class="btn-sm btn-primary">Update</a>
                            <a href="#" class="btn-sm btn-danger">Delete</a>
                        </td>
                    </tr>
                    <tr>
                        <td>jane_smith</td>
                        <td>Jane Smith</td>
                        <td>jane.smith@email.com</td>
                        <td>$8,920.50</td>
                        <td><span style="background: linear-gradient(135deg, #22c55e, #16a34a); padding: 0.25rem 0.75rem; border-radius: 12px; font-size: 0.75rem; text-transform: uppercase;">Active</span></td>
                        <td>
                            <a href="#" class="btn-sm btn-primary">Update</a>
                            <a href="#" class="btn-sm btn-danger">Delete</a>
                        </td>
                    </tr>
                    <tr>
                        <td>mike_wilson</td>
                        <td>Mike Wilson</td>
                        <td>mike.wilson@email.com</td>
                        <td>$15,750.25</td>
                        <td><span style="background: linear-gradient(135deg, #f59e0b, #d97706); padding: 0.25rem 0.75rem; border-radius: 12px; font-size: 0.75rem; text-transform: uppercase;">Pending</span></td>
                        <td>
                            <a href="#" class="btn-sm btn-primary">Update</a>
                            <a href="#" class="btn-sm btn-danger">Delete</a>
                        </td>
                    </tr>
                    <tr>
                        <td>sarah_davis</td>
                        <td>Sarah Davis</td>
                        <td>sarah.davis@email.com</td>
                        <td>$22,100.75</td>
                        <td><span style="background: linear-gradient(135deg, #22c55e, #16a34a); padding: 0.25rem 0.75rem; border-radius: 12px; font-size: 0.75rem; text-transform: uppercase;">Active</span></td>
                        <td>
                            <a href="#" class="btn-sm btn-primary">Update</a>
                            <a href="#" class="btn-sm btn-danger">Delete</a>
                        </td>
                    </tr>
                    <tr>
                        <td>alex_brown</td>
                        <td>Alex Brown</td>
                        <td>alex.brown@email.com</td>
                        <td>$5,680.00</td>
                        <td><span style="background: linear-gradient(135deg, #22c55e, #16a34a); padding: 0.25rem 0.75rem; border-radius: 12px; font-size: 0.75rem; text-transform: uppercase;">Active</span></td>
                        <td>
                            <a href="#" class="btn-sm btn-primary">Update</a>
                            <a href="#" class="btn-sm btn-danger">Delete</a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Recent Transactions Container -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon"><i class="fas fa-exchange-alt"></i></div>
                <p class="card-title">Recent Transactions</p>
            </div>
            <div class="card-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Transaction ID</th>
                        <th>Customer</th>
                        <th>Type</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>#TXN001234</td>
                        <td>John Doe</td>
                        <td>Transfer</td>
                        <td>$1,250.00</td>
                        <td>2024-01-15</td>
                        <td><span style="background: linear-gradient(135deg, #22c55e, #16a34a); padding: 0.25rem 0.75rem; border-radius: 12px; font-size: 0.75rem;">Completed</span></td>
                    </tr>
                    <tr>
                        <td>#TXN001235</td>
                        <td>Jane Smith</td>
                        <td>Deposit</td>
                        <td>$500.00</td>
                        <td>2024-01-15</td>
                        <td><span style="background: linear-gradient(135deg, #22c55e, #16a34a); padding: 0.25rem 0.75rem; border-radius: 12px; font-size: 0.75rem;">Completed</span></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- System Status Container -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon"><i class="fas fa-server"></i></div>
                <p class="card-title">System Status</p>
            </div>
            <div class="card-body">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                    <div style="text-align: center; padding: 1rem; background: rgba(34, 197, 94, 0.1); border-radius: 12px; border: 1px solid rgba(34, 197, 94, 0.3);">
                        <i class="fas fa-database" style="font-size: 2rem; color: #22c55e; margin-bottom: 0.5rem;"></i>
                        <h3>Database</h3>
                        <p style="color: #22c55e;">Online</p>
                    </div>
                    <div style="text-align: center; padding: 1rem; background: rgba(34, 197, 94, 0.1); border-radius: 12px; border: 1px solid rgba(34, 197, 94, 0.3);">
                        <i class="fas fa-shield-alt" style="font-size: 2rem; color: #22c55e; margin-bottom: 0.5rem;"></i>
                        <h3>Security</h3>
                        <p style="color: #22c55e;">Secure</p>
                    </div>
                    <div style="text-align: center; padding: 1rem; background: rgba(34, 197, 94, 0.1); border-radius: 12px; border: 1px solid rgba(34, 197, 94, 0.3);">
                        <i class="fas fa-cloud" style="font-size: 2rem; color: #22c55e; margin-bottom: 0.5rem;"></i>
                        <h3>Backup</h3>
                        <p style="color: #22c55e;">Up to Date</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Add smooth scrolling and interactive effects
    document.addEventListener('DOMContentLoaded', function() {
        // Smooth navigation highlighting
        const navLinks = document.querySelectorAll('.nav-links a');
        navLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                navLinks.forEach(l => l.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Add loading animation to cards
        const cards = document.querySelectorAll('.card');
        cards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
            card.style.animation = 'fadeInUp 0.6s ease forwards';
        });

        // Real-time clock
        function updateClock() {
            const now = new Date();
            const timeString = now.toLocaleTimeString();
            // You can add a clock element if needed
        }
        setInterval(updateClock, 1000);

        // Table row interactions
        const tableRows = document.querySelectorAll('.table tbody tr');
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.02)';
                this.style.background = 'rgba(99, 102, 241, 0.15)';
            });

            row.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
                this.style.background = 'transparent';
            });
        });

        // Button click effects
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(button => {
            button.addEventListener('click', function(e) {
                // Create ripple effect
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;

                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                ripple.classList.add('ripple');

                this.appendChild(ripple);

                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });
    });

    // Add ripple effect CSS
    const style = document.createElement('style');
    style.textContent = `
            .ripple {
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.3);
                transform: scale(0);
                animation: ripple-animation 0.6s linear;
                pointer-events: none;
            }

            @keyframes ripple-animation {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
    document.head.appendChild(style);
</script>
</body>
</html>