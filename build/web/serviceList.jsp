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
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .service-list-container {
            width: 80%;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: pink;
            font-size: 32px;
            margin-bottom: 30px;
        }

        .search-form {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 30px;
        }

        .search-form select, .search-form input {
            padding: 10px;
            font-size: 16px;
            border-radius: 8px;
            border: 1px solid #ccc;
            width: 200px;
        }

        .search-form button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #e91e63; /* Màu hồng */
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-form button:hover {
            background-color: #d81b60;
        }

        .service-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-between;
        }

        .service-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 30%;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s;
        }

        .service-card:hover {
            transform: translateY(-10px);
        }

        .service-card h3 {
            color: #e91e63; /* Màu hồng */
            font-size: 24px;
            margin-bottom: 10px;
        }

        .service-card p {
            font-size: 16px;
            color: #777;
            margin-bottom: 15px;
        }

        .service-card .price {
            font-size: 18px;
            color: #333;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .action-buttons {
            display: flex;
            justify-content: space-evenly;
        }

        .action-buttons input {
            padding: 8px 15px;
            font-size: 14px;
            background-color: #333; /* Màu đen */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .action-buttons input:hover {
            background-color: #555;
        }

        .error-message {
            color: red;
            text-align: center;
            font-size: 18px;
            margin-top: 20px;
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
    HttpSession mySession = request.getSession(false);
    if (mySession == null || mySession.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String roleID = (String) mySession.getAttribute("roleID");
    if (!"ADM".equals(roleID)) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Service> services = (List<Service>) request.getAttribute("serviceList");
%>

<div class="service-list-container">
    <h2>SERVICES LIST</h2>

    <!-- Form tìm kiếm -->
    <div class="search-form">
        <form action="ServiceController" method="get">
            <input type="hidden" name="action" value="SearchService">
            <select name="searchType">
                <option value="byID">Find by ID</option>
                <option value="byName">Find by Name</option>
            </select>
            <input type="text" name="keyword" placeholder="Fill in..." required>
            <button type="submit">Search</button>
        </form>

        <form action="ServiceController" method="get">
            <input type="hidden" name="action" value="ViewServices">
            <button type="submit">Show All Service</button>
        </form>
    </div>

    <div class="service-container">
        <%
            if (services != null && !services.isEmpty()) {
                for (Service svc : services) {
        %>
        <div class="service-card">
            <h3><%= svc.getServiceName() %></h3>
            <p><%= svc.getDescription() %></p>
            <p class="price"><%= svc.getPrice() %> $</p>
            <div class="action-buttons">
                <form action="ServiceController" method="post">
                    <input type="hidden" name="action" value="EditServiceForm">
                    <input type="hidden" name="serviceID" value="<%= svc.getServiceID() %>">
                    <input type="submit" value="Edit">
                </form>
                <form action="ServiceController" method="post" onsubmit="return confirm('Are U Sure?');">
                    <input type="hidden" name="action" value="DeleteService">
                    <input type="hidden" name="serviceID" value="<%= svc.getServiceID() %>">
                    <input type="submit" value="Delete">
                </form>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="error-message">No service to find!</div>
        <%
            }
        %>
    </div>

    <div class="footer-links">
        <a href="createService.jsp">CREATE NEW SERVICES</a> |
        <a href="dashboard.jsp">BACK</a>
    </div>

    <%
        String error = (String) request.getAttribute("ERROR");
        if (error != null) {
    %>
        <p class="error-message"><%= error %></p>
    <%
        }
    %>
</div>

</body>
</html>
