<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Service" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách dịch vụ</title>
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
            width: 80%;
            margin: 50px auto;
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #e91e63; /* Màu hồng */
            font-size: 32px;
            margin-bottom: 30px;
        }

        .service-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        .service-table th, .service-table td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 16px;
        }

        .service-table th {
            background-color: #e91e63;
            color: white;
        }

        .service-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .service-table td a {
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
        }

        .service-table td a:hover {
            text-decoration: underline;
        }

        .cancel-link {
            display: inline-block;
            font-size: 16px;
            color: #3498db;
            text-decoration: none;
            margin-top: 20px;
            font-weight: 500;
        }

        .cancel-link:hover {
            text-decoration: underline;
        }

        .footer-links {
            text-align: center;
            margin-top: 30px;
        }

        .footer-links a {
            font-size: 16px;
            color: #3498db;
            text-decoration: none;
            margin: 0 10px;
        }

        .footer-links a:hover {
            text-decoration: underline;
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

    // role = USR, STF, ADM đều có thể xem, tùy logic
    List<Service> services = (List<Service>) request.getAttribute("serviceList");
%>

<div class="table-container">
    <h2>SERVICE LIST</h2>
    <table class="service-table">
        <tr>
            <th>Service ID</th>
            <th>Service Name</th>
            <th>Description</th>
            <th>Price</th>
        </tr>
        <%
            if (services != null && !services.isEmpty()) {
                for (Service svc : services) {
        %>
        <tr>
            <td><%= svc.getServiceID() %></td>
            <td><%= svc.getServiceName() %></td>
            <td><%= svc.getDescription() %></td>
            <td><%= svc.getPrice() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4">Không có dịch vụ nào.</td>
        </tr>
        <%
            }
        %>
    </table>
    <br>
    <a class="cancel-link" href="dashboard.jsp">BACK</a>
</div>
</body>
</html>
