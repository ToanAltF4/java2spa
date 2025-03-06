<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lỗi hệ thống</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
</head>
<body>
<%
    // Lấy thông báo lỗi từ request
    String errorMsg = (String) request.getAttribute("ERROR");
    if (errorMsg == null) {
        errorMsg = "Đã xảy ra lỗi không xác định.";
    }
%>

<div class="error-container">
    <h2>Oops! Có lỗi xảy ra</h2>
    <p class="error-message"><%= errorMsg %></p>
    <a class="back-link" href="dashboard.jsp">Quay về trang chính</a>
</div>
</body>
</html>
