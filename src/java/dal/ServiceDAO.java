/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Service;

/**
 *
 * @author HBDELL
 */
public class ServiceDAO extends DBContext {
    public List<Service> getAll() throws SQLException {
        String sql = "SELECT ServiceID, ServiceName, Price, Description, EstimatedTime, Status "
                   + "FROM Services ORDER BY ServiceName";
        List<Service> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service s = mapResultSet(rs);
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lay dich vu theo ID.
     */
    public Service getById(int serviceID) throws SQLException {
        String sql = "SELECT ServiceID, ServiceName, Price, Description, EstimatedTime, Status "
                   + "FROM Services WHERE ServiceID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) return mapResultSet(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Tao dich vu moi.
     */
    public int create(String serviceName, String description, double price, String estimatedTime)
            throws SQLException {
        String sql = "INSERT INTO Services (ServiceName, Description, Price, EstimatedTime, Status) "
                   + "VALUES (?, ?, ?, ?, 'active')";
        try {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, serviceName);
            ps.setString(2, description);
            ps.setBigDecimal(3, BigDecimal.valueOf(price));
            ps.setString(4, estimatedTime);
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * Cap nhat dich vu.
     */
    public boolean update(int serviceID, String serviceName, String description,
                          double price, String estimatedTime) throws SQLException {
        String sql = "UPDATE Services SET ServiceName=?, Description=?, Price=?, EstimatedTime=? "
                   + "WHERE ServiceID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, serviceName);
            ps.setString(2, description);
            ps.setBigDecimal(3, BigDecimal.valueOf(price));
            ps.setString(4, estimatedTime);
            ps.setInt(5, serviceID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Toggle trang thai dich vu.
     */
    public boolean toggleStatus(int serviceID) throws SQLException {
        String sql = "UPDATE Services SET Status = CASE WHEN Status = 'active' THEN 'inactive' ELSE 'active' END "
                   + "WHERE ServiceID = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, serviceID);
        return ps.executeUpdate() > 0;
    }

    private Service mapResultSet(ResultSet rs) throws SQLException {
        Service s = new Service();
        s.setServiceId(rs.getInt("ServiceID"));
        s.setServiceName(rs.getString("ServiceName"));
        s.setPrice(rs.getBigDecimal("Price"));
        s.setDescription(rs.getString("Description"));
        s.setEstimatedTime(rs.getInt("EstimatedTime"));
        s.setStatus(rs.getString("Status"));
        return s;
    }
}
