<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

</div><%-- end .page-content --%>
<style>
    footer {
        background-color: #1a1d21;
        border-top: 4px solid var(--rs-primary);
    }
    footer h5, footer h6 {
        color: #ffffff;
    }
    footer .text-muted {
        color: #9ca3af !important;
    }
    footer a.text-muted:hover {
        color: var(--rs-primary) !important;
        text-decoration: underline !important;
        transition: color 0.2s ease;
    }
    .social-icons a {
        width: 36px;
        height: 36px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 50%;
        transition: all 0.3s ease;
    }
    .social-icons a:hover {
        background: var(--rs-primary);
        color: #fff !important;
        transform: translateY(-3px);
    }
    footer hr {
        border-color: rgba(255, 255, 255, 0.1);
    }
</style>

<footer class="text-white mt-auto">
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <h5 class="fw-bold mb-3 d-flex align-items-center">
                    <i class="fas fa-toolbox me-2 text-primary"></i>RepairShop
                </h5>
                <p class="text-muted small mb-4" style="line-height: 1.6;">
                    Hệ thống quản lý sửa chữa xe máy hiện đại, minh bạch và tiện lợi cho khách hàng.
                    Theo dõi lịch hẹn, hóa đơn và tiến độ xử lý tại một nơi.
                </p>
                <div class="d-flex gap-2 social-icons">
                    <a href="${pageContext.request.contextPath}/#lien-he" class="text-muted" aria-label="Liên hệ Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="${pageContext.request.contextPath}/#lien-he" class="text-muted" aria-label="Liên hệ YouTube"><i class="fab fa-youtube"></i></a>
                    <a href="${pageContext.request.contextPath}/#lien-he" class="text-muted" aria-label="Liên hệ Instagram"><i class="fab fa-instagram"></i></a>
                    <a href="${pageContext.request.contextPath}/#lien-he" class="text-muted" aria-label="Liên hệ Email"><i class="fas fa-envelope"></i></a>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <h6 class="fw-bold text-uppercase mb-3 small" style="letter-spacing: 1px;">Liên hệ</h6>
                <ul class="list-unstyled small text-muted mb-0">
                    <li class="mb-3 d-flex gap-2">
                        <i class="fas fa-map-marker-alt text-primary mt-1"></i>
                        <span>123 Đường ABC, Hà Nội</span>
                    </li>
                    <li class="mb-3 d-flex gap-2">
                        <i class="fas fa-phone-alt text-primary mt-1"></i>
                        <span>0901 234 567</span>
                    </li>
                    <li class="mb-3 d-flex gap-2">
                        <i class="fas fa-clock text-primary mt-1"></i>
                        <span>T2 - T6: 08:00 - 18:00<br>Thứ 7: 08:00 - 14:00</span>
                    </li>
                </ul>
            </div>

            <div class="col-lg-2 col-md-6">
                <h6 class="fw-bold text-uppercase mb-3 small" style="letter-spacing: 1px;">Dịch vụ</h6>
                <ul class="list-unstyled small mb-0">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/#bao-duong-dinh-ky" class="text-muted text-decoration-none">Bảo dưỡng định kỳ</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/#sua-chua-chung" class="text-muted text-decoration-none">Sửa chữa chung</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/#thay-phu-tung" class="text-muted text-decoration-none">Thay phụ tùng</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/#kiem-dinh-xe" class="text-muted text-decoration-none">Kiểm định xe</a></li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6">
                <h6 class="fw-bold text-uppercase mb-3 small" style="letter-spacing: 1px;">Hỗ trợ</h6>
                <ul class="list-unstyled small mb-0">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/#huong-dan-dat-lich" class="text-muted text-decoration-none">Hướng dẫn đặt lịch</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/#chinh-sach-bao-hanh" class="text-muted text-decoration-none">Chính sách bảo hành</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/#cau-hoi-thuong-gap" class="text-muted text-decoration-none">Câu hỏi thường gặp</a></li>
                </ul>
            </div>
        </div>

        <hr class="my-4">

        <div class="row align-items-center">
            <div class="col-md-6">
                <p class="text-muted small mb-0">
                    &copy; <jsp:useBean id="now" class="java.util.Date" />
                    <fmt:formatDate value="${now}" pattern="yyyy" />
                    <span class="text-white fw-semibold">RepairShop</span>. Bảo lưu mọi quyền.
                </p>
            </div>
            <div class="col-md-6 text-md-end mt-2 mt-md-0">
                <a href="${pageContext.request.contextPath}/#chinh-sach-bao-hanh" class="text-muted small text-decoration-none me-3">Chính sách bảo mật</a>
                <a href="${pageContext.request.contextPath}/#cau-hoi-thuong-gap" class="text-muted small text-decoration-none">Điều khoản</a>
            </div>
        </div>
    </div>
</footer>

</div><%-- end .main-wrapper --%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
