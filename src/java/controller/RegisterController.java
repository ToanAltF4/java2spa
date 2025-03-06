package controller;

import dao.UserDAO;
import dto.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class RegisterController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = "error.jsp";

        try {
            switch (action) {
                case "RegisterUser": {
                    String userID = request.getParameter("userID");
                    String fullName = request.getParameter("fullName");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phoneNumber");
                    String password = request.getParameter("password");

                    // Giả sử ta để mặc định roleID = "USR"
                    String roleID = "USR";
                    UserDAO dao = new UserDAO();
                    User newUser = new User(userID, fullName, email, phone, roleID, password);

                    boolean success = dao.registerUser(newUser);
                    if (success) {
                        // Đăng ký thành công
                        request.setAttribute("ERROR", "Đăng ký thành công! Vui lòng đăng nhập.");
                        url = "register.jsp";
                    } else {
                        // Có thể do email trùng
                        request.setAttribute("ERROR", "Email đã tồn tại hoặc thông tin không hợp lệ.");
                        url = "register.jsp";
                    }

                    break;
                }

                case "RegisterStaff": {
                    String userID = request.getParameter("userID");
                    String fullName = request.getParameter("fullName");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phoneNumber");
                    String password = request.getParameter("password");

                    // Giả sử ta để mặc định roleID = "STF"
                    String roleID = "STF";
                    UserDAO dao = new UserDAO();
                    User newUser = new User(userID, fullName, email, phone, roleID, password);

                    boolean success = dao.registerUser(newUser);
                    if (success) {
                        // Đăng ký thành công
                        request.setAttribute("ERROR", "Đăng ký thành công!");
                        url = "registerAdmin.jsp";
                    } else {
                        // Có thể do email trùng
                        request.setAttribute("ERROR", "Email đã tồn tại hoặc thông tin không hợp lệ.");
                        url = "registerAdmin.jsp";
                    }
                break;
            }
        }
    }
    catch (Exception e){
            e.printStackTrace();
        request.setAttribute("ERROR", "Error in RegisterController: " + e.getMessage());
        url = "error.jsp";
    }finally{
            request.getRequestDispatcher(url).forward(request, response);
        }

}

}
