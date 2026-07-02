/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import model.Service;

/**
 *
 * @author HBDELL
 */
@WebServlet(name = "ManageServiceController", urlPatterns = {"/admin/manage-services"})
public class ManageServiceController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        this.serviceDAO = new ServiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            List<Service> services = serviceDAO.getAll();
            String q = req.getParameter("q");
            if (q != null && !q.trim().isEmpty()) {
                String keyword = q.trim().toLowerCase(Locale.ROOT);
                List<Service> filteredServices = new ArrayList<>();
                for (Service service : services) {
                    String serviceCode = "DV" + service.getServiceId();
                    String name = service.getServiceName() != null ? service.getServiceName().toLowerCase(Locale.ROOT) : "";
                    String description = service.getDescription() != null ? service.getDescription().toLowerCase(Locale.ROOT) : "";
                    String estimatedTime = String.valueOf(service.getEstimatedTime()) != null ? String.valueOf(service.getEstimatedTime()).toLowerCase(Locale.ROOT) : "";
                    if (serviceCode.toLowerCase(Locale.ROOT).contains(keyword)
                            || name.contains(keyword)
                            || description.contains(keyword)
                            || estimatedTime.contains(keyword)) {
                        filteredServices.add(service);
                    }
                }
                services = filteredServices;
                req.setAttribute("q", q.trim());
            }
            req.setAttribute("services", services);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        req.getRequestDispatcher("/views/admin/manage-services.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                String serviceName = req.getParameter("serviceName");
                String description = req.getParameter("description");
                String priceStr = req.getParameter("price");
                String estimatedTime = req.getParameter("estimatedTime");

                if (serviceName == null || serviceName.trim().isEmpty()) {
                    forwardError(req, resp, "Vui long nhap ten dich vu.");
                    return;
                }

                double price = 0;
                if (priceStr != null && !priceStr.isEmpty()) {
                    try { price = Double.parseDouble(priceStr); } catch (NumberFormatException ignored) {}
                }

                serviceDAO.create(serviceName.trim(), description, price, estimatedTime);
                req.setAttribute("success", "Them dich vu thanh cong!");

            } else if ("edit".equals(action)) {
                String serviceIDStr = req.getParameter("serviceID");
                String serviceName = req.getParameter("serviceName");
                String description = req.getParameter("description");
                String priceStr = req.getParameter("price");
                String estimatedTime = req.getParameter("estimatedTime");

                if (serviceIDStr != null && !serviceIDStr.isEmpty() && serviceName != null) {
                    int serviceID = Integer.parseInt(serviceIDStr);
                    double price = 0;
                    if (priceStr != null && !priceStr.isEmpty()) {
                        try { price = Double.parseDouble(priceStr); } catch (NumberFormatException ignored) {}
                    }
                    serviceDAO.update(serviceID, serviceName.trim(), description, price, estimatedTime);
                    req.setAttribute("success", "Cap nhat dich vu thanh cong!");
                }

            } else if ("toggle".equals(action)) {
                String serviceIDStr = req.getParameter("serviceID");
                if (serviceIDStr != null && !serviceIDStr.isEmpty()) {
                    int serviceID = Integer.parseInt(serviceIDStr);
                    serviceDAO.toggleStatus(serviceID);
                    req.setAttribute("success", "Cap nhat trang thai thanh cong!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            forwardError(req, resp, "Loi: " + e.getMessage());
            return;
        }

        doGet(req, resp);
    }

    private void forwardError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        doGet(req, resp);
    }

}
