package controller;

import dal.CategoryDAO;
import dal.SparePartDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import model.Category;
import model.SparePart;

@WebServlet(name = "ManagePartController", urlPatterns = {"/admin/manage-parts"})
public class ManagePartController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SparePartDAO sparePartDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        this.sparePartDAO = new SparePartDAO();
        this.categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            List<SparePart> parts = sparePartDAO.getAll();
            String q = req.getParameter("q");
            if (q != null && !q.trim().isEmpty()) {
                String keyword = q.trim().toLowerCase(Locale.ROOT);
                List<SparePart> filteredParts = new ArrayList<>();
                for (SparePart part : parts) {
                    Category c = new Category();
                    String partCode = "LK" + part.getPartId();
                    String name = part.getPartName() != null ? part.getPartName().toLowerCase(Locale.ROOT) : "";
                    String category = part.getCategory().getCategoryName() != null ? part.getCategory().getCategoryName().toLowerCase(Locale.ROOT) : "";
                    if (partCode.toLowerCase(Locale.ROOT).contains(keyword)
                            || name.contains(keyword)
                            || category.contains(keyword)) {
                        filteredParts.add(part);
                    }
                }
                parts = filteredParts;
                req.setAttribute("q", q.trim());
            }
            int lowStockCount = sparePartDAO.countLowStock();
            req.setAttribute("parts", parts);
            req.setAttribute("lowStockCount", lowStockCount);
            req.setAttribute("categories", categoryDAO.getAll());

            // Handle edit mode
            String editParam = req.getParameter("edit");
            if (editParam != null && !editParam.isEmpty()) {
                try {
                    int editId = Integer.parseInt(editParam);
                    SparePart editPart = sparePartDAO.getById(editId);
                    req.setAttribute("editPart", editPart);
                } catch (NumberFormatException ignored) {}
            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Loi khi tai danh sach: " + e.getMessage());
        }

        req.getRequestDispatcher("/views/admin/manage-parts.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                String partName = req.getParameter("partName");
                String categoryIDStr = req.getParameter("categoryID");
                String costPriceStr = req.getParameter("costPrice");
                String priceStr = req.getParameter("price");
                String stockStr = req.getParameter("stock");
                String minStockStr = req.getParameter("minStock");

                if (partName == null || partName.trim().isEmpty()) {
                    forwardError(req, resp, "Vui long nhap ten linh kien.");
                    return;
                }

                int categoryID = 1;
                if (categoryIDStr != null && !categoryIDStr.isEmpty()) {
                    try { categoryID = Integer.parseInt(categoryIDStr); } catch (NumberFormatException ignored) {}
                }

                double costPrice = 0, price = 0;
                int stock = 0, minStock = 5;

                if (costPriceStr != null && !costPriceStr.isEmpty()) {
                    try { costPrice = Double.parseDouble(costPriceStr); } catch (NumberFormatException ignored) {}
                }
                if (priceStr != null && !priceStr.isEmpty()) {
                    try { price = Double.parseDouble(priceStr); } catch (NumberFormatException ignored) {}
                }
                if (stockStr != null && !stockStr.isEmpty()) {
                    try { stock = Integer.parseInt(stockStr); } catch (NumberFormatException ignored) {}
                }
                if (minStockStr != null && !minStockStr.isEmpty()) {
                    try { minStock = Integer.parseInt(minStockStr); } catch (NumberFormatException ignored) {}
                }

                sparePartDAO.create(partName.trim(), categoryID, costPrice, price, stock, minStock);
                req.setAttribute("success", "Them linh kien thanh cong!");

            } else if ("edit".equals(action)) {
                String partIDStr = req.getParameter("partID");
                String partName = req.getParameter("partName");
                String priceStr = req.getParameter("price");
                String stockStr = req.getParameter("stock");
                String minStockStr = req.getParameter("minStock");

                if (partIDStr == null || partIDStr.isEmpty() || partName == null || partName.trim().isEmpty()) {
                    forwardError(req, resp, "Vui long nhap day du thong tin.");
                    return;
                }

                int partID = Integer.parseInt(partIDStr);
                double price = 0;
                int stock = 0, minStock = 5;

                if (priceStr != null && !priceStr.isEmpty()) {
                    try { price = Double.parseDouble(priceStr); } catch (NumberFormatException ignored) {}
                }
                if (stockStr != null && !stockStr.isEmpty()) {
                    try { stock = Integer.parseInt(stockStr); } catch (NumberFormatException ignored) {}
                }
                if (minStockStr != null && !minStockStr.isEmpty()) {
                    try { minStock = Integer.parseInt(minStockStr); } catch (NumberFormatException ignored) {}
                }

                sparePartDAO.update(partID, partName.trim(), BigDecimal.valueOf(price), stock, minStock);
                req.setAttribute("success", "Cap nhat linh kien thanh cong!");

            } else if ("import".equals(action)) {
                String partIDStr = req.getParameter("partID");
                String quantityStr = req.getParameter("quantity");
                if (partIDStr != null && !partIDStr.isEmpty() && quantityStr != null && !quantityStr.isEmpty()) {
                    int partID = Integer.parseInt(partIDStr);
                    int quantity = Integer.parseInt(quantityStr);
                    sparePartDAO.importStock(partID, quantity);
                    req.setAttribute("success", "Nhap hang thanh cong!");
                }
            } else if ("delete".equals(action)) {
                String partIDStr = req.getParameter("partID");
                if (partIDStr != null && !partIDStr.isEmpty()) {
                    try {
                        int partID = Integer.parseInt(partIDStr);
                        sparePartDAO.delete(partID);
                        req.setAttribute("success", "Xoa linh kien thanh cong!");
                    } catch (SQLException e) {
                        req.setAttribute("error", e.getMessage());
                    }
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
