package dao;

import dto.Service;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {

    public boolean createService(Service svc) throws Exception {
        boolean result = false;
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "INSERT INTO tblServices (serviceID, serviceName, description, price) "
                       + "VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, svc.getServiceID());
            ps.setString(2, svc.getServiceName());
            ps.setString(3, svc.getDescription());
            ps.setDouble(4, svc.getPrice());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        }
        return result;
    }

    public boolean updateService(Service svc) throws Exception {
        boolean result = false;
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "UPDATE tblServices SET serviceName=?, description=?, price=? "
                       + "WHERE serviceID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, svc.getServiceName());
            ps.setString(2, svc.getDescription());
            ps.setDouble(3, svc.getPrice());
            ps.setString(4, svc.getServiceID());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        }
        return result;
    }

    public boolean deleteService(String serviceID) throws Exception {
        boolean result = false;
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "UPDATE tblServices SET price = -1 WHERE serviceID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, serviceID);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        }
        return result;
    }

    public List<Service> getAllServices() throws Exception {
        List<Service> list = new ArrayList<>();
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "SELECT serviceID, serviceName, description, price FROM tblServices WHERE price > 0";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service svc = new Service();
                svc.setServiceID(rs.getString("serviceID"));
                svc.setServiceName(rs.getString("serviceName"));
                svc.setDescription(rs.getString("description"));
                svc.setPrice(rs.getDouble("price"));
                list.add(svc);
            }
        }
        return list;
    }

    public Service getServiceByID(String serviceID) throws Exception {
        Service svc = null;
        try (Connection conn = DBConnection.initializeDatabase()) {
            String sql = "SELECT serviceID, serviceName, description, price "
                       + "FROM tblServices WHERE serviceID=? AND price > 0";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, serviceID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                svc = new Service();
                svc.setServiceID(rs.getString("serviceID"));
                svc.setServiceName(rs.getString("serviceName"));
                svc.setDescription(rs.getString("description"));
                svc.setPrice(rs.getDouble("price"));
            }
        }
        return svc;
    }
    
    public List<Service> searchByID(String serviceID) throws Exception {
    List<Service> list = new ArrayList<>();
    try (Connection conn = DBConnection.initializeDatabase()) {
        String sql = "SELECT serviceID, serviceName, description, price "
                   + "FROM tblServices WHERE serviceID LIKE ? AND price > 0";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, "%" + serviceID + "%");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Service svc = new Service();
            svc.setServiceID(rs.getString("serviceID"));
            svc.setServiceName(rs.getString("serviceName"));
            svc.setDescription(rs.getString("description"));
            svc.setPrice(rs.getDouble("price"));
            list.add(svc);
        }
    }
    return list;
}

public List<Service> searchByName(String name) throws Exception {
    List<Service> list = new ArrayList<>();
    try (Connection conn = DBConnection.initializeDatabase()) {
        String sql = "SELECT serviceID, serviceName, description, price "
                   + "FROM tblServices WHERE serviceName LIKE ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, "%" + name + "%");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Service svc = new Service();
            svc.setServiceID(rs.getString("serviceID"));
            svc.setServiceName(rs.getString("serviceName"));
            svc.setDescription(rs.getString("description"));
            svc.setPrice(rs.getDouble("price"));
            list.add(svc);
        }
    }
    return list;
}
public List<Service> getPopularServices() throws Exception {
    List<Service> list = new ArrayList<>();
    String sql = "SELECT s.serviceID, s.serviceName, s.description, s.price, COUNT(a.appointmentID) AS bookingCount " +
                 "FROM tblAppointments a " +
                 "JOIN tblServices s ON a.serviceID = s.serviceID " +
                 "GROUP BY s.serviceID, s.serviceName, s.description, s.price " +
                 "HAVING COUNT(a.appointmentID) >= 2 " +
                 "ORDER BY bookingCount DESC";

    try (Connection conn = DBConnection.initializeDatabase();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Service service = new Service();
            service.setServiceID(rs.getString("serviceID"));
            service.setServiceName(rs.getString("serviceName"));
            service.setDescription(rs.getString("description"));
            service.setPrice(rs.getDouble("price"));
            service.setBookingCount(rs.getInt("bookingCount")); // Số lần đặt

            list.add(service);
        }
    }
    return list;
}



}
