package dao;

import dto.Appointment;
import dto.Service;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    // Tạo cuộc hẹn mới (User đặt lịch)
    public boolean createAppointment(Appointment appt) throws Exception {
        boolean result = false;
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "INSERT INTO tblAppointments (appointmentID, userID, serviceID, appointmentDate, status, staffID) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, appt.getAppointmentID());
            ps.setString(2, appt.getUserID());
            ps.setString(3, appt.getServiceID());
            ps.setTimestamp(4, appt.getAppointmentDate()); // hoặc setString, tùy kiểu
            ps.setString(5, appt.getStatus());
            ps.setString(6, appt.getStaffID());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        }
        return result;
    }

    // Lấy danh sách cuộc hẹn theo userID (để user xem)
    public List<Appointment> getAppointmentsByUser(String userID) throws Exception {
        List<Appointment> list = new ArrayList<>();
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "SELECT appointmentID, userID, serviceID, appointmentDate, status, staffID "
                    + "FROM tblAppointments WHERE userID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setAppointmentID(rs.getString("appointmentID"));
                appt.setUserID(rs.getString("userID"));
                appt.setServiceID(rs.getString("serviceID"));
                appt.setAppointmentDate(rs.getTimestamp("appointmentDate"));
                appt.setStatus(rs.getString("status"));
                appt.setStaffID(rs.getString("staffID"));
                list.add(appt);
            }
        }
        return list;
    }

    // Lấy danh sách cuộc hẹn theo staffID (để staff xem)
    public List<Appointment> getAppointmentsByStaff(String staffID) throws Exception {
        List<Appointment> list = new ArrayList<>();
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "SELECT appointmentID, userID, serviceID, appointmentDate, status, staffID, consultationNotes "
                    + "FROM tblAppointments WHERE staffID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, staffID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setAppointmentID(rs.getString("appointmentID"));
                appt.setUserID(rs.getString("userID"));
                appt.setServiceID(rs.getString("serviceID"));
                appt.setAppointmentDate(rs.getTimestamp("appointmentDate"));
                appt.setStatus(rs.getString("status"));
                appt.setStaffID(rs.getString("staffID")); // cột staffID
                appt.setConsultationNotes(rs.getString("consultationNotes")); // cột consultationNotes
                list.add(appt);
            }
        }
        return list;
    }

    public boolean cancelAppointment(String appointmentID) throws Exception {
        boolean result = false;
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "UPDATE tblAppointments SET status = 'Cancelled' WHERE appointmentID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, appointmentID);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        }
        return result;
    }

    public List<Appointment> getAllAppointments() throws Exception {
        List<Appointment> list = new ArrayList<>();
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "SELECT appointmentID, userID, serviceID, appointmentDate, status, staffID "
                    + "FROM tblAppointments";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setAppointmentID(rs.getString("appointmentID"));
                appt.setUserID(rs.getString("userID"));
                appt.setServiceID(rs.getString("serviceID"));
                appt.setAppointmentDate(rs.getTimestamp("appointmentDate"));
                appt.setStatus(rs.getString("status"));
                appt.setStaffID(rs.getString("staffID"));
                list.add(appt);
            }
        }
        return list;
    }

// Hàm cập nhật appointment: ví dụ update staffID và status
    public boolean updateAppointment(Appointment appt) throws Exception {
        boolean result = false;
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "UPDATE tblAppointments "
                    + "SET serviceID=?, appointmentDate=?, status=?, staffID=? "
                    + "WHERE appointmentID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, appt.getServiceID());
            ps.setTimestamp(2, appt.getAppointmentDate());
            ps.setString(3, appt.getStatus());
            ps.setString(4, appt.getStaffID());
            ps.setString(5, appt.getAppointmentID());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        }
        return result;
    }

    public Appointment getAppointmentByID(String appointmentID) {
        Appointment appt = null;
        String sql = "SELECT * FROM tblAppointments WHERE appointmentID = ?";

        try (Connection con = DBConnection.initializeDatabase();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, appointmentID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                appt = new Appointment();
                appt.setAppointmentID(rs.getString("appointmentID"));
                appt.setUserID(rs.getString("userID"));
                appt.setServiceID(rs.getString("serviceID"));
                appt.setAppointmentDate(rs.getTimestamp("appointmentDate"));
                appt.setStatus(rs.getString("status"));
                appt.setStaffID(rs.getString("staffID"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

        return appt;
    }

    public List<Appointment> getAppointmentsForConsultation(String staffID) throws Exception {
        List<Appointment> list = new ArrayList<>();
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "SELECT appointmentID, userID, serviceID, appointmentDate, status, staffID, consultationNotes "
                    + "FROM tblAppointments "
                    + "WHERE staffID = ? AND status <> 'Completed'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, staffID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setAppointmentID(rs.getString("appointmentID"));
                appt.setUserID(rs.getString("userID"));
                appt.setServiceID(rs.getString("serviceID"));
                appt.setAppointmentDate(rs.getTimestamp("appointmentDate"));
                appt.setStatus(rs.getString("status"));
                appt.setStaffID(rs.getString("staffID"));
                appt.setConsultationNotes(rs.getString("consultationNotes")); // cột mới
                list.add(appt);
            }
        }
        return list;
    }

    public boolean updateConsultationNotes(String appointmentID, String notes, String newStatus) throws Exception {
        boolean result = false;
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "UPDATE tblAppointments "
                    + "SET consultationNotes = ?, status = ? "
                    + "WHERE appointmentID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, notes);
            ps.setString(2, newStatus);
            ps.setString(3, appointmentID);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        }
        return result;
    }
    



}
