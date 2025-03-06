<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Appointment" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cuộc hẹn của tôi</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .table-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 40px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #e91e63; /* Màu hồng */
            font-size: 32px;
            margin-bottom: 30px;
        }

        .appointment-card {
            background-color: #f9f9f9;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .appointment-card:hover {
            transform: translateY(-10px);
        }

        .appointment-card h3 {
            color: #333;
            font-size: 24px;
            margin-bottom: 10px;
        }

        .appointment-card p {
            font-size: 16px;
            color: #555;
            margin-bottom: 10px;
        }

        .appointment-card .status {
            font-weight: bold;
            padding: 5px;
            background-color: #e91e63; /* Màu hồng */
            color: white;
            border-radius: 5px;
            display: inline-block;
        }

        .appointment-card .appointment-info {
            display: flex;
            justify-content: space-between;
        }

        .cancel-link {
            display: inline-block;
            font-size: 16px;
            color: #3498db; /* Màu xanh dương */
            text-decoration: none;
            text-align: center;
            margin-top: 20px;
            font-weight: 500;
        }

        .cancel-link:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            font-size: 18px;
            margin-top: 20px;
        }

    </style>
</head>
<body class="relative flex items-center justify-center min-h-screen bg-cover bg-center" 
      style="background-image: url('background1.jpg');">

<%
    HttpSession MySession = request.getSession(false);
    if (MySession == null || MySession.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Appointment> myAppts = (List<Appointment>) request.getAttribute("myAppointments");
%>

<div class="table-container">
    <h2>YOUR APPOINTMENTS</h2>
    
    <%
        if (myAppts != null && !myAppts.isEmpty()) {
            for (Appointment a : myAppts) {
    %>
    <div class="appointment-card">
        <h3>ID: <%= a.getAppointmentID() %></h3>
        <div class="appointment-info">
            <p><strong>Dịch vụ:</strong> <%= a.getServiceID() %></p>
            <p><strong>Ngày giờ:</strong> <%= a.getAppointmentDate() %></p>
        </div>
        <div class="appointment-info">
            <p><strong>Trạng thái:</strong> <span class="status"><%= a.getStatus() %></span></p>
            <p><strong>Staff:</strong> <%= a.getStaffID() == null ? "Chưa phân công" : a.getStaffID() %></p>
        </div>
    </div>
    <%
            }
        } else {
    %>
    <p class="error-message">Bạn chưa có cuộc hẹn nào.</p>
    <%
        }
    %>

    <a class="cancel-link" href="dashboard.jsp">BACK</a>
</div>

</body>
</html>
