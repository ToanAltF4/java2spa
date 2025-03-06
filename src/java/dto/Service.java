package dto;

public class Service {
    private String serviceID;
    private String serviceName;
    private String description;
    private double price;
    private int bookingCount; // Thêm thuộc tính mới

    public Service() {
    }

    public Service(String serviceID, String serviceName, 
                   String description, double price) {
        this.serviceID = serviceID;
        this.serviceName = serviceName;
        this.description = description;
        this.price = price;
        this.bookingCount = 0; // Mặc định số lần đặt là 0
    }

    public String getServiceID() {
        return serviceID;
    }

    public void setServiceID(String serviceID) {
        this.serviceID = serviceID;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getBookingCount() {  // Thêm getter cho bookingCount
        return bookingCount;
    }

    public void setBookingCount(int bookingCount) { // Sửa lại setter
        this.bookingCount = bookingCount;
    }
}
