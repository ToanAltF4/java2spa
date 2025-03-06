<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dashboard - Spa Portal</title>
        <!-- Link đến file CSS spaStyle.css -->
        <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-image: url('images/image.png'); /* Thêm ảnh nền */
                background-size: cover;
                background-position: center;
                margin: 0;
                padding: 0;
                color: #fff; /* Màu chữ sáng để dễ đọc trên nền tối */
            }

            .dashboard-container {
                background-color: rgba(255, 255, 255, 0.9); /* Nền trắng mờ */
                width: 80%;
                margin: 50px auto;
                padding: 40px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
                border-radius: 10px;
                color: #333;
            }

            h2 {
                font-size: 36px;
                color: #333;
                margin-bottom: 20px;
            }

            p {
                font-size: 20px;
                margin-bottom: 20px;
            }

            .top-bar {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                padding: 20px;
                margin-bottom: 20px;
            }

            .top-bar .logout-btn {
                background-color: #e74c3c;
                padding: 10px 20px;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 18px;
            }

            .dashboard-nav {
                margin-top: 30px;
            }

            .dashboard-nav ul {
                list-style-type: none;
                padding: 0;
                margin: 0;
            }

            .dashboard-nav li {
                margin: 20px 0;
            }

            .dashboard-nav a {
                display: block;
                padding: 20px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                font-size: 22px;
                border-radius: 10px;
                transition: background-color 0.3s;
                text-align: center;
            }

            .dashboard-nav a:hover {
                background-color: #2980b9;
            }

            .dashboard-nav .active {
                background-color: #2ecc71;
            }
        </style>
    </head>
    <body class="relative flex items-center justify-center min-h-screen bg-cover bg-center" 
          style="background-image: url('background1.jpg');">
        <%
            // Kiểm tra session và role
            HttpSession mySession = request.getSession(false);
            if (mySession == null || mySession.getAttribute("userID") == null) {
                // Nếu chưa đăng nhập, chuyển về login
                response.sendRedirect("login.jsp");
                return;
            }
            String fullName = (String) mySession.getAttribute("fullName");
            String roleID = (String) mySession.getAttribute("roleID");
        %>

        <div class="top-bar">
            <h2>Hello, <%= fullName%>!</h2>
            <a href="MainController?action=Logout" class="logout-btn">Log Out</a>
        </div>

        <div class="dashboard-container">
            <!--<p>Vai trò của bạn: <strong><%= roleID%></strong></p>-->

            <nav class="dashboard-nav">
                <ul>
                    <%
                        // Nếu là Admin (ADM)
                        if ("ADM".equals(roleID)) {
                    %>
                    <li><a href="MainController?action=AddStaff" class="active">Add New Staff</a></li>
                    <li><a href="MainController?action=ViewServices">Manage Services</a></li>
                    <li><a href="MainController?action=ViewAllAppointments">Manage appointments</a></li>
                    <li><a href="MainController?action=ViewPopularServices">Popular Services</a></li>

                    <%
                    } else if ("STF".equals(roleID)) {
                    %>
                    <li><a href="MainController?action=ViewAssignedAppointments">Xem cuộc hẹn được giao</a></li>
                    <li><a href="MainController?action=ViewConsultation">Tư vấn & Theo dõi</a></li>

                    <%
                    } else if ("USR".equals(roleID)) {
                    %>
                    <li><a href="MainController?action=ViewServicesUser">Xem dịch vụ</a></li>
                    <li><a href="MainController?action=BookAppointmentForm">Đặt lịch hẹn</a></li>
                    <li><a href="MainController?action=ViewMyAppointments">Xem cuộc hẹn của tôi</a></li>
                    <li><a href="MainController?action=ReviewServiceForm">Đánh giá dịch vụ</a></li>
                    <li><a href="MainController?action=ViewPopularServices">Popular Services</a></li>

                    <%
                        }
                    %>
                </ul>
            </nav>
        </div>

    </body>
</html>
