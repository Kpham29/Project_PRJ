package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryDAO extends DBContext {

    public List<Category> getAll() throws SQLException {
        String sql = "SELECT CategoryID, CategoryName FROM Categories ORDER BY CategoryName";
        List<Category> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setCategoryId(rs.getInt("CategoryID"));
                c.setCategoryName(rs.getString("CategoryName"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Category getById(int categoryID) throws SQLException {
        String sql = "SELECT CategoryID, CategoryName FROM Categories WHERE CategoryID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Category c = new Category();
                c.setCategoryId(rs.getInt("CategoryID"));
                c.setCategoryName(rs.getString("CategoryName"));
                return c;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
