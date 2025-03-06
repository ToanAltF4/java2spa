package controller;

import dao.ServiceDAO;
import dto.Service;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

public class ServiceController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy action
        String action = request.getParameter("action");
        String url = "serviceList.jsp"; // mặc định hiển thị danh sách dịch vụ

        try {
            ServiceDAO dao = new ServiceDAO();
            switch (action) {
                case "ViewServices": {
                    // Lấy tất cả dịch vụ
                    List<Service> list = dao.getAllServices();
                    request.setAttribute("serviceList", list);
                    url = "serviceList.jsp";
                    break;
                }
                case "ViewServicesUser": {
                    // Dành cho cả Admin/User. Ở User: chỉ xem, ko sửa xóa
                    List<Service> list = dao.getAllServices();
                    request.setAttribute("serviceList", list);
                    // Forward sang trang chỉ hiển thị
                    url = "servicesUserView.jsp";
                    break;
                }
                case "CreateService": {
                    // Lấy dữ liệu form createService.jsp
                    String serviceID = request.getParameter("serviceID");
                    String serviceName = request.getParameter("serviceName");
                    String description = request.getParameter("description");
                    double price = Double.parseDouble(request.getParameter("price"));

                    Service svc = new Service(serviceID, serviceName, description, price);
                    boolean result = dao.createService(svc);
                    if (!result) {
                        request.setAttribute("ERROR", "Không thể tạo dịch vụ (trùng ID?).");
                    }
                    // Sau khi thêm, hiển thị lại danh sách
                    List<Service> list = dao.getAllServices();
                    request.setAttribute("serviceList", list);
                    url = "serviceList.jsp";
                    break;
                }
                case "EditServiceForm": {
                    // Lấy serviceID từ serviceList.jsp
                    String serviceID = request.getParameter("serviceID");
                    Service svc = dao.getServiceByID(serviceID);
                    if (svc == null) {
                        request.setAttribute("ERROR", "Không tìm thấy dịch vụ ID=" + serviceID);
                        // Quay về danh sách
                        List<Service> list = dao.getAllServices();
                        request.setAttribute("serviceList", list);
                        url = "serviceList.jsp";
                    } else {
                        // forward sang trang editService.jsp (trang cập nhật)
                        request.setAttribute("service", svc);
                        url = "editService.jsp";
                    }
                    break;
                }
                case "UpdateService": {
                    // Lấy dữ liệu form editService.jsp
                    String serviceID = request.getParameter("serviceID");
                    String serviceName = request.getParameter("serviceName");
                    String description = request.getParameter("description");
                    double price = Double.parseDouble(request.getParameter("price"));

                    Service svc = new Service(serviceID, serviceName, description, price);
                    boolean updated = dao.updateService(svc);
                    if (!updated) {
                        request.setAttribute("ERROR", "Không thể cập nhật dịch vụ!");
                    }
                    // Hiển thị lại danh sách
                    List<Service> list = dao.getAllServices();
                    request.setAttribute("serviceList", list);
                    url = "serviceList.jsp";
                    break;
                }
                case "DeleteService": {
                    String serviceID = request.getParameter("serviceID");
                    boolean deleted = dao.deleteService(serviceID);
                    if (!deleted) {
                        request.setAttribute("ERROR", "Không thể xóa dịch vụ (đã có ràng buộc?).");
                    }
                    // Hiển thị lại danh sách
                    List<Service> list = dao.getAllServices();
                    request.setAttribute("serviceList", list);
                    url = "serviceList.jsp";
                    break;
                }
                case "SearchService": {
                    // Lấy kiểu tìm kiếm
                    String searchType = request.getParameter("searchType");
                    String keyword = request.getParameter("keyword");
                    List<Service> result = null;
                    if (keyword == null || keyword.trim().isEmpty()) {
                        // Nếu rỗng, ta load all
                        result = dao.getAllServices();
                    } else {
                        if ("byID".equals(searchType)) {
                            result = dao.searchByID(keyword);
                        } else {
                            // Mặc định byName
                            result = dao.searchByName(keyword);
                        }
                    }
                    request.setAttribute("serviceList", result);
                    url = "serviceList.jsp";
                    break;
                }
                case "ViewPopularServices": {
                    List<Service> list = dao.getPopularServices();
                    request.setAttribute("popularServices", list);
                    url = "popularService.jsp";
                    break;
                }

                default: {
                    request.setAttribute("ERROR", "Action không hợp lệ!");
                    // Quay về serviceList
                    List<Service> list = dao.getAllServices();
                    request.setAttribute("serviceList", list);
                    url = "serviceList.jsp";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Lỗi hệ thống: " + e.getMessage());
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
