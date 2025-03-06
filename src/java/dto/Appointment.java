package dto;

import java.sql.Timestamp;
// Hoặc bạn có thể dùng java.time.LocalDateTime, tùy thiết kế
// Ở đây, ta dùng Timestamp cho appointmentDate

public class Appointment {
    private String appointmentID;
    private String userID;
    private String serviceID;
    private Timestamp appointmentDate;  // hoặc LocalDateTime
    private String status;  // Pending, Completed, Cancelled
    private String staffID; // có thể null
    private String consultationNotes;

    public Appointment() {
    }

    public Appointment(String appointmentID, String userID, String serviceID, Timestamp appointmentDate, String status, String staffID, String consultationNotes) {
        this.appointmentID = appointmentID;
        this.userID = userID;
        this.serviceID = serviceID;
        this.appointmentDate = appointmentDate;
        this.status = status;
        this.staffID = staffID;
        this.consultationNotes = consultationNotes;
    }

    

    public String getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(String appointmentID) {
        this.appointmentID = appointmentID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getServiceID() {
        return serviceID;
    }

    public void setServiceID(String serviceID) {
        this.serviceID = serviceID;
    }

    public Timestamp getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Timestamp appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStaffID() {
        return staffID;
    }

    public void setStaffID(String staffID) {
        this.staffID = staffID;
    }

    public String getConsultationNotes() {
        return consultationNotes;
    }

    public void setConsultationNotes(String consultationNotes) {
        this.consultationNotes = consultationNotes;
    }
    
}
