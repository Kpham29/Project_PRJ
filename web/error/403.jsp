<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Khong co quyen</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
<div class="container text-center py-5">
    <h1 class="display-4 text-warning">403</h1>
    <p class="lead">Ban khong co quyen truy cap trang nay.</p>
    <p class="text-muted small">Vi du: trang quan tri (/admin/*) chi danh cho tai khoan Admin.</p>
    <a href="${pageContext.request.contextPath}/" class="btn btn-primary me-2">Ve trang chu</a>
    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-secondary">Dang nhap</a>
</div>
</body>
</html>
