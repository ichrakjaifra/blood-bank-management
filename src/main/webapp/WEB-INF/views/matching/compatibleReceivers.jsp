<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank - Receveurs Compatibles</title>
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
            overflow-x: hidden;
        }

        /* Animations élégantes */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes pulseGlow {
            0%, 100% {
                box-shadow: 0 0 10px rgba(220, 38, 38, 0.3);
            }
            50% {
                box-shadow: 0 0 20px rgba(220, 38, 38, 0.6);
            }
        }

        @keyframes heartbeat {
            0%, 100% {
                transform: scale(1);
            }
            25% {
                transform: scale(1.05);
            }
            50% {
                transform: scale(1);
            }
            75% {
                transform: scale(1.03);
            }
        }

        @keyframes bloodCellFloat {
            0% {
                transform: translateY(100vh) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 0.6;
            }
            90% {
                opacity: 0.6;
            }
            100% {
                transform: translateY(-100px) rotate(360deg);
                opacity: 0;
            }
        }

        /* Cellules sanguines animées */
        .blood-cells {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
            overflow: hidden;
        }

        .blood-cell {
            position: absolute;
            background: radial-gradient(circle, #dc2626 0%, #b91c1c 100%);
            border-radius: 50%;
            animation: bloodCellFloat linear infinite;
            opacity: 0;
            box-shadow: 0 0 10px rgba(220, 38, 38, 0.4);
        }

        /* Korayat hamra2 positions */
        .blood-cell:nth-child(1) {
            width: 12px;
            height: 12px;
            left: 5%;
            animation-duration: 18s;
            animation-delay: 0s;
        }
        .blood-cell:nth-child(2) {
            width: 16px;
            height: 16px;
            left: 12%;
            animation-duration: 22s;
            animation-delay: 2s;
        }
        .blood-cell:nth-child(3) {
            width: 10px;
            height: 10px;
            left: 18%;
            animation-duration: 20s;
            animation-delay: 4s;
        }
        .blood-cell:nth-child(4) {
            width: 14px;
            height: 14px;
            left: 25%;
            animation-duration: 24s;
            animation-delay: 1s;
        }
        .blood-cell:nth-child(5) {
            width: 11px;
            height: 11px;
            left: 32%;
            animation-duration: 19s;
            animation-delay: 6s;
        }
        .blood-cell:nth-child(6) {
            width: 13px;
            height: 13px;
            left: 38%;
            animation-duration: 21s;
            animation-delay: 3s;
        }
        .blood-cell:nth-child(7) {
            width: 15px;
            height: 15px;
            left: 45%;
            animation-duration: 23s;
            animation-delay: 5s;
        }
        .blood-cell:nth-child(8) {
            width: 9px;
            height: 9px;
            left: 52%;
            animation-duration: 17s;
            animation-delay: 7s;
        }
        .blood-cell:nth-child(9) {
            width: 12px;
            height: 12px;
            left: 58%;
            animation-duration: 25s;
            animation-delay: 2s;
        }
        .blood-cell:nth-child(10) {
            width: 14px;
            height: 14px;
            left: 65%;
            animation-duration: 20s;
            animation-delay: 8s;
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
            animation: slideInLeft 0.6s ease-out;
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
            animation: heartbeat 2s ease-in-out infinite;
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
            transition: all 0.3s ease;
            font-weight: 500;
            border-left: 4px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
            transition: left 0.5s ease;
        }

        .nav-link:hover::before {
            left: 100%;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-left-color: #ffffff;
            transform: translateX(5px);
        }

        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.15);
            color: #ffffff;
            border-left-color: #ffffff;
            animation: pulseGlow 2s ease-in-out infinite;
        }

        .nav-link i {
            width: 20px;
            text-align: center;
        }

        .main-content {
            margin-left: 260px;
            padding: 40px;
            min-height: 100vh;
            position: relative;
            z-index: 2;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            animation: fadeInUp 0.8s ease-out;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .page-title i {
            color: #dc2626;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background-color: #dc2626;
            color: white;
        }

        .btn-primary:hover {
            background-color: #b91c1c;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(220, 38, 38, 0.4);
        }

        .btn-secondary {
            background-color: #f3f4f6;
            color: #1a1a1a;
        }

        .btn-secondary:hover {
            background-color: #e5e7eb;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 14px;
        }

        /* Info donneur - Blanc avec bordure rouge */
        .donor-info {
            background: white;
            color: #1a1a1a;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 32px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            animation: fadeInUp 0.6s ease-out 0.2s both;
            position: relative;
            overflow: hidden;
            border-left: 4px solid #dc2626;
        }

        .donor-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(220, 38, 38, 0.03), transparent);
            animation: shimmer 3s ease-in-out infinite;
        }

        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: none;
            margin-bottom: 24px;
            animation: fadeInUp 0.6s ease-out 0.4s both;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(180deg, #dc2626 0%, #b91c1c 100%);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
        }

        /* Header de carte - Rouge comme les autres pages */
        .card-header {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            color: white;
            border-radius: 12px 12px 0 0;
            padding: 20px;
            font-weight: 600;
            border: none;
        }

        .card-body {
            padding: 24px;
        }

        .receiver-card {
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 16px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.5s ease-out backwards;
            background: white;
        }

        .receiver-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(220, 38, 38, 0.05), transparent);
            transition: left 0.5s ease;
        }

        .receiver-card:hover::before {
            left: 100%;
        }

        .receiver-card:hover {
            border-color: #dc2626;
            box-shadow: 0 6px 20px rgba(220, 38, 38, 0.15);
            transform: translateY(-3px);
        }

        .badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .badge::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s ease;
        }

        .badge:hover::before {
            left: 100%;
        }

        .badge-red {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        .badge-gray {
            background: linear-gradient(135deg, #f3f4f6 0%, #e5e7eb 100%);
            color: #4b5563;
            border: 1px solid #e5e7eb;
        }

        .badge-orange {
            background: linear-gradient(135deg, #fed7aa 0%, #fdba74 100%);
            color: #ea580c;
            border: 1px solid #fdba74;
        }

        .badge-blue {
            background: linear-gradient(135deg, #dbeafe 0%, #93c5fd 100%);
            color: #1e40af;
            border: 1px solid #93c5fd;
        }

        .badge:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .progress {
            height: 8px;
            border-radius: 4px;
            background-color: #e5e7eb;
            overflow: hidden;
        }

        .progress-bar {
            background: linear-gradient(90deg, #dc2626 0%, #b91c1c 100%);
            transition: width 0.6s ease;
        }

        .alert {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            border-left: 4px solid;
            animation: fadeInUp 0.6s ease-out;
            position: relative;
            overflow: hidden;
        }

        .alert::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            animation: shimmer 2s ease-in-out infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
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
            padding: 80px 20px;
            color: #666;
            animation: fadeInUp 0.8s ease-out;
        }

        .empty-state i {
            font-size: 80px;
            color: #e5e7eb;
            margin-bottom: 24px;
            transition: all 0.3s ease;
        }

        .empty-state:hover i {
            color: #dc2626;
            transform: scale(1.1);
        }

        /* Animations en cascade pour les cartes de receveurs */
        .receiver-card:nth-child(1) { animation-delay: 0.15s; }
        .receiver-card:nth-child(2) { animation-delay: 0.25s; }
        .receiver-card:nth-child(3) { animation-delay: 0.35s; }
        .receiver-card:nth-child(4) { animation-delay: 0.45s; }
        .receiver-card:nth-child(5) { animation-delay: 0.55s; }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                animation: none;
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

            .blood-cells {
                display: none;
            }
        }
    </style>
</head>
<body>
<!-- Cellules sanguines animées en arrière-plan -->
<div class="blood-cells">
    <div class="blood-cell"></div>
    <div class="blood-cell"></div>
    <div class="blood-cell"></div>
    <div class="blood-cell"></div>
    <div class="blood-cell"></div>
    <div class="blood-cell"></div>
    <div class="blood-cell"></div>
    <div class="blood-cell"></div>
    <div class="blood-cell"></div>
    <div class="blood-cell"></div>
</div>

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
            <i class="fas fa-user-injured me-2"></i>
            Receveurs Compatibles
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

    <div class="donor-info">
        <h4>${donor.fullName}</h4>
        <p class="mb-1">Groupe: <strong>${donor.bloodGroup.displayName}</strong> | Poids: <strong>${donor.weight} kg</strong></p>
        <p class="mb-0">Statut: <strong>${donor.status}</strong></p>
    </div>

    <div class="card">
        <div class="card-header">
            <i class="fas fa-user-injured me-2"></i>
            Receveurs Compatibles (${compatibleReceivers.size()})
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty compatibleReceivers}">
                    <div class="empty-state">
                        <i class="fas fa-users-slash"></i>
                        <h3>Aucun receveur compatible</h3>
                        <p>Aucun receveur en attente pour ce groupe sanguin</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="receiver" items="${compatibleReceivers}">
                        <div class="receiver-card">
                            <div class="row">
                                <div class="col-md-8">
                                    <h6>${receiver.fullName}</h6>
                                    <p class="mb-2">
                                        <span class="badge badge-red">${receiver.bloodGroup.displayName}</span>
                                        <span class="badge
                                                <c:choose>
                                                    <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">badge-red</c:when>
                                                    <c:when test="${receiver.medicalUrgency == 'URGENT'}">badge-orange</c:when>
                                                    <c:otherwise>badge-gray</c:otherwise>
                                                </c:choose>">
                                                ${receiver.medicalUrgency}
                                        </span>
                                    </p>
                                    <div class="progress mb-2">
                                        <div class="progress-bar" style="width: ${(receiver.currentDonationCount / receiver.requiredDonationCount) * 100}%"></div>
                                    </div>
                                    <small class="text-muted">${receiver.currentDonationCount}/${receiver.requiredDonationCount} poches</small>
                                </div>
                                <div class="col-md-4 text-end">
                                    <form method="post" action="${pageContext.request.contextPath}/matching">
                                        <input type="hidden" name="action" value="createDonation">
                                        <input type="hidden" name="donorId" value="${donor.id}">
                                        <input type="hidden" name="receiverId" value="${receiver.id}">
                                        <button type="submit" class="btn btn-primary btn-sm"
                                                onclick="return confirm('Associer ce receveur?')">
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