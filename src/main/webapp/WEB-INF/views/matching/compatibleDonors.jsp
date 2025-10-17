<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank - Donneurs Compatibles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            color: #1a1a1a;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 260px;
            background-color: #dc2626;
            padding: 0;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 32px 24px;
            background-color: #b91c1c;
            text-align: center;
        }

        .logo {
            color: #ffffff;
            font-size: 24px;
            font-weight: 700;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .logo i {
            font-size: 32px;
        }

        .nav-menu {
            padding: 24px 0;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 24px;
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            transition: all 0.2s ease;
            font-weight: 500;
            border-left: 4px solid transparent;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-left-color: #ffffff;
        }

        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.15);
            color: #ffffff;
            border-left-color: #ffffff;
        }

        .nav-link i {
            width: 20px;
            text-align: center;
        }

        .main-content {
            margin-left: 260px;
            padding: 40px;
            min-height: 100vh;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background-color: #dc2626;
            color: white;
        }

        .btn-primary:hover {
            background-color: #b91c1c;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background-color: #f3f4f6;
            color: #1a1a1a;
        }

        .btn-secondary:hover {
            background-color: #e5e7eb;
        }

        .receiver-info {
            background: linear-gradient(135deg, #f59e0b, #f97316);
            color: white;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 32px;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.2);
        }

        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border: none;
            margin-bottom: 24px;
        }

        .card-header {
            background-color: #22c55e;
            color: white;
            border-radius: 12px 12px 0 0;
            padding: 20px;
            font-weight: 600;
        }

        .card-body {
            padding: 24px;
        }

        .donor-card {
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 16px;
            transition: all 0.2s ease;
        }

        .donor-card:hover {
            border-color: #dc2626;
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.1);
            transform: translateY(-2px);
        }

        .badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
        }

        .badge-red {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .alert {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            border-left: 4px solid;
        }

        .alert-success {
            background-color: #d1fae5;
            border-color: #059669;
            color: #065f46;
        }

        .alert-danger {
            background-color: #fee2e2;
            border-color: #dc2626;
            color: #991b1b;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 64px;
            color: #e5e7eb;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="sidebar-header">
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <i class="fas fa-tint"></i>
            <span>Blood Bank</span>
        </a>
    </div>
    <nav class="nav-menu">
        <a href="${pageContext.request.contextPath}/home" class="nav-link">
            <i class="fas fa-home"></i>
            <span>Accueil</span>
        </a>
        <a href="${pageContext.request.contextPath}/donors" class="nav-link">
            <i class="fas fa-user-plus"></i>
            <span>Donneurs</span>
        </a>
        <a href="${pageContext.request.contextPath}/receivers" class="nav-link">
            <i class="fas fa-user-injured"></i>
            <span>Receveurs</span>
        </a>
        <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="nav-link active">
            <i class="fas fa-handshake"></i>
            <span>Matching</span>
        </a>
    </nav>
</div>

<div class="main-content">
    <div class="page-header">
        <h1 class="page-title">
            <i class="fas fa-user-check me-2"></i>
            Donneurs Compatibles
        </h1>
        <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i>
            Retour
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i>
                ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>
                ${error}
        </div>
    </c:if>

    <div class="receiver-info">
        <h4>${receiver.fullName}</h4>
        <p class="mb-1">Groupe: <strong>${receiver.bloodGroup.displayName}</strong> | Urgence: <strong>${receiver.medicalUrgency}</strong></p>
        <p class="mb-0">Progression: ${receiver.currentDonationCount}/${receiver.requiredDonationCount} poches</p>
    </div>

    <div class="card">
        <div class="card-header">
            <i class="fas fa-user-check me-2"></i>
            Donneurs Compatibles (${compatibleDonors.size()})
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty compatibleDonors}">
                    <div class="empty-state">
                        <i class="fas fa-users-slash"></i>
                        <h3>Aucun donneur compatible</h3>
                        <p>Aucun donneur disponible pour ce groupe sanguin</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="donor" items="${compatibleDonors}">
                        <div class="donor-card">
                            <div class="row">
                                <div class="col-md-8">
                                    <h6>${donor.fullName}</h6>
                                    <p class="mb-2">
                                        <span class="badge badge-red">${donor.bloodGroup.displayName}</span>
                                        <span class="badge" style="background-color: #f3f4f6; color: #4b5563;">${donor.age} ans</span>
                                    </p>
                                    <small class="text-muted">CIN: ${donor.cin} | Poids: ${donor.weight} kg</small>
                                </div>
                                <div class="col-md-4 text-end">
                                    <form method="post" action="${pageContext.request.contextPath}/matching">
                                        <input type="hidden" name="action" value="createDonation">
                                        <input type="hidden" name="donorId" value="${donor.id}">
                                        <input type="hidden" name="receiverId" value="${receiver.id}">
                                        <button type="submit" class="btn btn-primary btn-sm"
                                                onclick="return confirm('Associer ce donneur?')">
                                            <i class="fas fa-handshake"></i> Associer
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
