<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Service" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Popular Services</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 20px;
        }
        .container {
            width: 80%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #3498db;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Popular Services</h2>

        <table>
            <tr>
                <th>Service ID</th>
                <th>Service Name</th>
                <th>Description</th>
                <th>Price (VND)</th>
                <th>Booking Count</th>
            </tr>
            <%
                List<Service> popularServices = (List<Service>) request.getAttribute("popularServices");
                if (popularServices != null && !popularServices.isEmpty()) {
                    for (Service service : popularServices) {
            %>
            <tr>
                <td><%= service.getServiceID() %></td>
                <td><%= service.getServiceName() %></td>
                <td><%= service.getDescription() %></td>
                <td><%= service.getPrice() %></td>
                <td><%= service.getBookingCount() %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="5">No popular services found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>
