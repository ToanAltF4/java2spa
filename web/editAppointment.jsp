<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dto.Appointment" %>
<%@ page import="dto.Service" %>
<%@ page import="dto.User" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa cuộc hẹn</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
</head>
<body>
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

    Appointment appt = (Appointment) request.getAttribute("appointment");
    List<Service> serviceList = (List<Service>) request.getAttribute("serviceList");
    List<User> staffList = (List<User>) request.getAttribute("staffList");
%>

<%
    if (appt == null) {
%>
    <p class="error-message">Không tìm thấy cuộc hẹn.</p>
    <a class="cancel-link" href="AppointmentController?action=ViewAllAppointments">Quay về danh sách</a>
<%
    } else {
%>
<div class="form-container">
    <h2>Chỉnh sửa cuộc hẹn</h2>
    <form action="MainController" method="post">
        <input type="hidden" name="action" value="UpdateAppointment">

        <label>Appointment ID:</label>
        <input type="text" name="appointmentID" value="<%= appt.getAppointmentID() %>" readonly>

        <label>Chọn dịch vụ:</label>
        <select name="serviceID">
            <%
                if (serviceList != null) {
                    for (Service s : serviceList) {
                        String selected = (s.getServiceID().equals(appt.getServiceID())) ? "selected" : "";
            %>
            <option value="<%= s.getServiceID() %>" <%= selected %>><%= s.getServiceName() %></option>
            <%
                    }
                }
            %>
        </select>

        <label>Chọn ngày giờ:</label>
        <!-- appointmentDate: convert appt.getAppointmentDate() -> "yyyy-MM-ddTHH:mm" -->
        <%
            // Chuyển Timestamp -> String datetime-local
            java.sql.Timestamp ts = appt.getAppointmentDate();
            String dateStr = "";
            if (ts != null) {
                String raw = ts.toString(); // ex: "2025-03-01 10:30:00.0"
                dateStr = raw.substring(0, 16).replace(" ", "T"); // "2025-03-01T10:30"
            }
        %>
        <input type="datetime-local" name="appointmentDate" value="<%= dateStr %>">

        <label>Trạng thái:</label>
        <select name="status">
            <option value="Pending" <%= "Pending".equals(appt.getStatus())?"selected":"" %>>Pending</option>
            <option value="Completed" <%= "Completed".equals(appt.getStatus())?"selected":"" %>>Completed</option>
            <option value="Cancelled" <%= "Cancelled".equals(appt.getStatus())?"selected":"" %>>Cancelled</option>
        </select>

        <label>Phân công Staff:</label>
        <select name="staffID">
            <option value="" <%= (appt.getStaffID() == null)?"selected":"" %>>--Chưa phân công--</option>
            <%
                if (staffList != null) {
                    for (User staff : staffList) {
                        String sel = (staff.getUserID().equals(appt.getStaffID())) ? "selected" : "";
            %>
            <option value="<%= staff.getUserID() %>" <%= sel %>><%= staff.getFullName() %> (<%= staff.getUserID() %>)</option>
            <%
                    }
                }
            %>
        </select>

        <input type="submit" value="Cập nhật">
    </form>
    <br>
    <a class="cancel-link" href="AppointmentController?action=ViewAllAppointments">Hủy</a>
</div>
<%
    }
%>
</body>
</html>
