/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

/**
 *
 * @author HBDELL
 */
public class UserDAO extends DBContext {
    public User login(String username, String password) throws SQLException {
        String sql = "SELECT UserID, Username, Password, FullName, Phone, Address, RoleID, Email, Status "
                   + "FROM Users WHERE Username = ? AND Password = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setUsername(rs.getString("Username"));
                    user.setPassword(rs.getString("Password"));
                    user.setFullName(rs.getString("FullName"));
                    user.setPhone(rs.getString("Phone"));
                    user.setAddress(rs.getString("Address"));
                    user.setRoleId(rs.getInt("RoleID"));
                    try { user.setEmail(rs.getString("Email")); } catch (SQLException ignored) {}
                    try { user.setStatus(rs.getString("Status")); } catch (SQLException ignored) {}
                    return user;
                }
            }
        }
        catch(SQLException e){
            e.printStackTrace();
        }
        return null;
    }
}
