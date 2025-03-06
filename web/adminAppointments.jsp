<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Appointment" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý cuộc hẹn (Admin)</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .table-container {
            width: 90%;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
        }

        h2 {
            text-align: center;
            color: #e91e63; /* Màu hồng */
            font-size: 32px;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 16px;
        }

        table th {
            background-color: #e91e63; /* Màu hồng */
            color: white;
            font-weight: bold;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .action-buttons {
            display: flex;
            justify-content: space-evenly;
        }

        .action-buttons input {
            padding: 10px 15px;
            font-size: 14px;
            background-color: #3498db; /* Màu xanh */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .action-buttons input:hover {
            background-color: #2980b9;
        }

        .cancel-link {
            display: inline-block;
            font-size: 18px;
            color: #3498db;
            text-decoration: none;
            text-align: center;
            margin-top: 30px;
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
    String roleID = (String) session.getAttribute("roleID");
    if (!"ADM".equals(roleID)) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Appointment> allAppts = (List<Appointment>) request.getAttribute("allAppointments");
%>

<div class="table-container">
    <h2>All Appointments</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>User</th>
            <th>Service</th>
            <th>Date</th>
            <th>Status</th>
            <th>Staff</th>
            <th>Action</th>
        </tr>
        <%
            if (allAppts != null && !allAppts.isEmpty()) {
                for (Appointment a : allAppts) {
        %>
        <tr>
            <td><%= a.getAppointmentID() %></td>
            <td><%= a.getUserID() %></td>
            <td><%= a.getServiceID() %></td>
            <td><%= a.getAppointmentDate() %></td>
            <td><%= a.getStatus() %></td>
            <td><%= a.getStaffID() == null ? "Chưa phân công" : a.getStaffID() %></td>
            <td class="action-buttons">
                <form action="MainController" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="EditAppointment">
                    <input type="hidden" name="appointmentID" value="<%= a.getAppointmentID() %>">
                    <input type="submit" value="Edit">
                </form>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="7">Không có cuộc hẹn nào.</td>
        </tr>
        <%
            }

            String error = (String) request.getAttribute("ERROR");
            if (error != null) {
        %>
        <p class="error-message"><%= error %></p>
        <%
            }
        %>
    </table>

    <a class="cancel-link" href="dashboard.jsp">Back</a>
</div>

</body>
</html>
