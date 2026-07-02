<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
    :root {
        --rs-primary: #4361ee;
        --rs-primary-dark: #3730a3;
        --rs-bg: #f1f5f9;
        --rs-sidebar-width: 260px;
        --rs-topbar-height: 70px;
    }

    *, *::before, *::after {
        box-sizing: border-box;
    }

    body {
        background-color: var(--rs-bg);
        font-family: 'Plus Jakarta Sans', sans-serif;
        color: #334155;
        margin: 0;
        overflow-x: hidden;
    }

    .main-wrapper {
        margin-left: var(--rs-sidebar-width);
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        transition: margin-left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .topbar {
        height: var(--rs-topbar-height);
        background: rgba(255, 255, 255, 0.92);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border-bottom: 1px solid #e2e8f0;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 1.75rem;
        position: sticky;
        top: 0;
        z-index: 1020;
        box-shadow: 0 1px 3px rgba(0,0,0,0.04);
    }

    .topbar-title {
        font-size: 0.85rem;
        font-weight: 600;
        color: #64748b;
    }

    .topbar-title strong {
        color: #1e293b;
    }

    .topbar-actions {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .topbar-btn {
        width: 40px;
        height: 40px;
        border: 1px solid #e2e8f0;
        border-radius: 10px;
        background: #fff;
        color: #64748b;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        transition: all 0.2s;
        position: relative;
        cursor: pointer;
    }

    .topbar-btn:hover {
        background: #f8fafc;
        color: var(--rs-primary);
        border-color: var(--rs-primary);
    }

    .topbar-btn .notif-dot {
        position: absolute;
        top: 7px;
        right: 7px;
        width: 8px;
        height: 8px;
        background: #ef4444;
        border-radius: 50%;
        border: 2px solid #fff;
    }

    .topbar-divider {
        width: 1px;
        height: 28px;
        background: #e2e8f0;
    }

    .page-content {
        flex: 1;
        padding: 1.75rem;
        max-width: 1440px;
        width: 100%;
    }

    @media (max-width: 991.98px) {
        .main-wrapper {
            margin-left: 0;
        }
    }
</style>

<jsp:include page="sidebar.jsp" />

<div class="main-wrapper">
    <header class="topbar">
        <div class="d-flex align-items-center gap-2">
            <button type="button" class="topbar-btn d-lg-none" onclick="toggleSidebar()" title="Menu">
                <i class="fas fa-bars"></i>
            </button>
            <div class="topbar-title mb-0">
                Xin chào, <strong>${not empty sessionScope.fullName ? sessionScope.fullName : 'Khách'}</strong>
            </div>
        </div>
        <div class="topbar-actions">
            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/logout" class="topbar-btn" title="Đăng xuất">
                    <i class="fas fa-right-from-bracket"></i>
                </a>
            </c:if>
        </div>
    </header>

    <%-- Mở page-content: trang con chèn nội dung ở đây; footer.jsp sẽ đóng .page-content và .main-wrapper --%>
    <div class="page-content">
