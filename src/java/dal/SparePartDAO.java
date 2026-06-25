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
import model.Category;
import model.SparePart;

/**
 *
 * @author HBDELL
 */
public class SparePartDAO extends DBContext {

    /**
     * Lay tat ca linh kien.
     */
    public List<SparePart> getAll() throws SQLException {
        String sql = "SELECT sp.PartID, sp.PartName, sp.Stock, sp.Price, "
                + "sp.MinStock, sp.CostPrice, c.CategoryName "
                + "FROM SpareParts sp "
                + "LEFT JOIN Categories c ON sp.CategoryID = c.CategoryID "
                + "ORDER BY sp.PartName";
        List<SparePart> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lay linh kien theo ID.
     */
    public SparePart getById(int partID) throws SQLException {
        String sql = "SELECT PartID, PartName, Stock, Price, MinStock FROM SpareParts WHERE PartID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, partID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lay cac linh kien sap het hang (Stock <= MinStock).
     */
    public List<SparePart> getLowStock() throws SQLException {
        String sql = "SELECT PartID, PartName, Stock, Price, MinStock FROM SpareParts WHERE Stock <= MinStock ORDER BY Stock";
        List<SparePart> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Dem so linh kien sap het hang.
     */
    public int countLowStock() throws SQLException {
        String sql = "SELECT COUNT(*) FROM SpareParts WHERE Stock <= MinStock";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Tao linh kien moi (6 tham so - phu hop voi ManagePartServlet).
     */
    public int create(String partName, int categoryID, double costPrice,
            double price, int stock, int minStock) throws SQLException {
        String sql = "INSERT INTO SpareParts (PartName, Price, Stock, MinStock) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, partName);
            ps.setBigDecimal(2, BigDecimal.valueOf(price));
            ps.setInt(3, stock);
            ps.setInt(4, minStock);
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * Lay cac linh kien sap het hang voi gioi han so luong
     * (AdminDashboardServlet).
     */
    public List<SparePart> getLowStockParts(int limit) throws SQLException {
        String sql = "SELECT TOP (?) PartID, PartName, Stock, Price, MinStock "
                + "FROM SpareParts WHERE Stock <= MinStock ORDER BY Stock";
        List<SparePart> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Cap nhat thong tin linh kien.
     */
    public boolean update(int partID, String partName, BigDecimal price, int stock, int minStock)
            throws SQLException {
        String sql = "UPDATE SpareParts SET PartName=?, Price=?, Stock=?, MinStock=? WHERE PartID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, partName);
            ps.setBigDecimal(2, price);
            ps.setInt(3, stock);
            ps.setInt(4, minStock);
            ps.setInt(5, partID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Nhap kho - cong them so luong.
     */
    public boolean importStock(int partID, int quantity) throws SQLException {
        String sql = "UPDATE SpareParts SET Stock = Stock + ? WHERE PartID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, partID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xoa linh kien (chi xoa neu chua co trong hoa don nao).
     */
    public boolean delete(int partID) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM InvoicePartDetails WHERE PartID = ?";
        String deleteSql = "DELETE FROM SpareParts WHERE PartID = ?";
        try {
            try (PreparedStatement ps = connection.prepareStatement(checkSql)) {
                ps.setInt(1, partID);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        throw new SQLException("Khong the xoa: linh kien da duoc su dung trong hoa don.");
                    }
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(deleteSql)) {
                ps.setInt(1, partID);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Giam so luong khi xuat kho (ban hang/ban phu tung).
     */
    public boolean decreaseStock(int partID, int quantity) throws SQLException {
        String sql = "UPDATE SpareParts SET Stock = Stock - ? WHERE PartID = ? AND Stock >= ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, partID);
            ps.setInt(3, quantity);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private SparePart mapResultSet(ResultSet rs) throws SQLException {
        SparePart p = new SparePart();
        p.setPartId(rs.getInt("PartID"));
        p.setPartName(rs.getString("PartName"));
        p.setStock(rs.getInt("Stock"));
        p.setPrice(rs.getBigDecimal("Price"));
        p.setMinStock(rs.getInt("MinStock"));
        BigDecimal costPrice = rs.getBigDecimal("CostPrice");
        if (costPrice == null) {
            costPrice = BigDecimal.ZERO;
        }
        p.setCostPrice(costPrice);
        String categoryName = rs.getString("CategoryName");
        if (categoryName == null || categoryName.trim().isEmpty()) {
            categoryName = "Chung";
        }
        Category c = new Category();
        c.setCategoryName(rs.getString("CategoryName"));
        p.setCategory(c);
        return p;
    }
}
