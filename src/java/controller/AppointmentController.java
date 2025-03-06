package controller;

import dao.AppointmentDAO;
import dao.ServiceDAO;
import dao.UserDAO;
import dto.Appointment;
import dto.Service;
import dto.User;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class AppointmentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String url = "error.jsp"; // nếu action sai

        try {
            AppointmentDAO dao = new AppointmentDAO();

            switch (action) {
                case "BookAppointmentForm": {
                    // Lấy danh sách dịch vụ (để user chọn)
                    ServiceDAO svcDao = new ServiceDAO();
                    List<Service> serviceList = svcDao.getAllServices();
                    request.setAttribute("serviceList", serviceList);
                    url = "bookAppointment.jsp";
                    break;
                }
                case "ViewMyAppointments": {
                    HttpSession session = request.getSession(false);
                    String userID = (String) session.getAttribute("userID");
                    // Gọi DAO
                    AppointmentDAO apptDao = new AppointmentDAO();
                    List<Appointment> myList = apptDao.getAppointmentsByUser(userID);
                    request.setAttribute("myAppointments", myList);
                    url = "myAppointments.jsp";
                    break;
                }
                case "BookAppointment": {
                    // Xử lý form đặt lịch
                    HttpSession session = request.getSession(false);
                    String userID = (String) session.getAttribute("userID");

                    String serviceID = request.getParameter("serviceID");
                    String datetime = request.getParameter("appointmentDate");
                    // datetime ở dạng: "2025-03-01T10:30" (HTML input type="datetime-local")

                    // Chuyển datetime thành Timestamp
                    Timestamp ts = Timestamp.valueOf(datetime.replace("T", " ") + ":00");

                    // Tạo appointment
                    Appointment appt = new Appointment();
                    appt.setAppointmentID("AP" + System.currentTimeMillis()); // tạm
                    appt.setUserID(userID);
                    appt.setServiceID(serviceID);
                    appt.setAppointmentDate(ts);
                    appt.setStatus("Pending");
                    appt.setStaffID(null); // Chưa gán staff, hoặc auto

                    boolean created = dao.createAppointment(appt);
                    if (created) {
                        request.setAttribute("MSG", "Đặt lịch thành công!");
                    } else {
                        request.setAttribute("MSG", "Không thể đặt lịch (lỗi DB?).");
                    }
                    url = "bookAppointment.jsp";
                    break;
                }
                case "ViewAssignedAppointments": {
                    // Staff xem các appointment được giao
                    HttpSession session = request.getSession(false);
                    String staffID = (String) session.getAttribute("userID");
                    List<Appointment> list = dao.getAppointmentsByStaff(staffID);
                    request.setAttribute("assignedList", list);
                    url = "staffAppointments.jsp";
                    break;
                }
                // phần dành cho admin

                case "ViewAllAppointments": {
                    // Chỉ Admin
                    HttpSession session = request.getSession(false);
                    String role = (String) session.getAttribute("roleID");
                    if (!"ADM".equals(role)) {
                        request.setAttribute("ERROR", "Bạn không có quyền!");
                        break;
                    }
                    // Lấy tất cả
                    List<Appointment> allList = dao.getAllAppointments();
                    request.setAttribute("allAppointments", allList);
                    url = "adminAppointments.jsp";
                    break;
                }

                case "EditAppointment": {
                    // Lấy appointmentID
                    String apptID = request.getParameter("appointmentID");
                    // Tìm 1 appointment, ta có thể viết dao.getAppointmentByID(...).
                    // Hoặc load all, filter. Tốt hơn là viết 1 hàm getAppointmentByID.
                    Appointment target = dao.getAppointmentByID(apptID); // ta viết thêm hàm
                    if (target == null) {
                        request.setAttribute("ERROR", "Không tìm thấy cuộc hẹn ID=" + apptID);
                        // Quay lại danh sách
                        List<Appointment> allList = dao.getAllAppointments();
                        request.setAttribute("allAppointments", allList);
                        url = "adminAppointments.jsp";
                    } else {
                        // Lấy danh sách staff (UserDAO?), danh sách service (ServiceDAO?)...
                        // Gửi sang editAppointment.jsp
                        // Ví dụ: load staff
                        UserDAO userDao = new UserDAO();
                        List<User> staffList = userDao.getAllStaff();
                        request.setAttribute("staffList", staffList);

                        // Load service
                        ServiceDAO svcDao = new ServiceDAO();
                        List<Service> svcList = svcDao.getAllServices();
                        request.setAttribute("serviceList", svcList);

                        request.setAttribute("appointment", target);
                        url = "editAppointmentAdmin.jsp";
                    }
                    break;
                }

                case "UpdateAppointment": {
                    // Lấy data từ form editAppointment.jsp
                    String apptID = request.getParameter("appointmentID");
                    String serviceID = request.getParameter("serviceID");
                    String datetime = request.getParameter("appointmentDate");
                    String status = request.getParameter("status");
                    String staffID = request.getParameter("staffID");

                    // Convert datetime
                    Timestamp ts = Timestamp.valueOf(datetime.replace("T", " ") + ":00");

                    Appointment appt = new Appointment();
                    appt.setAppointmentID(apptID);
                    appt.setServiceID(serviceID);
                    appt.setAppointmentDate(ts);
                    appt.setStatus(status);
                    appt.setStaffID(staffID);

                    boolean updated = dao.updateAppointment(appt);
                    if (!updated) {
                        request.setAttribute("ERROR", "Cập nhật thất bại!");
                    }
                    // Quay lại danh sách
                    List<Appointment> allList = dao.getAllAppointments();
                    request.setAttribute("allAppointments", allList);
                    url = "adminAppointments.jsp";
                    break;
                }
                case "ViewConsultation": {
                    HttpSession session = request.getSession(false);
                    String staffID = (String) session.getAttribute("userID");
                    // Gọi DAO
                    List<Appointment> consultList = dao.getAppointmentsForConsultation(staffID);
                    request.setAttribute("consultList", consultList);
                    url = "consultation.jsp";
                    break;
                }
                case "AddConsultationNotes": {
                    HttpSession session = request.getSession(false);
                    String staffID = (String) session.getAttribute("userID");
                    String appointmentID = request.getParameter("appointmentID");
                    String notes = request.getParameter("notes");
                    String newStatus = request.getParameter("status");
                    // Giả sử Staff chọn “Pending” hoặc “Completed” ...

                    boolean updated = dao.updateConsultationNotes(appointmentID, notes, newStatus);
                    if (!updated) {
                        request.setAttribute("ERROR", "Không thể cập nhật ghi chú!");
                    }
                    // Tải lại danh sách
                    List<Appointment> consultList = dao.getAppointmentsForConsultation(staffID);
                    request.setAttribute("consultList", consultList);
                    url = "consultation.jsp";
                    break;
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Error in AppointmentController: " + e.getMessage());
            url = "error.jsp";
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
