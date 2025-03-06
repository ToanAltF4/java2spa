package dao;

import dto.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

public class UserDAO {

    // Kiểm tra đăng nhập dựa trên email + password
    public User checkLogin(String email, String password) throws Exception {
        User user = null;
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "SELECT userID, fullName, email, phoneNumber, roleID, password "
                       + "FROM tblUsers WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserID(rs.getString("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setRoleID(rs.getString("roleID"));
                user.setPassword(rs.getString("password"));
            }
        }
        return user;
    }

    // Đăng ký người dùng mới
    public boolean registerUser(User user) throws Exception {
        boolean result = false;
        try (Connection conn = DBConnection.initializeDatabase()) {
            // Kiểm tra email đã tồn tại chưa
            String checkSql = "SELECT email FROM tblUsers WHERE email = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, user.getEmail());
            ResultSet checkRs = checkPs.executeQuery();
            if (checkRs.next()) {
                // email đã tồn tại, return false
                return false;
            }

            // Thực hiện INSERT
            String sql = "INSERT INTO tblUsers (userID, fullName, email, phoneNumber, roleID, password) "
                       + "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUserID());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhoneNumber());
            // Giả sử mặc định roleID = "USR", hoặc lấy từ user
            ps.setString(5, user.getRoleID()); 
            ps.setString(6, user.getPassword());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        }
        return result;
    }
    public List<User> getAllStaff() {
    List<User> staffList = new ArrayList<>();
    String sql = "SELECT * FROM tblUsers WHERE roleID = 'STF'";

    try (Connection con = DBConnection.initializeDatabase();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            User staff = new User();
            staff.setUserID(rs.getString("userID"));
            staff.setFullName(rs.getString("fullName"));
            staff.setEmail(rs.getString("email"));
            staff.setPhoneNumber(rs.getString("phoneNumber"));
            staffList.add(staff);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return staffList;
}

}
