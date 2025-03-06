<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - Spa Portal</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
    <style>
        /* Đặt lại phong cách cho trang */
    /*        body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f8b400, #ff6f61);
                margin: 0;
                padding: 0;
            }*/

        .register-container {
            width: 380px;
            background-color: #fff;
            margin: 50px auto;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            box-sizing: border-box;
        }

        .register-container h2 {
            color: #333;
            font-size: 26px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .input-container {
            position: relative;
            margin-bottom: 20px;
        }

        .input-container input {
            width: 100%;
            padding: 15px;
            font-size: 16px;
            border: 2px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
            transition: all 0.3s ease;
        }

        .input-container input:focus {
            border-color: #ff6f61;
            outline: none;
        }

        .input-container input::placeholder {
            color: #bbb;
        }

        .input-container input[type="text"]:before, .input-container input[type="email"]:before, .input-container input[type="password"]:before {
            content: '';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
        }

        .input-container input[type="text"]:before {
            content: '👤';
        }

        .input-container input[type="email"]:before {
            content: '📧';
        }

        .input-container input[type="password"]:before {
            content: '🔒';
        }

        .btn-register {
            width: 100%;
            padding: 15px;
            background-color: #ff6f61;
            color: white;
            font-size: 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-register:hover {
            background-color: #ff3d2e;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #ff6f61;
            font-size: 14px;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .back-link:hover {
            color: #333;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>

<body class="relative flex items-center justify-center min-h-screen bg-cover bg-center" 
      style="background-image: url('background1.jpg');">

    <div class="register-container">
        <h2>REGISTER</h2>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="RegisterUser">

            <div class="input-container">
                <input type="text" id="userID" name="userID" placeholder="UserID" required>
            </div>

            <div class="input-container">
                <input type="text" id="fullName" name="fullName" placeholder="FullName" required>
            </div>

            <div class="input-container">
                <input type="email" id="email" name="email" placeholder="Email" required>
            </div>

            <div class="input-container">
                <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Phone" required>
            </div>

            <div class="input-container">
                <input type="password" id="password" name="password" placeholder="Password" required>
            </div>

            <button type="submit" class="btn-register">SIGN UP</button>
        </form>

        <% 
            String error = (String) request.getAttribute("ERROR");
            if (error != null) {
        %>
            <p class="error-message"><%= error %></p>
        <% 
            }
        %>

        <a class="back-link" href="login.jsp">BACK TO LOGIN FORM</a>
    </div>

</body>
</html>
