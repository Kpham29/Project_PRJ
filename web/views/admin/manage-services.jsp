<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../common/header.jsp" />
<style>
    .card { border: none; border-radius: 1rem; box-shadow: 0 2px 12px rgba(0,0,0,0.06); }
    .card-header { background: #fff; border-bottom: 1px solid #f0f0f0; padding: 1.1rem 1.5rem; border-radius: 1rem 1rem 0 0 !important; }
    .card-header h5 { margin-bottom: 0; font-weight: 700; }
    .form-label { font-weight: 600; font-size: 0.82rem; color: #374151; margin-bottom: 0.3rem; }
    .form-control, .form-select { border-radius: 0.5rem; font-size: 0.88rem; padding: 0.5rem 0.75rem; border-color: #e2e8f0; }
    .form-control:focus, .form-select:focus { border-color: #0d6efd; box-shadow: 0 0 0 3px rgba(13,110,253,0.12); }
    .table { margin-bottom: 0; }
    .table thead th { background: #f8fafc; border-bottom: 2px solid #e9ecef; font-weight: 700; font-size: 0.78rem; text-transform: uppercase; color: #6c757d; padding: 0.75rem 1rem; }
    .table tbody td { padding: 0.75rem 1rem; vertical-align: middle; font-size: 0.88rem; }
    .table tbody tr:hover { background: #f8f9ff; }
    .badge-status { font-size: 0.72rem; padding: 0.35em 0.7em; }
    .btn-action { border-radius: 0.4rem; padding: 0.3rem 0.6rem; font-size: 0.78rem; }
    .section-title-page { font-size: 1.6rem; font-weight: 700; color: #1f2937; }
</style>
<!-- Page Header -->
<div class="d-flex align-items-center justify-content-between mb-4">
    <div>
        <h2 class="section-title-page mb-1"><i class="fas fa-list-check me-2 text-primary"></i>Quản lý dịch vụ</h2>
        <p class="text-muted mb-0 small">Thêm, chỉnh sửa danh mục dịch vụ và đơn giá.</p>
    </div>
    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addServiceModal">
        <i class="fas fa-plus me-1"></i>Them dich vu moi
    </button>
</div>
<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show mb-3" role="alert"><i class="fas fa-check-circle me-1"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show mb-3" role="alert"><i class="fas fa-circle-exclamation me-1"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<div class="card mb-3">
    <div class="card-body py-3">
        <form method="get" class="d-flex gap-2 flex-wrap align-items-end">
            <div class="flex-grow-1">
                <label class="form-label mb-1">Tìm kiếm dịch vụ</label>
                <input type="text" class="form-control" name="q" value="${q}" placeholder="Tìm theo mã DV, tên dịch vụ, mô tả hoặc thời gian ước tính">
            </div>
            <div>
                <button type="submit" class="btn btn-primary"><i class="fas fa-search me-1"></i>Tìm</button>
            </div>
            <c:if test="${not empty q}">
                <div>
                    <a href="${pageContext.request.contextPath}/admin/manage-services" class="btn btn-outline-secondary"><i class="fas fa-xmark me-1"></i>Xóa lọc</a>
                </div>
            </c:if>
        </form>
    </div>
</div>
<!-- Table -->
<div class="card">
    <div class="table-responsive">
        <table class="table align-middle">
            <thead>
                <tr>
                    <th>Mã</th><th>Tên dịch vụ</th><th>Mô tả</th><th>Đơn giá</th><th>Thời gian ước tính</th><th>Trạng thái</th><th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty services}">
                        <c:forEach var="s" items="${services}">
                            <tr>
                                <td><span class="fw-bold text-primary">DV${s.serviceId}</span></td>
                                <td class="fw-semibold">${s.serviceName}</td>
                                <td class="text-muted small">${not empty s.description ? s.description : '---'}</td>
                                <td class="fw-semibold text-success"><fmt:formatNumber value="${s.price}" pattern="#,##0" /> VND</td>
                                <td class="text-muted">${not empty s.estimatedTime ? s.estimatedTime : '---'}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${s.status == 'active'}"><span class="badge bg-success badge-status">Hoat dong</span></c:when>
                                        <c:otherwise><span class="badge bg-secondary badge-status">Tam ngung</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex gap-1">
                                        <a href="${pageContext.request.contextPath}/admin/manage-services?edit=${s.serviceId}" class="btn btn-sm btn-outline-warning btn-action" title="Chinh sua">
                                            <i class="fas fa-pen"></i>
                                        </a>
                                        <form action="${pageContext.request.contextPath}/admin/manage-services" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="toggle" />
                                            <input type="hidden" name="serviceID" value="${s.serviceId}" />
                                            <button type="submit" class="btn btn-sm ${s.status == 'active' ? 'btn-outline-danger' : 'btn-outline-success'} btn-action" title="${s.status == 'active' ? 'Tam ngung' : 'Kich hoat'}">
                                                <i class="fas fa-${s.status == 'active' ? 'pause' : 'play'}"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="7" class="text-center text-muted py-5"><p class="mb-0 small">Chưa có dịch vụ nào.</p></td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
<!-- Add Service Modal -->
<div class="modal fade" id="addServiceModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-list-check me-2 text-primary"></i>Them dich vu moi</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/manage-services" method="post">
                <input type="hidden" name="action" value="add" />
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Ten dich vu <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="serviceName" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea class="form-control" name="description" rows="2" placeholder="Mô tả chi tiết dịch vụ..."></textarea>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="mb-3">
                                <label class="form-label">Don gia <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="number" class="form-control" name="price" min="0" step="10000" required />
                                    <span class="input-group-text">VND</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="mb-3">
                                <label class="form-label">Thoi gian uoc tinh</label>
                                <input type="text" class="form-control" name="estimatedTime" placeholder="VD: 1-2 gio" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huy</button>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-floppy-disk me-1"></i>Luu</button>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="../common/footer.jsp" />
