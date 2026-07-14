/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author HBDELL
 */
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate input rỗng
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            forwardWithError(request, response, "Vui long nhap username va password.");
            return;
        }

        try {
            User user = userDAO.login(username.trim(), password);

            if (user == null) {
                forwardWithError(request, response, "Username hoac password khong dung.");
                return;
            }

            // Tạo session mới (invalidate session cũ nếu có)
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            HttpSession newSession = request.getSession(true);
            newSession.setMaxInactiveInterval(30 * 60); // 30 phut

            // Lưu user vào session
            newSession.setAttribute("user", user);
            newSession.setAttribute("roleID", user.getRoleId());
            newSession.setAttribute("fullName", user.getFullName());

            // Khach hang (Role 3): gan CustomerID tu bang Customers.UserID
//            if (user.getRoleID() == 3) {
//                try {
//                    Integer customerId = customerDAO.getCustomerIdByUserId(user.getUserID());
//                    newSession.setAttribute("customerID", customerId);
//                } catch (Exception ex) {
//                    ex.printStackTrace();
//                    newSession.setAttribute("customerID", null);
//                }
//            } else {
//                newSession.setAttribute("customerID", null);
//            }

            // Redirect theo Role
            int roleID = user.getRoleId();
            String redirectURL;

            if (roleID == 1) {
                // Admin -> dashboard admin
                redirectURL = request.getContextPath() + "/admin/dashboard";
            } else if (roleID == 2) {
                // Staff -> dashboard staff
                redirectURL = request.getContextPath() + "/staff/dashboard";
            } else if (roleID == 3) {
                // Khach hang -> trang xe cua toi
                redirectURL = request.getContextPath() + "/customer/my-bikes";
            } else {
                redirectURL = request.getContextPath() + "/";
            }

            // Neu co redirect param (trang muon quay lai sau khi login) — khong cho tro lai login (tranh loop)
            String paramRedirect = request.getParameter("redirect");
            if (paramRedirect != null && !paramRedirect.isEmpty()) {
                try {
                    String decoded = java.net.URLDecoder.decode(paramRedirect, "UTF-8");
                    if (decoded.startsWith(request.getContextPath())) {
                        String afterCtx = decoded.substring(request.getContextPath().length());
                        boolean isLoginTarget = afterCtx.startsWith("/login")
                                || afterCtx.equals("/login.jsp")
                                || afterCtx.startsWith("/login.jsp");
                        if (!isLoginTarget) {
                            redirectURL = decoded;
                        }
                    }
                } catch (Exception ignored) {
                    // Neu decode loi, giu nguyen redirectURL theo role
                }
            }

            response.sendRedirect(redirectURL);

        } catch (Exception e) {
            e.printStackTrace();
            forwardWithError(request, response, "Loi he thong: " + e.getMessage());
        }
    }
    
    private void forwardWithError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.setAttribute("username", req.getParameter("username"));
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
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
