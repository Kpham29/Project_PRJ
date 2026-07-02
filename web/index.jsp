<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RepairShop - Hệ thống quản lý sửa chữa xe</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        :root {
            --primary-color: #0d6efd;
            --accent-color: #f89406;
        }

        body {
            background-color: #f8f9fa;
        }

        .hero-home {
            background: linear-gradient(rgba(13, 110, 253, 0.85), rgba(10, 88, 202, 0.9)),
                        url('https://images.unsplash.com/photo-1597766353982-15942478338e?auto=format&fit=crop&q=80&w=2000');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 5rem 1rem;
            border-radius: 0 0 2rem 2rem;
            margin-bottom: 3rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .feature-card {
            transition: all 0.3s ease;
            border-radius: 1rem;
            border: none;
            overflow: hidden;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(13, 110, 253, 0.15) !important;
        }

        .card-icon {
            width: 70px;
            height: 70px;
            background: rgba(13, 110, 253, 0.1);
            color: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 1.5rem;
            transition: all 0.3s ease;
        }

        .feature-card:hover .card-icon {
            background: var(--primary-color);
            color: white;
        }

        .stat-badge {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(5px);
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<jsp:include page="views/common/header.jsp"/>

<div class="hero-home text-center container-fluid">
    <div class="container">
        <span class="stat-badge mb-3 d-inline-block">
            <i class="fas fa-check-circle me-1"></i> Đối tác tin cậy cho xế yêu của bạn
        </span>
        <h1 class="display-4 fw-bold mb-3">
            HỆ THỐNG QUẢN LÝ SỬA CHỮA XE
        </h1>
        <p class="lead mb-4 opacity-90 mx-auto" style="max-width: 700px;">
            Giải pháp số hóa giúp tối ưu quy trình tiếp nhận, theo dõi tiến độ và quản lý linh kiện chuyên nghiệp nhất hiện nay.
        </p>

        <div class="d-flex flex-wrap justify-content-center gap-3">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="bg-white text-dark p-3 rounded-pill shadow-lg d-flex align-items-center">
                        <div class="bg-primary text-white rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                            <i class="fas fa-user"></i>
                        </div>
                        <span class="pe-3">Chào mừng quay trở lại, <strong>${sessionScope.fullName}</strong>!</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-light btn-lg px-5 rounded-pill shadow">
                        <i class="fas fa-sign-in-alt me-2 text-primary"></i>Đăng nhập ngay
                    </a>
                    <a href="#lien-he" class="btn btn-outline-light btn-lg px-5 rounded-pill">
                        Hỗ trợ 24/7
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<div class="container mb-5">
    <div class="row g-4 justify-content-center">
        <div class="col-md-6 col-lg-3">
            <div class="card feature-card shadow-sm h-100 text-center p-4">
                <div class="card-body">
                    <div class="card-icon"><i class="fas fa-motorcycle"></i></div>
                    <h5 class="fw-bold">Quản lý xe</h5>
                    <p class="text-muted small">Tra cứu biển số, thông tin đời xe và lịch sử bảo dưỡng định kỳ.</p>
                    <c:choose>
                        <c:when test="${sessionScope.roleID == 1}">
                            <a href="${pageContext.request.contextPath}/admin/manage-vehicles" class="btn btn-primary rounded-pill w-100">Quản lý xe</a>
                        </c:when>
                        <c:when test="${sessionScope.roleID == 2}">
                            <a href="${pageContext.request.contextPath}/staff/search" class="btn btn-primary rounded-pill w-100">Tra cứu khách hàng</a>
                        </c:when>
                        <c:when test="${sessionScope.roleID == 3}">
                            <a href="${pageContext.request.contextPath}/customer/my-bikes" class="btn btn-outline-primary rounded-pill w-100">Xem xe của tôi</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login.jsp?redirect=${pageContext.request.contextPath}/customer/my-bikes" class="btn btn-outline-primary rounded-pill w-100">Đăng nhập để xem xe</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="card feature-card shadow-sm h-100 text-center p-4">
                <div class="card-body">
                    <div class="card-icon"><i class="fas fa-file-invoice-dollar"></i></div>
                    <h5 class="fw-bold">Hóa đơn</h5>
                    <p class="text-muted small">Quản lý báo giá linh kiện, tiền công và xuất hóa đơn minh bạch.</p>
                    <c:choose>
                        <c:when test="${sessionScope.roleID == 1}">
                            <a href="${pageContext.request.contextPath}/admin/manage-invoices" class="btn btn-primary rounded-pill w-100">Quản lý hóa đơn</a>
                        </c:when>
                        <c:when test="${sessionScope.roleID == 2}">
                            <a href="${pageContext.request.contextPath}/staff/invoice-list" class="btn btn-primary rounded-pill w-100">Danh sách hóa đơn</a>
                        </c:when>
                        <c:when test="${sessionScope.roleID == 3}">
                            <a href="${pageContext.request.contextPath}/customer/history" class="btn btn-outline-primary rounded-pill w-100">Lịch sử sửa chữa</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#dich-vu" class="btn btn-outline-primary rounded-pill w-100">Bảng giá dịch vụ</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="card feature-card shadow-sm h-100 text-center p-4">
                <div class="card-body">
                    <div class="card-icon"><i class="fas fa-calendar-alt"></i></div>
                    <h5 class="fw-bold">Đặt lịch</h5>
                    <p class="text-muted small">Chủ động thời gian sửa chữa, tránh chờ đợi vào giờ cao điểm.</p>
                    <c:choose>
                        <c:when test="${sessionScope.roleID == 1}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary rounded-pill w-100">Xem tổng quan</a>
                        </c:when>
                        <c:when test="${sessionScope.roleID == 2}">
                            <a href="${pageContext.request.contextPath}/staff/appointments" class="btn btn-primary rounded-pill w-100">Quản lý lịch hẹn</a>
                        </c:when>
                        <c:when test="${sessionScope.roleID == 3}">
                            <a href="${pageContext.request.contextPath}/customer/booking" class="btn btn-outline-primary rounded-pill w-100">Đặt lịch ngay</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login.jsp?redirect=${pageContext.request.contextPath}/customer/booking" class="btn btn-outline-primary rounded-pill w-100">Đăng nhập để đặt lịch</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="card feature-card shadow-sm h-100 text-center p-4">
                <div class="card-body">
                    <div class="card-icon"><i class="fas fa-boxes"></i></div>
                    <h5 class="fw-bold">Kho phụ tùng</h5>
                    <p class="text-muted small">Kho linh kiện luôn sẵn sàng với phụ tùng chính hãng 100%.</p>
                    <c:choose>
                        <c:when test="${sessionScope.roleID == 1}">
                            <a href="${pageContext.request.contextPath}/admin/manage-parts" class="btn btn-primary rounded-pill w-100">Quản lý kho</a>
                        </c:when>
                        <c:when test="${sessionScope.roleID == 2}">
                            <a href="${pageContext.request.contextPath}/staff/create-invoice" class="btn btn-primary rounded-pill w-100">Lập hóa đơn</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#dich-vu" class="btn btn-outline-primary rounded-pill w-100">Xem dịch vụ</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-5 pt-4 g-4" id="dich-vu">
        <div class="col-lg-7">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="row g-0">
                    <div class="col-md-4 d-none d-md-block">
                        <img src="https://images.unsplash.com/photo-1486006920555-c77dcf18193b?auto=format&fit=crop&q=80&w=800"
                             class="img-fluid h-100"
                             style="object-fit: cover;"
                             alt="Thợ sửa xe">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body p-4">
                            <h4 class="fw-bold mb-4 text-primary">Cam kết từ RepairShop</h4>
                            <div class="d-flex mb-3" id="bao-duong-dinh-ky">
                                <i class="fas fa-check-circle text-success mt-1 me-3"></i>
                                <div>
                                    <h6 class="fw-bold mb-0">Thợ tay nghề cao</h6>
                                    <p class="small text-muted mb-0">100% nhân viên được đào tạo chuyên sâu.</p>
                                </div>
                            </div>
                            <div class="d-flex mb-3" id="sua-chua-chung">
                                <i class="fas fa-check-circle text-success mt-1 me-3"></i>
                                <div>
                                    <h6 class="fw-bold mb-0">Minh bạch giá cả</h6>
                                    <p class="small text-muted mb-0">Hóa đơn chi tiết từng hạng mục, không phát sinh lạ.</p>
                                </div>
                            </div>
                            <div class="d-flex" id="thay-phu-tung">
                                <i class="fas fa-check-circle text-success mt-1 me-3"></i>
                                <div>
                                    <h6 class="fw-bold mb-0">Bảo hành linh kiện</h6>
                                    <p class="small text-muted mb-0">Đổi trả 1-1 nếu có lỗi từ nhà sản xuất.</p>
                                </div>
                            </div>
                            <div id="kiem-dinh-xe"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-5" id="lien-he">
            <div class="card border-0 shadow-sm rounded-4 bg-dark text-white p-2">
                <div class="card-body p-4">
                    <h4 class="fw-bold mb-4"><i class="fas fa-headset me-2 text-primary"></i>Hỗ trợ & Liên hệ</h4>
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-primary rounded-circle p-2 me-3"><i class="fas fa-phone-alt fa-fw"></i></div>
                        <div>
                            <p class="small mb-0 opacity-75">Hotline hỗ trợ</p>
                            <h5 class="mb-0 fw-bold">0901 234 567</h5>
                        </div>
                    </div>
                    <div class="d-flex align-items-center mb-4">
                        <div class="bg-primary rounded-circle p-2 me-3"><i class="fas fa-map-marker-alt fa-fw"></i></div>
                        <div>
                            <p class="small mb-0 opacity-75">Địa chỉ</p>
                            <h5 class="mb-0 fw-bold">123 Đường ABC, Hà Nội</h5>
                        </div>
                    </div>
                    <div class="bg-white text-dark p-3 rounded-3">
                        <p class="small fw-bold mb-2">Giờ mở cửa:</p>
                        <div class="d-flex justify-content-between small">
                            <span>Thứ 2 - Thứ 7:</span>
                            <span class="fw-bold">08:00 - 18:00</span>
                        </div>
                        <div class="d-flex justify-content-between small">
                            <span>Chủ nhật:</span>
                            <span class="text-danger fw-bold">Nghỉ</span>
                        </div>
                    </div>
                    <div class="mt-4">
                        <div class="small fw-bold text-uppercase opacity-75 mb-2" id="huong-dan-dat-lich">Hướng dẫn đặt lịch</div>
                        <p class="small mb-3 opacity-90">Đăng nhập, chọn xe, chọn thời gian phù hợp và gửi mô tả tình trạng xe để cửa hàng xác nhận.</p>
                        <div class="small fw-bold text-uppercase opacity-75 mb-2" id="chinh-sach-bao-hanh">Chính sách bảo hành</div>
                        <p class="small mb-3 opacity-90">Linh kiện thay thế chính hãng được hỗ trợ kiểm tra và bảo hành theo quy định của nhà cung cấp.</p>
                        <div class="small fw-bold text-uppercase opacity-75 mb-2" id="cau-hoi-thuong-gap">Câu hỏi thường gặp</div>
                        <p class="small mb-0 opacity-90">Khách hàng có thể theo dõi lịch sử sửa chữa, tình trạng hóa đơn và thời gian hẹn trả xe ngay trong hệ thống.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
</script>

<jsp:include page="views/common/footer.jsp"/>
</body>
</html>
