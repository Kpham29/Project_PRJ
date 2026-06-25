<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập và đăng ký - RepairShop</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        :root {
            --primary-grad: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
        }
        body {
            background: #f4f7fe;
            background-image: radial-gradient(#0d6efd 0.5px, transparent 0.5px);
            background-size: 20px 20px;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            width: 100%;
            max-width: 480px;
            background: #fff;
            border: none;
            border-radius: 1.5rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .login-header {
            background: var(--primary-grad);
            padding: 2.5rem 2rem;
            text-align: center;
            color: white;
        }
        .brand-logo {
            width: 60px;
            height: 60px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin: 0 auto 1rem;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }
        .nav-auth {
            display: flex;
            background: #f8f9fa;
            padding: 0.5rem;
            margin: 1.5rem 2rem 0;
            border-radius: 1rem;
        }
        .nav-auth .nav-link {
            flex: 1;
            text-align: center;
            border-radius: 0.75rem;
            color: #6c757d;
            font-weight: 600;
            padding: 0.6rem;
            transition: all 0.3s;
            border: none;
        }
        .nav-auth .nav-link.active {
            background: #fff;
            color: #0d6efd;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }
        .login-body { padding: 2rem; }
        .form-label { font-size: 0.85rem; font-weight: 600; color: #495057; }
        .input-group-text { background: #f8f9fa; border-right: none; color: #adb5bd; }
        .form-control { border-left: none; padding: 0.6rem 0.75rem; }
        .form-control:focus { box-shadow: none; border-color: #dee2e6; }
        .input-group:focus-within { border: 1px solid #0d6efd; border-radius: 0.375rem; }
        .btn-auth {
            background: var(--primary-grad);
            border: none;
            padding: 0.75rem;
            font-weight: 700;
            border-radius: 0.75rem;
            margin-top: 1rem;
            transition: transform 0.2s;
        }
        .btn-auth:hover { transform: translateY(-2px); opacity: 0.95; }
        .reg-note {
            font-size: 0.75rem;
            background: #e7f1ff;
            color: #0c63e4;
            padding: 0.75rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header">
        <div class="brand-logo"><i class="fas fa-tools"></i></div>
        <h3 class="fw-bold mb-1">RepairShop</h3>
        <p class="small opacity-75 mb-0">Hệ thống quản lý dịch vụ sửa chữa xe máy chuyên nghiệp</p>
    </div>

    <nav class="nav nav-auth" id="authTabs">
        <button class="nav-link ${showRegister ? '' : 'active'}" data-bs-toggle="tab" data-bs-target="#pane-login" type="button">Đăng nhập</button>
        <button class="nav-link ${showRegister ? 'active' : ''}" data-bs-toggle="tab" data-bs-target="#pane-register" type="button">Đăng ký</button>
    </nav>

    <div class="login-body tab-content">
        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 small"><i class="fas fa-exclamation-circle me-2"></i>${error}</div>
        </c:if>
        <c:if test="${not empty registerError}">
            <div class="alert alert-danger py-2 small"><i class="fas fa-circle-exclamation me-2"></i>${registerError}</div>
        </c:if>
        <c:if test="${not empty registerSuccess}">
            <div class="alert alert-success py-2 small"><i class="fas fa-check-circle me-2"></i>${registerSuccess}</div>
        </c:if>

        <div class="tab-pane fade ${showRegister ? '' : 'show active'}" id="pane-login">
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <label class="form-label">Tên đăng nhập</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" name="username" class="form-control" placeholder="Nhập tên đăng nhập" value="${username}" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Mật khẩu</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                    </div>
                </div>
                <div class="d-flex justify-content-between mb-4">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="remember">
                        <label class="form-check-label small text-muted" for="remember">Ghi nhớ đăng nhập</label>
                    </div>
                    <span class="small text-muted">Không hỗ trợ quên mật khẩu trong phiên bản này</span>
                </div>
                <button type="submit" class="btn btn-primary btn-auth w-100 text-white">Vào hệ thống</button>
            </form>
        </div>

        <div class="tab-pane fade ${showRegister ? 'show active' : ''}" id="pane-register">
            <div class="reg-note text-center">
                <i class="fas fa-info-circle me-1"></i> Đăng ký dành cho <b>khách hàng</b> đặt lịch và theo dõi xe.
            </div>
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="mb-3">
                    <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                        <input type="text" name="fullName" class="form-control" placeholder="Ví dụ: Nguyễn Văn A" value="${regFullName}" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Tên tài khoản <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-at"></i></span>
                        <input type="text" name="username" class="form-control" placeholder="username123" value="${regUsername}" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6 mb-3">
                        <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                        <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                    </div>
                    <div class="col-6 mb-3">
                        <label class="form-label">Xác nhận <span class="text-danger">*</span></label>
                        <input type="password" name="confirmPassword" class="form-control" placeholder="••••••••" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Số điện thoại</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                        <input type="tel" name="phone" class="form-control" placeholder="090..." value="${regPhone}">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary btn-auth w-100 text-white">Tạo tài khoản</button>
            </form>
        </div>
    </div>

    <div class="pb-4 text-center">
        <a href="${pageContext.request.contextPath}/" class="text-muted small text-decoration-none">
            <i class="fas fa-arrow-left me-1"></i> Quay lại trang chủ
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
