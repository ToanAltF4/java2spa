package dao;

import dto.Review;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class ReviewDAO {
    public boolean createReview(Review r) throws Exception {
        boolean result = false;
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "INSERT INTO tblReviews (reviewID, userID, serviceID, rating, comments) "
                       + "VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, r.getReviewID());
            ps.setString(2, r.getUserID());
            ps.setString(3, r.getServiceID());
            ps.setInt(4, r.getRating());
            ps.setString(5, r.getComments());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        }
        return result;
    }
    // ...có thể thêm getReviewsByService(...) ...
}
