package dal;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String user = "sa";
            String pass = "123";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=VehicleRepairDBfinal;encrypt=True;trustServerCertificate=true";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
    DBContext db = new DBContext();

    try {
        if (db.connection != null && !db.connection.isClosed()) {
            System.out.println("Connected successfully!");
        } else {
            System.out.println("Connection failed!");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
}
