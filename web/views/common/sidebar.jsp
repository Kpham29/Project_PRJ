<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
    :root {
        --rs-primary: #4361ee;
        --rs-primary-soft: rgba(67, 97, 238, 0.1);
        --rs-dark: #0f172a;
        --rs-sidebar-bg: #1e293b;
        --rs-sidebar-width: 260px;
        --rs-topbar-height: 70px;
        --rs-transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        bottom: 0;
        width: var(--rs-sidebar-width);
        background: var(--rs-sidebar-bg);
        z-index: 1050;
        transition: var(--rs-transition);
        display: flex;
        flex-direction: column;
        overflow-y: auto;
        scrollbar-width: thin;
        scrollbar-color: rgba(255,255,255,0.1) transparent;
    }

    .sidebar::-webkit-scrollbar {
        width: 4px;
    }

    .sidebar::-webkit-scrollbar-thumb {
        background: rgba(255,255,255,0.1);
        border-radius: 2px;
    }

    .sidebar-brand {
        height: var(--rs-topbar-height);
        display: flex;
        align-items: center;
        padding: 0 1.5rem;
        border-bottom: 1px solid rgba(255,255,255,0.05);
        flex-shrink: 0;
    }

    .brand-logo {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, var(--rs-primary), #7209b7);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.1rem;
        flex-shrink: 0;
    }

    .sidebar-brand-name {
        margin-left: 0.875rem;
    }

    .sidebar-brand-name .main {
        font-weight: 800;
        font-size: 1.05rem;
        color: #fff;
        line-height: 1.2;
    }

    .sidebar-brand-name .main span {
        color: #60a5fa;
    }

    .sidebar-brand-name .sub {
        font-size: 0.6rem;
        color: #475569;
        letter-spacing: 0.5px;
    }

    .sidebar-nav {
        flex: 1;
        padding: 1rem 0.75rem;
        overflow-y: auto;
    }

    .sidebar-section-label {
        color: #334155;
        font-size: 0.65rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1.2px;
        padding: 1rem 1rem 0.4rem;
    }

    .sidebar-link {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 0.75rem 1rem;
        color: #94a3b8;
        text-decoration: none;
        font-size: 0.875rem;
        font-weight: 500;
        border-radius: 10px;
        transition: var(--rs-transition);
        margin-bottom: 2px;
        white-space: nowrap;
        overflow: hidden;
    }

    .sidebar-link i {
        font-size: 1rem;
        width: 22px;
        text-align: center;
        flex-shrink: 0;
    }

    .sidebar-link span {
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .sidebar-link:hover {
        background: rgba(255,255,255,0.06);
        color: #f1f5f9;
    }

    .sidebar-link.active {
        background: var(--rs-primary);
        color: #fff;
        box-shadow: 0 4px 12px rgba(67, 97, 238, 0.35);
    }

    .sidebar-divider {
        height: 1px;
        background: rgba(255,255,255,0.05);
        margin: 0.75rem 1rem;
    }

    .sidebar-user-area {
        padding: 1rem 1.25rem;
        border-top: 1px solid rgba(255,255,255,0.05);
        flex-shrink: 0;
    }

    .user-avatar-circle {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--rs-primary), #7209b7);
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 0.8rem;
        flex-shrink: 0;
    }

    .user-info-block .name {
        font-size: 0.825rem;
        font-weight: 600;
        color: #f1f5f9;
        line-height: 1.3;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .user-info-block .role {
        font-size: 0.7rem;
        color: #475569;
    }

    .sidebar-overlay {
        display: none;
        position: fixed;
        inset: 0;
        background: rgba(15, 23, 42, 0.6);
        z-index: 1049;
        backdrop-filter: blur(2px);
    }

    .sidebar-overlay.active {
        display: block;
    }

    @media (max-width: 991.98px) {
        .sidebar {
            transform: translateX(-100%);
        }

        .sidebar.open {
            transform: translateX(0);
        }
    }
</style>

<div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>

<aside class="sidebar" id="sidebar">
    <div class="sidebar-brand">
        <div class="brand-logo"><i class="fas fa-bolt"></i></div>
        <div class="sidebar-brand-name">
            <div class="main">Repair<span>Shop</span></div>
            <div class="sub">Garage Management v1</div>
        </div>
    </div>

    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/"
           class="sidebar-link ${pageContext.request.requestURI.endsWith('/') || fn:contains(pageContext.request.requestURI, 'index.jsp') ? 'active' : ''}">
            <i class="fas fa-house"></i><span>Trang chủ</span>
        </a>

        <div class="sidebar-divider"></div>

        <c:if test="${sessionScope.roleID == 1}">
            <div class="sidebar-section-label">Quản trị</div>

            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'dashboard') ? 'active' : ''}">
                <i class="fas fa-chart-line"></i><span>Báo cáo tổng quan</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manage-staff"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'manage-staff') ? 'active' : ''}">
                <i class="fas fa-user-tie"></i><span>Nhân sự</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manage-customers"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'manage-customers') ? 'active' : ''}">
                <i class="fas fa-users"></i><span>Khách hàng</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manage-vehicles"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'manage-vehicles') ? 'active' : ''}">
                <i class="fas fa-motorcycle"></i><span>Quản lý xe</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manage-parts"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'manage-parts') ? 'active' : ''}">
                <i class="fas fa-boxes-stacked"></i><span>Kho linh kiện</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manage-services"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'manage-services') ? 'active' : ''}">
                <i class="fas fa-list-check"></i><span>Dịch vụ</span>
            </a>

            <div class="sidebar-divider"></div>
            <div class="sidebar-section-label">Hóa đơn &amp; Báo cáo</div>

            <a href="${pageContext.request.contextPath}/admin/manage-invoices"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'manage-invoices') ? 'active' : ''}">
                <i class="fas fa-file-invoice-dollar"></i><span>Hóa đơn</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/revenue-report"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'revenue-report') ? 'active' : ''}">
                <i class="fas fa-chart-line"></i><span>Báo cáo doanh thu</span>
            </a>
        </c:if>

        <c:if test="${sessionScope.roleID == 2}">
            <div class="sidebar-section-label">Kỹ thuật &amp; Bán hàng</div>

            <a href="${pageContext.request.contextPath}/staff/dashboard"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'staff/dashboard') ? 'active' : ''}">
                <i class="fas fa-gauge-high"></i><span>Bảng điều khiển</span>
            </a>
            <a href="${pageContext.request.contextPath}/staff/search"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'staff/search') ? 'active' : ''}">
                <i class="fas fa-magnifying-glass"></i><span>Tìm kiếm KH</span>
            </a>
            <a href="${pageContext.request.contextPath}/staff/create-invoice"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'create-invoice') ? 'active' : ''}">
                <i class="fas fa-file-circle-plus"></i><span>Tạo hóa đơn</span>
            </a>
            <a href="${pageContext.request.contextPath}/staff/invoice-list"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'invoice-list') || fn:contains(pageContext.request.requestURI, 'invoice-detail') || fn:contains(pageContext.request.requestURI, 'vehicle-history') || fn:contains(pageContext.request.requestURI, 'checkout') ? 'active' : ''}">
                <i class="fas fa-clipboard-list"></i><span>Danh sách xe sửa</span>
            </a>
        </c:if>

        <c:if test="${sessionScope.roleID == 3}">
            <div class="sidebar-section-label">Khách hàng</div>

            <a href="${pageContext.request.contextPath}/profile"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'profile') ? 'active' : ''}">
                <i class="fas fa-user-pen"></i><span>Trang cá nhân</span>
            </a>
            <a href="${pageContext.request.contextPath}/customer/my-bikes"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'my-bikes') ? 'active' : ''}">
                <i class="fas fa-motorcycle"></i><span>Xe của tôi</span>
            </a>
            <a href="${pageContext.request.contextPath}/customer/history"
               class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'history') ? 'active' : ''}">
                <i class="fas fa-clock-rotate-left"></i><span>Lịch sử sửa chữa</span>
            </a>
        </c:if>
    </nav>

    <div class="sidebar-user-area">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <div class="d-flex align-items-center gap-2">
                        <div class="user-avatar-circle">
                            ${not empty sessionScope.fullName ? fn:substring(sessionScope.fullName, 0, 1) : 'U'}
                        </div>
                        <div class="user-info-block">
                            <div class="name">${sessionScope.fullName}</div>
                            <div class="role">
                                <c:choose>
                                    <c:when test="${sessionScope.roleID == 1}">Quản trị viên</c:when>
                                    <c:when test="${sessionScope.roleID == 2}">Nhân viên</c:when>
                                    <c:otherwise>Khách hàng</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout"
                       class="sidebar-link text-danger p-2"
                       title="Đăng xuất"
                       style="flex-shrink:0;">
                        <i class="fas fa-right-from-bracket"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/profile"
                       class="sidebar-link ${fn:contains(pageContext.request.requestURI, 'profile') ? 'active' : ''} p-2"
                       title="Trang cá nhân"
                       style="flex-shrink:0;">
                        <i class="fas fa-user-pen"></i>
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="d-flex flex-column gap-2">
                    <a href="${pageContext.request.contextPath}/login.jsp"
                       class="btn btn-primary btn-sm w-100 fw-semibold">
                        <i class="fas fa-right-to-bracket me-1"></i>Đăng nhập
                    </a>
                    <a href="${pageContext.request.contextPath}/login.jsp?showRegister=1"
                       class="btn btn-outline-light btn-sm w-100">
                        Đăng ký
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</aside>

<script>
function toggleSidebar() {
    document.getElementById('sidebar').classList.toggle('open');
    document.getElementById('sidebarOverlay').classList.toggle('active');
}
</script>
