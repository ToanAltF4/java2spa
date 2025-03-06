<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Service" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt lịch hẹn</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .form-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 40px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #e91e63; /* Màu hồng */
            font-size: 28px;
            margin-bottom: 30px;
        }

        .form-container label {
            font-size: 16px;
            color: blue;
            margin-bottom: 10px;
            display: block;
        }

        .form-container input, .form-container select {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
            background-color: #f7f7f7;
            transition: border-color 0.3s;
        }

        .form-container input:focus, .form-container select:focus {
            border-color: #e91e63;
            outline: none;
        }

        .form-container input[type="submit"] {
            background-color: blue;
            color: white;
            font-size: 18px;
            cursor: pointer;
            border: none;
            padding: 15px 20px;
            border-radius: 8px;
            transition: background-color 0.3s;
        }

        .form-container input[type="submit"]:hover {
            background-color: grey;
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

        .error-message, .success-message {
            text-align: center;
            font-size: 18px;
            margin-top: 20px;
        }

        .error-message {
            color: red;
        }

        .success-message {
            color: green;
        }

    </style>
</head>
<body class="relative flex items-center justify-center min-h-screen bg-cover bg-center" 
      style="background-image: url('background1.jpg');">

<%
    // Kiểm tra user
    HttpSession MySession = request.getSession(false);
    if (MySession == null || MySession.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="form-container">
    <h2>Booking</h2>

    <form action="AppointmentController" method="post">
        <input type="hidden" name="action" value="BookAppointment">

        <!-- Chọn dịch vụ -->
        <label for="serviceID">choose service:</label>
        <select name="serviceID" required>
            <%
                List<Service> services = (List<Service>) request.getAttribute("serviceList");
                if (services != null) {
                    for (Service s : services) {
            %>
                <option value="<%= s.getServiceID() %>"><%= s.getServiceName() %> - <%= s.getPrice() %> $</option>
            <%
                    }
                }
            %>
        </select>

        <!-- Ngày giờ (datetime-local) -->
        <label for="appointmentDate">Date:</label>
        <input type="datetime-local" id="appointmentDate" name="appointmentDate" required>

        <!-- Nút Đặt lịch -->
        <input type="submit" value="OK">
    </form>

    <%
        String msg = (String) request.getAttribute("MSG");
        if (msg != null) {
    %>
    <p class="success-message"><%= msg %></p>
    <%
        }
    %>

    <a class="cancel-link" href="dashboard.jsp">BACK</a>
</div>

</body>
</html>
