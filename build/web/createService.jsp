<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo dịch vụ mới</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        .form-container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 28px;
            color: #2980b9;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-container label {
            font-size: 16px;
            color: #555;
            margin-bottom: 10px;
            display: block;
            margin-top: 20px;
        }

        .form-container input, .form-container textarea {
            width: 100%;
            padding: 12px 15px;
            font-size: 16px;
            border-radius: 8px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
            background-color: #f7f7f7;
            transition: border 0.3s ease;
        }

        .form-container input:focus, .form-container textarea:focus {
            border: 1px solid #3498db;
            outline: none;
        }

        .form-container textarea {
            resize: vertical;
            min-height: 150px;
        }

        .form-container input[type="submit"] {
            background-color: #3498db;
            color: white;
            font-size: 18px;
            cursor: pointer;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .form-container input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .cancel-link {
            display: inline-block;
            font-size: 16px;
            color: #e74c3c;
            text-decoration: none;
            margin-top: 20px;
            text-align: center;
            font-weight: 500;
        }

        .cancel-link:hover {
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
%>

<div class="form-container">
    <h2>CREATE NEW SERVICES</h2>
    <form action="ServiceController" method="post">
        <input type="hidden" name="action" value="CreateService">

        <label for="serviceID">Service ID:</label>
        <input type="text" id="serviceID" name="serviceID" required>

        <label for="serviceName">Service Name:</label>
        <input type="text" id="serviceName" name="serviceName" required>

        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" required></textarea>

        <label for="price">Price:</label>
        <input type="number" step="0.01" id="price" name="price" required>

        <input type="submit" value="CREATE">
    </form>

    <a class="cancel-link" href="ServiceController?action=ViewServices">BACK</a>
</div>

</body>
</html>
