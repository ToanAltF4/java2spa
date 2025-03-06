package controller;

import dao.ReviewDAO;
import dao.ServiceDAO;
import dto.Review;
import dto.Service;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class ReviewController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = "error.jsp";

        try {
            switch (action) {
                case "ReviewServiceForm": {
                    // Hiển thị form reviewService.jsp (danh sách dịch vụ)
                    ServiceDAO svcDao = new ServiceDAO();
                    List<Service> services = svcDao.getAllServices();
                    request.setAttribute("serviceList", services);
                    url = "reviewService.jsp";
                    break;
                }
                case "SubmitReview": {
                    HttpSession session = request.getSession(false);
                    String userID = (String) session.getAttribute("userID");

                    String serviceID = request.getParameter("serviceID");
                    int rating = Integer.parseInt(request.getParameter("rating"));
                    String comments = request.getParameter("comments");

                    // Tạo review
                    Review r = new Review();
                    r.setReviewID("RV" + System.currentTimeMillis()); // Tạm
                    r.setUserID(userID);
                    r.setServiceID(serviceID);
                    r.setRating(rating);
                    r.setComments(comments);

                    ReviewDAO dao = new ReviewDAO();
                    boolean created = dao.createReview(r);
                    if (created) {
                        request.setAttribute("MSG", "Cảm ơn bạn đã đánh giá dịch vụ!");
                    } else {
                        request.setAttribute("MSG", "Không thể gửi đánh giá.");
                    }
                    // Quay lại form
                    ServiceDAO svcDao = new ServiceDAO();
                    List<Service> services = svcDao.getAllServices();
                    request.setAttribute("serviceList", services);

                    url = "reviewService.jsp";
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Error in ReviewController: " + e.getMessage());
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
