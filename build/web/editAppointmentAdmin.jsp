<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dto.Appointment" %>
<%@ page import="dto.Service" %>
<%@ page import="dto.User" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa cuộc hẹn</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .form-container {
            max-width: 700px;
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

        .form-container label {
            font-size: 16px;
            color: #555;
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
            background-color: #e91e63; /* Màu hồng */
            color: white;
            font-size: 18px;
            cursor: pointer;
            border: none;
            padding: 15px 20px;
            border-radius: 8px;
            transition: background-color 0.3s;
        }

        .form-container input[type="submit"]:hover {
            background-color: #d81b60;
        }

        .cancel-link {
            display: inline-block;
            font-size: 16px;
            color: #e91e63; /* Màu hồng */
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
    // Kiểm tra session, role
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

    // Lấy Appointment từ request (được set trong Controller)
    Appointment appt = (Appointment) request.getAttribute("appointment");
    // Danh sách service để chọn
    List<Service> serviceList = (List<Service>) request.getAttribute("serviceList");
    // Danh sách staff để phân công
    List<User> staffList = (List<User>) request.getAttribute("staffList");
%>

<%
    // Nếu appointment không tồn tại
    if (appt == null) {
%>
    <p class="error-message">Không tìm thấy cuộc hẹn.</p>
    <a class="cancel-link" href="MainController?action=ViewAllAppointments">Quay về danh sách</a>
<%
    } else {
%>
<div class="form-container">
    <h2>EDIT APPOINTMENT</h2>
    <form action="MainController" method="post">
        <!-- Gọi case "UpdateAppointment" trong Controller -->
        <input type="hidden" name="action" value="UpdateAppointment">

        <!-- ID cuộc hẹn, không cho sửa -->
        <label for="appointmentID">Appointment ID:</label>
        <input type="text" name="appointmentID" id="appointmentID" 
               value="<%= appt.getAppointmentID() %>" readonly>

        <!-- Chọn dịch vụ -->
        <label for="serviceID">service:</label>
        <select name="serviceID" id="serviceID">
            <%
                if (serviceList != null) {
                    for (Service svc : serviceList) {
                        String selected = svc.getServiceID().equals(appt.getServiceID()) ? "selected" : "";
            %>
            <option value="<%= svc.getServiceID() %>" <%= selected %> >
                <%= svc.getServiceName() %>
            </option>
            <%
                    }
                }
            %>
        </select>

        <!-- Ngày giờ (datetime-local) -->
        <label for="appointmentDate">date:</label>
        <%
            // Chuyển Timestamp -> String cho input datetime-local
            java.sql.Timestamp ts = appt.getAppointmentDate();
            String dateStr = "";
            if (ts != null) {
                // "2025-03-01 10:30:00.0" -> "2025-03-01T10:30"
                String raw = ts.toString().substring(0,16).replace(" ", "T");
                dateStr = raw; 
            }
        %>
        <input type="datetime-local" name="appointmentDate" id="appointmentDate" 
               value="<%= dateStr %>">

        <!-- Chọn staff -->
        <label for="staffID">Phân công Staff:</label>
        <select name="staffID" id="staffID">
            <option value="">--Chưa phân công--</option>
            <%
                if (staffList != null) {
                    for (User st : staffList) {
                        String sel = (st.getUserID().equals(appt.getStaffID())) ? "selected" : "";
            %>
            <option value="<%= st.getUserID() %>" <%= sel %> >
                <%= st.getFullName() %> (<%= st.getUserID() %>)
            </option>
            <%
                    }
                }
            %>
        </select>

        <!-- Trạng thái (Pending, Cancelled, Completed) -->
        <label for="status">Trạng thái:</label>
        <select name="status" id="status">
            <option value="Pending" 
                <%= "Pending".equals(appt.getStatus()) ? "selected" : "" %>>Pending
            </option>
            <option value="Cancelled" 
                <%= "Cancelled".equals(appt.getStatus()) ? "selected" : "" %>>Cancelled
            </option>
            <option value="Completed" 
                <%= "Completed".equals(appt.getStatus()) ? "selected" : "" %>>Completed
            </option>
        </select>

        <!-- Nút cập nhật -->
        <input type="submit" value="Update">
    </form>
    <br>
    <a class="cancel-link" href="MainController?action=ViewAllAppointments">Back</a>
</div>
<%
    }
%>
</body>
</html>
