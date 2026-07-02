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
    .stock-bar { height: 6px; border-radius: 3px; background: #e9ecef; overflow: hidden; }
    .stock-bar-fill { height: 100%; border-radius: 3px; transition: width 0.3s; }
    .badge-status { font-size: 0.72rem; padding: 0.35em 0.7em; }
    .btn-action { border-radius: 0.4rem; padding: 0.3rem 0.6rem; font-size: 0.78rem; }
    .section-title-page { font-size: 1.6rem; font-weight: 700; color: #1f2937; }
</style>
<!-- Page Header -->
<div class="d-flex align-items-center justify-content-between mb-4">
    <div>
        <h2 class="section-title-page mb-1"><i class="fas fa-boxes-stacked me-2 text-primary"></i>Quản lý kho linh kiện</h2>
        <p class="text-muted mb-0 small">Quản lý linh kiện, phụ tùng và nhập hàng.</p>
    </div>
    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addPartModal">
        <i class="fas fa-plus me-1"></i>Them linh kien
    </button>
</div>
<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show mb-3" role="alert"><i class="fas fa-check-circle me-1"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show mb-3" role="alert"><i class="fas fa-circle-exclamation me-1"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty lowStockCount && lowStockCount > 0}">
    <div class="alert alert-warning d-flex align-items-center mb-3" role="alert">
        <i class="fas fa-triangle-exclamation me-2"></i>
        Co <strong>${lowStockCount}</strong> linh kien sap het hang!
    </div>
</c:if>
<div class="card mb-3">
    <div class="card-body py-3">
        <form method="get" class="d-flex gap-2 flex-wrap align-items-end">
            <div class="flex-grow-1">
                <label class="form-label mb-1">Tìm kiếm linh kiện</label>
                <input type="text" class="form-control" name="q" value="${q}" placeholder="Tìm theo mã LK, tên linh kiện hoặc danh mục">
            </div>
            <div>
                <button type="submit" class="btn btn-primary"><i class="fas fa-search me-1"></i>Tìm</button>
            </div>
            <c:if test="${not empty q}">
                <div>
                    <a href="${pageContext.request.contextPath}/admin/manage-parts" class="btn btn-outline-secondary"><i class="fas fa-xmark me-1"></i>Xóa lọc</a>
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
                    <th>Mã</th><th>Tên linh kiện</th><th>Danh mục</th><th>Giá nhập</th><th>Giá bán</th><th>Số lượng</th><th>Trạng thái</th><th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty parts}">
                        <c:forEach var="p" items="${parts}">
                            <tr class="${p.stock <= p.minStock ? 'table-warning' : ''}">
                                <td><span class="fw-bold text-primary">LK${p.partID}</span></td>
                                <td class="fw-semibold">${p.partName}</td>
                                <td class="text-muted small">${p.categoryName}</td>
                                <td class="text-muted"><fmt:formatNumber value="${empty p.costPrice ? 0 : p.costPrice}" pattern="#,##0" /> VND</td>
                                <td class="fw-semibold"><fmt:formatNumber value="${p.price}" pattern="#,##0" /> VND</td>
                                <td>
                                    <c:set var="denBar" value="${p.minStock * 5}" />
                                    <c:set var="rawBar" value="${denBar > 0 ? (p.stock * 100) / denBar : 0}" />
                                    <c:set var="barPct" value="${rawBar > 100 ? 100 : rawBar}" />
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="fw-bold ${p.stock <= p.minStock ? 'text-danger' : ''}">${p.stock}</span>
                                        <div class="stock-bar" style="width:60px;">
                                            <div class="stock-bar-fill bg-${p.stock <= 0 ? 'danger' : p.stock <= p.minStock ? 'warning' : 'success'}"
                                                 style="width:${barPct}%"></div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.stock <= 0}"><span class="badge bg-danger badge-status">Het hang</span></c:when>
                                        <c:when test="${p.stock <= p.minStock}"><span class="badge bg-warning text-dark badge-status">Sap het</span></c:when>
                                        <c:otherwise><span class="badge bg-success badge-status">Con hang</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex gap-1">
                                        <c:if test="${p.stock <= p.minStock}">
                                            <button class="btn btn-sm btn-outline-success btn-action" title="Nhap them" data-bs-toggle="modal" data-bs-target="#importModal${p.partID}">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </c:if>
                                        <button class="btn btn-sm btn-outline-warning btn-action" title="Chinh sua" data-bs-toggle="modal" data-bs-target="#editPartModal${p.partID}">
                                            <i class="fas fa-pen"></i>
                                        </button>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/manage-parts" style="display:inline;"
                                              onsubmit="return confirm('Xoa linh kien ${p.partName}? Hanh dong nay co the lam mat du lieu lien quan.')">
                                            <input type="hidden" name="action" value="delete" />
                                            <input type="hidden" name="partID" value="${p.partID}" />
                                            <button type="submit" class="btn btn-sm btn-outline-danger btn-action" title="Xoa">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="8" class="text-center text-muted py-5"><p class="mb-0 small">Chưa có linh kiện nào.</p></td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
<!-- Add Part Modal -->
<div class="modal fade" id="addPartModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-boxes-stacked me-2 text-primary"></i>Them linh kien moi</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/manage-parts" method="post">
                <input type="hidden" name="action" value="add" />
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Ten linh kien <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="partName" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Danh muc</label>
                        <select class="form-select" name="categoryID">
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.categoryID}">${c.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="mb-3">
                                <label class="form-label">Gia nhap</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" name="costPrice" value="0" min="0" step="1000" />
                                    <span class="input-group-text">VND</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="mb-3">
                                <label class="form-label">Gia ban</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" name="price" min="0" step="1000" required />
                                    <span class="input-group-text">VND</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="mb-3">
                                <label class="form-label">So luong</label>
                                <input type="number" class="form-control" name="stock" value="0" min="0" required />
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="mb-3">
                                <label class="form-label">So luong toi thieu</label>
                                <input type="number" class="form-control" name="minStock" value="5" min="0" />
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

<!-- Edit Part Modals -->
<c:forEach var="p" items="${parts}">
<div class="modal fade" id="editPartModal${p.partID}" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-pen me-2 text-warning"></i>Chinh sua linh kien</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/manage-parts" method="post">
                <input type="hidden" name="action" value="edit" />
                <input type="hidden" name="partID" value="${p.partID}" />
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Ten linh kien <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="partName" value="${p.partName}" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Gia ban (VND)</label>
                        <div class="input-group">
                            <input type="number" class="form-control" name="price" value="${p.price}" min="0" step="1000" required />
                            <span class="input-group-text">VND</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="mb-3">
                                <label class="form-label">So luong hien tai</label>
                                <input type="number" class="form-control" name="stock" value="${p.stock}" min="0" required />
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="mb-3">
                                <label class="form-label">So luong toi thieu</label>
                                <input type="number" class="form-control" name="minStock" value="${p.minStock}" min="0" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huy</button>
                    <button type="submit" class="btn btn-warning"><i class="fas fa-floppy-disk me-1"></i>Luu thay doi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Import Stock Modal -->
<div class="modal fade" id="importModal${p.partID}" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-plus me-2 text-success"></i>Nhap hang</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/manage-parts" method="post">
                <input type="hidden" name="action" value="import" />
                <input type="hidden" name="partID" value="${p.partID}" />
                <div class="modal-body">
                    <p class="small text-muted mb-2">Linh kien: <strong>${p.partName}</strong></p>
                    <p class="small text-muted mb-3">Hien tai: <strong>${p.stock}</strong></p>
                    <div class="mb-3">
                        <label class="form-label">So luong nhap them</label>
                        <input type="number" class="form-control" name="quantity" min="1" value="10" required />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Huy</button>
                    <button type="submit" class="btn btn-success btn-sm"><i class="fas fa-plus me-1"></i>Nhap hang</button>
                </div>
            </form>
        </div>
    </div>
</div>
</c:forEach>
<jsp:include page="../common/footer.jsp" />
