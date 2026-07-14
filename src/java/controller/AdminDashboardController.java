/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.InvoiceDAO;
import dal.SparePartDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.Map;

/**
 *
 * @author HBDELL
 */
public class AdminDashboardController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private InvoiceDAO invoiceDAO;
    private SparePartDAO sparePartDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        invoiceDAO = new InvoiceDAO();
        sparePartDAO = new SparePartDAO();
        userDAO = new UserDAO();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Map<String, Object> stats = invoiceDAO.getAdminStats();
            request.setAttribute("stats", stats);
            request.setAttribute("recentOrders", invoiceDAO.getRecentOrders(10));
            request.setAttribute("lowStockParts", sparePartDAO.getLowStockParts(5));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
