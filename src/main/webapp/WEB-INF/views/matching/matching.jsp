<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank - Matching Donneurs/Receveurs</title>
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

        /* Unified solid red sidebar */
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
            margin-bottom: 32px;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 8px;
        }

        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border: none;
            margin-bottom: 24px;
        }

        .card-header {
            background-color: #dc2626;
            color: white;
            border-radius: 12px 12px 0 0;
            padding: 20px;
            font-weight: 600;
        }

        .card-body {
            padding: 24px;
        }

        .compatibility-card {
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 12px;
            transition: all 0.2s ease;
        }

        .compatibility-card:hover {
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

        .badge-green {
            background-color: #d1fae5;
            color: #059669;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
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

        .btn-sm {
            padding: 8px 16px;
            font-size: 13px;
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

        .progress {
            height: 8px;
            border-radius: 4px;
            background-color: #e5e7eb;
        }

        .progress-bar {
            background-color: #dc2626;
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
            <i class="fas fa-handshake me-2"></i>
            Matching Donneurs/Receveurs
        </h1>
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

    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-user-plus me-2"></i>
                    Donneurs Disponibles (${availableDonors.size()})
                </div>
                <div class="card-body">
                    <c:forEach var="donor" items="${availableDonors}">
                        <div class="compatibility-card">
                            <h6>${donor.fullName}</h6>
                            <p class="mb-2">
                                <span class="badge badge-red">${donor.bloodGroup.displayName}</span>
                                <span class="badge" style="background-color: #f3f4f6; color: #4b5563;">${donor.age} ans</span>
                            </p>
                            <a href="${pageContext.request.contextPath}/matching?action=findCompatibleReceivers&donorId=${donor.id}"
                               class="btn btn-primary btn-sm">
                                <i class="fas fa-search"></i> Voir receveurs
                            </a>
                        </div>
                    </c:forEach>
                    <c:if test="${empty availableDonors}">
                        <p class="text-muted text-center py-4">Aucun donneur disponible</p>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-user-injured me-2"></i>
                    Receveurs en Attente (${waitingReceivers.size()})
                </div>
                <div class="card-body">
                    <c:forEach var="receiver" items="${waitingReceivers}">
                        <div class="compatibility-card">
                            <h6>${receiver.fullName}</h6>
                            <p class="mb-2">
                                <span class="badge" style="background-color: #3b82f6; color: white;">${receiver.bloodGroup.displayName}</span>
                                <span class="badge
                                        <c:choose>
                                            <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">badge-red</c:when>
                                            <c:when test="${receiver.medicalUrgency == 'URGENT'}">badge-red</c:when>
                                            <c:otherwise>badge-green</c:otherwise>
                                        </c:choose>">
                                        ${receiver.medicalUrgency}
                                </span>
                            </p>
                            <div class="progress mb-2">
                                <div class="progress-bar" style="width: ${(receiver.currentDonationCount / receiver.requiredDonationCount) * 100}%"></div>
                            </div>
                            <small class="text-muted">${receiver.currentDonationCount}/${receiver.requiredDonationCount} poches</small>
                            <br>
                            <a href="${pageContext.request.contextPath}/matching?action=findCompatibleDonors&receiverId=${receiver.id}"
                               class="btn btn-primary btn-sm mt-2">
                                <i class="fas fa-search"></i> Voir donneurs
                            </a>
                        </div>
                    </c:forEach>
                    <c:if test="${empty waitingReceivers}">
                        <p class="text-muted text-center py-4">Aucun receveur en attente</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <div class="card mt-4">
        <div class="card-header">
            <i class="fas fa-list me-2"></i>
            Donations Actives (${activeDonations.size()})
        </div>
        <div class="card-body">
            <c:if test="${empty activeDonations}">
                <p class="text-muted text-center py-4">Aucune donation active</p>
            </c:if>
            <c:forEach var="donation" items="${activeDonations}">
                <div class="compatibility-card">
                    <div class="row">
                        <div class="col-md-8">
                            <strong>${donation.donor.fullName}</strong> → <strong>${donation.receiver.fullName}</strong>
                            <br>
                            <small class="text-muted">${donation.donationDate}</small>
                        </div>
                        <div class="col-md-4 text-end">
                            <form method="post" action="${pageContext.request.contextPath}/matching" style="display: inline;">
                                <input type="hidden" name="action" value="cancelDonation">
                                <input type="hidden" name="donationId" value="${donation.id}">
                                <button type="submit" class="btn btn-sm" style="background-color: #fee2e2; color: #dc2626; border: none;"
                                        onclick="return confirm('Annuler cette donation?')">
                                    <i class="fas fa-times"></i> Annuler
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
