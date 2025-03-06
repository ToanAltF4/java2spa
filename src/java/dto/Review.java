package dto;

public class Review {
    private String reviewID;
    private String userID;
    private String serviceID;
    private int rating;       // 1 đến 5
    private String comments;  // Có thể null

    public Review() {
    }

    public Review(String reviewID, String userID, String serviceID, 
                  int rating, String comments) {
        this.reviewID = reviewID;
        this.userID = userID;
        this.serviceID = serviceID;
        this.rating = rating;
        this.comments = comments;
    }

    public String getReviewID() {
        return reviewID;
    }

    public void setReviewID(String reviewID) {
        this.reviewID = reviewID;
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

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }
}
