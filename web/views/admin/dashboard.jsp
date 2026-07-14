<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../common/header.jsp" />
<style>
    .stat-card { border: none; border-radius: 1rem; box-shadow: 0 2px 12px rgba(0,0,0,0.06); }
    .stat-icon { width: 56px; height: 56px; border-radius: 0.75rem; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; flex-shrink: 0; }
    .card { border: none; border-radius: 1rem; box-shadow: 0 2px 12px rgba(0,0,0,0.06); }
    .card-header { background: #fff; border-bottom: 1px solid #f0f0f0; padding: 1.1rem 1.5rem; border-radius: 1rem 1rem 0 0 !important; }
    .card-header h5 { margin-bottom: 0; font-weight: 700; }
    .table { margin-bottom: 0; }
    .table thead th { background: #f8fafc; border-bottom: 2px solid #e9ecef; font-weight: 700; font-size: 0.78rem; text-transform: uppercase; color: #6c757d; letter-spacing: 0.03em; padding: 0.75rem 1rem; }
    .table tbody td { padding: 0.75rem 1rem; vertical-align: middle; font-size: 0.88rem; }
    .table tbody tr:hover { background: #f8f9ff; }
    .badge-status { font-size: 0.72rem; padding: 0.35em 0.7em; }
    .btn-action { border-radius: 0.4rem; padding: 0.3rem 0.6rem; font-size: 0.78rem; }
    .section-title-page { font-size: 1.6rem; font-weight: 700; color: #1f2937; }
</style>

<div class="d-flex align-items-center justify-content-between mb-4">
    <div>
        <h2 class="section-title-page mb-1"><i class="fas fa-chart-pie me-2 text-primary"></i>Dashboard Quản lý</h2>
        <p class="text-muted mb-0 small">Tổng quan về hoạt động của cửa hàng sửa chữa xe.</p>
    </div>
    <div class="text-end">
        <div class="small text-muted"><i class="fas fa-calendar-day me-1"></i><fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy" /></div>
    </div>
</div>

<c:if test="${not empty stats.lowStockParts && stats.lowStockParts > 0}">
    <div class="alert alert-danger d-flex align-items-center justify-content-between mb-4 py-2 px-3" role="alert" style="border-radius: 0.75rem;">
        <div class="d-flex align-items-center">
            <i class="fas fa-triangle-exclamation fa-lg me-3"></i>
            <div>
                <strong>Cảnh báo!</strong> Có <strong>${stats.lowStockParts}</strong> linh kiện sắp hết hàng.
                <a href="${pageContext.request.contextPath}/admin/manage-parts" class="alert-link text-danger fw-bold ms-1">Kiểm tra kho ngay &rarr;</a>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/admin/manage-parts" class="btn btn-sm btn-danger">
            <i class="fas fa-boxes-stacked me-1"></i>Quản lý kho
        </a>
    </div>
</c:if>

<div class="row g-3 mb-4">
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card">
            <div class="card-body d-flex align-items-center gap-3 p-3">
                <div class="stat-icon bg-primary bg-opacity-10 text-primary"><i class="fas fa-coins"></i></div>
                <div>
                    <div class="text-muted small">Doanh thu tháng này</div>
                    <h3 class="mb-0 fw-bold"><fmt:formatNumber value="${not empty stats.monthlyRevenue ? stats.monthlyRevenue : 0}" pattern="#,##0" /> VND</h3>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card">
            <div class="card-body d-flex align-items-center gap-3 p-3">
                <div class="stat-icon bg-success bg-opacity-10 text-success"><i class="fas fa-file-invoice"></i></div>
                <div>
                    <div class="text-muted small">Đơn hoàn thành tháng này</div>
                    <h3 class="mb-0 fw-bold">${not empty stats.completedOrders ? stats.completedOrders : 0}</h3>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card">
            <div class="card-body d-flex align-items-center gap-3 p-3">
                <div class="stat-icon bg-info bg-opacity-10 text-info"><i class="fas fa-boxes-stacked"></i></div>
                <div>
                    <div class="text-muted small">Linh kiện trong kho</div>
                    <h3 class="mb-0 fw-bold">${not empty stats.totalParts ? stats.totalParts : 0}</h3>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card">
            <div class="card-body d-flex align-items-center gap-3 p-3">
                <div class="stat-icon bg-warning bg-opacity-10 text-warning"><i class="fas fa-users"></i></div>
                <div>
                    <div class="text-muted small">Nhân viên</div>
                    <h3 class="mb-0 fw-bold">${not empty stats.totalStaff ? stats.totalStaff : 0}</h3>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row g-4">
    <div class="col-lg-4">
        <div class="card">
            <div class="card-header"><h5 class="mb-0"><i class="fas fa-chart-bar text-primary me-2"></i>Tổng quan</h5></div>
            <div class="card-body p-3">
                <ul class="list-unstyled mb-0 small">
                    <li class="mb-2 d-flex justify-content-between"><span>Đơn chờ sửa</span><strong class="text-warning">${not empty stats.waitingOrders ? stats.waitingOrders : 0}</strong></li>
                    <li class="mb-2 d-flex justify-content-between"><span>Đơn đang sửa</span><strong class="text-primary">${not empty stats.repairingOrders ? stats.repairingOrders : 0}</strong></li>
                    <li class="mb-2 d-flex justify-content-between"><span>Đơn đã trả</span><strong class="text-success">${not empty stats.completedOrders ? stats.completedOrders : 0}</strong></li>
                    <li class="mb-2 d-flex justify-content-between"><span>Hàng sắp hết</span><strong class="text-danger">${not empty stats.lowStockParts ? stats.lowStockParts : 0}</strong></li>
                    <li class="mb-0 d-flex justify-content-between"><span>Doanh thu hôm nay</span><strong class="text-success"><fmt:formatNumber value="${not empty stats.todayRevenue ? stats.todayRevenue : 0}" pattern="#,##0" /> VND</strong></li>
                </ul>
                <div class="d-flex flex-wrap gap-2 mt-3">
                    <a href="${pageContext.request.contextPath}/admin/manage-invoices" class="btn btn-sm btn-outline-primary">
                        <i class="fas fa-file-invoice me-1"></i>Xem hóa đơn
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/revenue-report" class="btn btn-sm btn-outline-success">
                        <i class="fas fa-chart-line me-1"></i>Xem doanh thu
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/manage-parts" class="btn btn-sm btn-outline-danger">
                        <i class="fas fa-boxes-stacked me-1"></i>Xem kho
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-8">
        <div class="card">
            <div class="card-header d-flex align-items-center justify-content-between">
                <h5 class="mb-0"><i class="fas fa-clock-rotate-left text-primary me-2"></i>Đơn gần đây</h5>
                <a href="${pageContext.request.contextPath}/admin/manage-invoices" class="btn btn-sm btn-outline-primary">Xem tất cả <i class="fas fa-arrow-right ms-1"></i></a>
            </div>
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr><th>Mã đơn</th><th>Biển số</th><th>Khách hàng</th><th>Ngày</th><th>Tổng tiền</th><th>Trạng thái</th></tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty recentOrders}">
                                <c:forEach var="o" items="${recentOrders}">
                                    <tr>
                                        <td class="fw-bold text-primary">#${o.orderID}</td>
                                        <td>${o.licensePlate}</td>
                                        <td>${o.customerName}</td>
                                        <td class="text-muted small"><fmt:formatDate value="${o.receivedDate}" pattern="dd/MM HH:mm" /></td>
                                        <td class="fw-semibold"><fmt:formatNumber value="${o.totalAmount}" pattern="#,##0" /> VND</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${o.status == 'waiting'}"><span class="badge bg-warning text-dark badge-status">Chờ sửa</span></c:when>
                                                <c:when test="${o.status == 'repairing'}"><span class="badge bg-primary badge-status">Đang sửa</span></c:when>
                                                <c:when test="${o.status == 'done'}"><span class="badge bg-success badge-status">Đã xong</span></c:when>
                                                <c:when test="${o.status == 'completed'}"><span class="badge bg-secondary badge-status">Đã trả</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary badge-status">${o.status}</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="6" class="text-center text-muted py-4"><p class="mb-0 small">Chưa có đơn nào.</p></td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="row g-4 mt-2">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header d-flex align-items-center justify-content-between">
                <h5 class="mb-0"><i class="fas fa-boxes-stacked text-danger me-2"></i>Hàng sắp hết</h5>
                <a href="${pageContext.request.contextPath}/admin/manage-parts" class="btn btn-sm btn-outline-danger">Xem kho <i class="fas fa-arrow-right ms-1"></i></a>
            </div>
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty lowStockParts}">
                        <ul class="list-unstyled mb-0">
                            <c:forEach var="p" items="${lowStockParts}">
                                <li class="d-flex justify-content-between align-items-center p-3 border-bottom">
                                    <div>
                                        <div class="fw-semibold small">${p.partName}</div>
                                        <div class="text-muted" style="font-size:0.75rem;">Còn lại: <strong class="text-danger">${p.stock}</strong></div>
                                    </div>
                                    <span class="badge bg-danger badge-status">Sắp hết</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center text-muted py-4"><i class="fas fa-check-circle fa-2x mb-2 opacity-25 text-success"></i><p class="small mb-0">Kho còn đủ hàng.</p></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
