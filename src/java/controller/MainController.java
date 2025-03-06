/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author khoim
 */
public class MainController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String url = "login.jsp";

        try {
            switch (action) {
                case "Login":
                    url = "LoginController";
                    break;
                case "RegisterUser":
                    url = "RegisterController?action=RegisterUser";
                    break;

                //admin
                case "AddStaff":
                    url = "registerAdmin.jsp";
                    break;
                case "RegisterStaff":
                    url = "RegisterController?action=RegisterStaff";
                    break;
                case "ViewServices":
                    url = "ServiceController?action=ViewServices";
                    break;
                case "CreateService":
                    url = "ServiceController?action=CreateService";
                    break;
                case "EditServiceForm":
                    url = "ServiceController?action=EditServiceForm";
                    break;
                case "UpdateService":
                    url = "ServiceController?action=UpdateService";
                    break;
                case "DeleteService":
                    url = "ServiceController?action=DeleteService";
                    break;
                case "ViewAllAppointments":
                    url = "AppointmentController?action=ViewAllAppointments";
                    break;
                case "UpdateAppointment":
                    url = "AppointmentController?action=UpdateAppointment";
                    break;
                case "EditAppointment":
                    url = "AppointmentController?action=EditAppointment";
                    break;
                case "ViewPopularServices":
                    url = "ServiceController?action=ViewPopularServices";
                    break;

                //user
                case "ViewServicesUser":
                    url = "ServiceController?action=ViewServicesUser";
                    break;
                case "BookAppointmentForm":
                    url = "AppointmentController?action=BookAppointmentForm";
                    break;
                case "ViewMyAppointments":
                    url = "AppointmentController?action=ViewMyAppointments";
                    break;
                case "ReviewServiceForm":
                    url = "ReviewController?action=ReviewServiceForm";
                    break;

                //staff
                case "ViewAssignedAppointments":
                    url = "AppointmentController?action=ViewAssignedAppointments";
                    break;

                case "ViewConsultation":
                    url = "AppointmentController?action=ViewConsultation";
                    break;
                case "AddConsultationNotes":
                    url = "AppointmentController?action=AddConsultationNotes";
                    break;

                case "Logout": {
                    HttpSession session = request.getSession(false);
                    if (session != null) {
                        session.invalidate(); // Hủy session
                    }
                    // Chuyển hướng về login.jsp
                    url = "login.jsp";
                    break;
                }

                default:
                    request.setAttribute("ERROR", "Action now supported");
            }
        } catch (Exception e) {
            request.setAttribute("ERROR", "Error at MainController " + e.toString());
        } finally {
            System.out.println(url);
//            System.out.println("MainController action: " + action);
            request.getRequestDispatcher(url).forward(request, response);
            return;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
