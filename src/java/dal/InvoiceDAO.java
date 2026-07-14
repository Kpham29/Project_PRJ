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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author HBDELL
 */
public class InvoiceDAO extends DBContext {

    private static final String SQL_REVENUE_AMOUNT
            = "CASE WHEN AmountPaid IS NOT NULL AND AmountPaid > 0 THEN AmountPaid ELSE ISNULL(TotalAmount, 0) END";
    private static final String SQL_REVENUE_AMOUNT_I
            = "CASE WHEN i.AmountPaid IS NOT NULL AND i.AmountPaid > 0 THEN i.AmountPaid ELSE ISNULL(i.TotalAmount, 0) END";

    public List<Map<String, Object>> getMonthlyRevenueByYear(int year) throws SQLException {
        String sql = "SELECT "
                + "CAST(YEAR(i.OrderDate) AS VARCHAR(4)) + '-' + RIGHT('0' + CAST(MONTH(i.OrderDate) AS VARCHAR(2)), 2) as month, "
                + "RIGHT('0' + CAST(MONTH(i.OrderDate) AS VARCHAR(2)), 2) as label, "
                + "ISNULL(SUM(" + SQL_REVENUE_AMOUNT_I + "), 0) as revenue, "
                + "COUNT(i.InvoiceID) as count "
                + "FROM Invoices i "
                + "WHERE i.Status = N'completed' AND YEAR(i.OrderDate) = ? "
                + "GROUP BY YEAR(i.OrderDate), MONTH(i.OrderDate) "
                + "ORDER BY YEAR(i.OrderDate) ASC, MONTH(i.OrderDate) ASC";
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("month", rs.getString("month"));
                    row.put("label", rs.getString("label"));
                    row.put("revenue", rs.getBigDecimal("revenue"));
                    row.put("count", rs.getInt("count"));
                    list.add(row);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Integer> getRevenueYears() throws SQLException {
        String sql = "SELECT DISTINCT YEAR(OrderDate) AS ReportYear "
                + "FROM Invoices WHERE Status = N'completed' "
                + "ORDER BY ReportYear DESC";
        List<Integer> years = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                years.add(rs.getInt("ReportYear"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return years;
    }

    public BigDecimal getYearRevenue(int year) throws SQLException {
        String sql = "SELECT ISNULL(SUM(" + SQL_REVENUE_AMOUNT + "), 0) FROM Invoices "
                + "WHERE YEAR(OrderDate) = ? AND Status = N'completed'";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public Map<String, Integer> getAdminStatusCounts() throws SQLException {
        String sql = "SELECT ISNULL(Status, N'none') as st, COUNT(*) as cnt FROM Invoices GROUP BY Status";
        Map<String, Integer> counts = new HashMap<>();
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                counts.put(rs.getString("st"), rs.getInt("cnt"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return counts;
    }

    public BigDecimal getMonthRevenue() throws SQLException {
        String sql = "SELECT ISNULL(SUM(" + SQL_REVENUE_AMOUNT + "), 0) FROM Invoices "
                + "WHERE YEAR(OrderDate) = YEAR(GETDATE()) AND MONTH(OrderDate) = MONTH(GETDATE()) "
                + "AND Status = N'completed'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public Map<String, Object> getAdminStats() throws SQLException {
        Map<String, Object> stats = new HashMap<>();
        String monthRevSql = "SELECT ISNULL(SUM(" + SQL_REVENUE_AMOUNT + "), 0) FROM Invoices "
                + "WHERE YEAR(OrderDate) = YEAR(GETDATE()) AND MONTH(OrderDate) = MONTH(GETDATE()) "
                + "AND Status = N'completed'";
        String todayRevSql = "SELECT ISNULL(SUM(" + SQL_REVENUE_AMOUNT + "), 0) FROM Invoices "
                + "WHERE CAST(OrderDate AS DATE) = CAST(GETDATE() AS DATE) "
                + "AND Status = N'completed'";
        String completedThisMonthSql = "SELECT COUNT(*) FROM Invoices "
                + "WHERE YEAR(OrderDate) = YEAR(GETDATE()) AND MONTH(OrderDate) = MONTH(GETDATE()) "
                + "AND Status = N'completed'";
        String totalPartsSql = "SELECT COUNT(*) FROM SpareParts";
        String totalStaffSql = "SELECT COUNT(*) FROM Users WHERE RoleID = 2";
        String waitingSql = "SELECT COUNT(*) FROM Invoices WHERE Status = N'checking'";
        String repairingSql = "SELECT COUNT(*) FROM Invoices WHERE Status = N'repairing'";
        String lowStockSql = "SELECT COUNT(*) FROM SpareParts WHERE Stock <= MinStock";

        try {
            try (PreparedStatement ps = connection.prepareStatement(monthRevSql); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("monthlyRevenue", rs.getBigDecimal(1));
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(todayRevSql); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("todayRevenue", rs.getBigDecimal(1));
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(completedThisMonthSql); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("completedOrders", rs.getInt(1));
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(totalPartsSql); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("totalParts", rs.getInt(1));
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(totalStaffSql); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("totalStaff", rs.getInt(1));
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(waitingSql); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("waitingOrders", rs.getInt(1));
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(repairingSql); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("repairingOrders", rs.getInt(1));
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(lowStockSql); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("lowStockParts", rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    public List<Map<String, Object>> getRecentOrders(int limit) throws SQLException {
        String sql = "SELECT TOP (?) i.InvoiceID as orderID, i.OrderDate as receivedDate, i.Status, i.TotalAmount, i.AmountPaid, "
                + "b.LicensePlate, b.Model, c.CustomerName, "
                + "u.FullName as StaffName "
                + "FROM Invoices i "
                + "JOIN Bikes b ON i.BikeID = b.BikeID "
                + "JOIN Customers c ON b.CustomerID = c.CustomerID "
                + "LEFT JOIN Users u ON i.UserID = u.UserID "
                + "ORDER BY i.OrderDate DESC";
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("orderID", rs.getInt("orderID"));
                    row.put("receivedDate", rs.getTimestamp("receivedDate"));
                    row.put("status", rs.getString("Status"));
                    row.put("totalAmount", rs.getBigDecimal("TotalAmount"));
                    row.put("amountPaid", rs.getBigDecimal("AmountPaid"));
                    row.put("licensePlate", rs.getString("LicensePlate"));
                    row.put("model", rs.getString("Model"));
                    row.put("customerName", rs.getString("CustomerName"));
                    row.put("staffName", rs.getString("StaffName"));
                    list.add(row);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
