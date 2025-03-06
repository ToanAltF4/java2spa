<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Service" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đánh giá dịch vụ</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
</head>
<body class="relative flex items-center justify-center min-h-screen bg-cover bg-center" 
      style="background-image: url('background1.jpg');">
<%
    HttpSession MySeesion = request.getSession(false);
    if (MySeesion == null || MySeesion.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Service> services = (List<Service>) request.getAttribute("serviceList");
%>

<div class="form-container">
    <h2>Đánh giá dịch vụ</h2>
    <form action="ReviewController" method="post">
        <input type="hidden" name="action" value="SubmitReview">

        <label for="serviceID">Chọn dịch vụ:</label>
        <select id="serviceID" name="serviceID" required>
            <%
                if (services != null) {
                    for (Service s : services) {
            %>
            <option value="<%= s.getServiceID() %>"><%= s.getServiceName() %></option>
            <%
                    }
                }
            %>
        </select>

        <label for="rating">Rating (1-5)</label>
        <input type="number" id="rating" name="rating" min="1" max="5" required>

        <label for="comments">Nhận xét:</label>
        <textarea id="comments" name="comments" rows="4"></textarea>

        <input type="submit" value="send">
    </form>

    <%
        String msg = (String) request.getAttribute("MSG");
        if (msg != null) {
    %>
    <p class="success-message"><%= msg %></p>
    <%
        }
    %>

    <a class="cancel-link" href="dashboard.jsp">back</a>
</div>
</body>
</html>
