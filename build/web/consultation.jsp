<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Appointment" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tư vấn & Theo dõi (Staff)</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .table-container-staffAppointment {
            max-width: 90%;
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
            border-radius: 12px;
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

        .form-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-top: 20px;
        }

        .form-container label {
            font-size: 16px;
            color: #555;
            margin-bottom: 10px;
            display: block;
        }

        .form-container input, .form-container select, .form-container textarea {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
            background-color: #f7f7f7;
            transition: border-color 0.3s;
        }

        .form-container input:focus, .form-container select:focus, .form-container textarea:focus {
            border-color: #e91e63;
            outline: none;
        }

        .form-container input[type="submit"] {
            background-color: #4CAF50; /* Màu xanh lá */
            color: white;
            font-size: 18px;
            cursor: pointer;
            border: none;
            padding: 15px 20px;
            border-radius: 8px;
            transition: background-color 0.3s;
        }

        .form-container input[type="submit"]:hover {
            background-color: #45a049;
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

        .success-message {
            color: green;
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
    String roleID = (String) session.getAttribute("roleID");
    if (!"STF".equals(roleID)) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Appointment> consultList = (List<Appointment>) request.getAttribute("consultList");
%>

<div class="table-container-staffAppointment">
    <h2>Tư vấn & Theo dõi (Staff)</h2>

    <%
        if (consultList != null && !consultList.isEmpty()) {
            for (Appointment a : consultList) {
    %>
    <div class="appointment-card">
        <h3>ID: <%= a.getAppointmentID() %></h3>
        <div class="appointment-info">
            <p><strong>User ID:</strong> <%= a.getUserID() %></p>
            <p><strong>Service ID:</strong> <%= a.getServiceID() %></p>
            <p><strong>Ngày giờ:</strong> <%= a.getAppointmentDate() %></p>
        </div>
        <div class="appointment-info">
            <p><strong>Trạng thái:</strong> <span class="status"><%= a.getStatus() %></span></p>
            <p><strong>Ghi chú:</strong> 
                <%= (a.getConsultationNotes() == null) ? "Chưa có ghi chú" : a.getConsultationNotes() %>
            </p>
        </div>
        <!-- Form nhập ghi chú và thay đổi trạng thái -->
        <form action="MainController" method="post" class="form-container">
            <input type="hidden" name="action" value="AddConsultationNotes">
            <input type="hidden" name="appointmentID" value="<%= a.getAppointmentID() %>">

            <label for="notes">Thêm ghi chú:</label>
            <textarea name="notes" rows="3" placeholder="Thêm ghi chú..."></textarea>

            <label for="status">Trạng thái:</label>
            <select name="status">
                <option value="Pending" <%= "Pending".equals(a.getStatus()) ? "selected" : "" %>>Pending</option>
                <option value="Cancelled" <%= "Cancelled".equals(a.getStatus()) ? "selected" : "" %>>Cancelled</option>
                <option value="Completed" <%= "Completed".equals(a.getStatus()) ? "selected" : "" %>>Completed</option>
            </select>

            <input type="submit" value="Cập nhật">
        </form>
    </div>
    <%
            }
        } else {
    %>
    <p class="error-message">Hiện chưa có cuộc hẹn nào cần tư vấn.</p>
    <%
        }
    %>

    <a class="cancel-link" href="dashboard.jsp">Back</a>
</div>

</body>
</html>
