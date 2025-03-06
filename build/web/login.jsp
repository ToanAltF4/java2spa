<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Spa Portal</title>
    <link rel="stylesheet" type="text/css" href="css/spaStyle.css">
    <style>
        /* Thêm một số custom styles để khớp với giao diện bạn muốn */
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 0;
        }

        .login-container {
            background-color: #fff;
            width: 300px;
            padding: 40px;
            margin: 100px auto;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .login-container h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: purple;
        }

        .input-container {
            position: relative;
            margin-bottom: 20px;
        }

        .input-container input {
            width: 100%;
            padding: 10px 10px 10px 30px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f3f3f3;
        }

        .input-container input:focus {
            border-color: #4d90fe;
        }

        .input-container input[type="text"]:before, .input-container input[type="password"]:before {
            content: '';
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #888;
        }

        .input-container input[type="text"]:before {
            content: '📧'; /* Biểu tượng email */
        }

        .input-container input[type="password"]:before {
            content: '🔒'; /* Biểu tượng mật khẩu */
        }

        .btn-login {
            width: 100%;
            padding: 10px;
            font-size: 18px;
            background-color: #4d90fe;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-login:hover {
            background-color: #357ae8;
        }
        .btn-signup {
            width: 100%;
            padding: 10px;
            font-size: 18px;
            background-color: #4d90fe;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-signup:hover {
            background-color: #357ae8;
        }

        .register-link {
            display: inline-block;
            margin-top: 20px;
            font-size: 14px;
            text-decoration: none;
            color: #4d90fe;
        }

        .register-link:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body class="relative flex items-center justify-center min-h-screen bg-cover bg-center" 
      style="background-image: url('background1.jpg');">
    <div class="login-container">
        <h2>LOGIN TO SPA</h2>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="Login">

            <div class="input-container">
                <input type="text" id="email" name="email" placeholder="Email" required>
            </div>

            <div class="input-container">
                <input type="password" id="password" name="password" placeholder="Mật khẩu" required>
            </div>

            <button type="submit" class="btn-login">SIGN IN</button>

        </form>

        <% 
            String error = (String) request.getAttribute("ERROR");
            if (error != null) {
        %>
            <p class="error-message"><%= error %></p>
        <% 
            }
        %>

        <a class="register-link" href="register.jsp"><button type="submit" class="btn-signup">SIGN UP</button></a>
    </div>
</body>
</html>
