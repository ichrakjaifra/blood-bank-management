<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank - Liste des Receveurs</title>
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

        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-10px) rotate(5deg);
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

        /* Cellules sanguines animées - PLUS VISIBLES */
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

        /* PLUS DE KORAYAT - Tailles et positions variées */
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
        .blood-cell:nth-child(11) {
            width: 11px;
            height: 11px;
            left: 72%;
            animation-duration: 22s;
            animation-delay: 1s;
        }
        .blood-cell:nth-child(12) {
            width: 13px;
            height: 13px;
            left: 78%;
            animation-duration: 18s;
            animation-delay: 9s;
        }
        .blood-cell:nth-child(13) {
            width: 15px;
            height: 15px;
            left: 85%;
            animation-duration: 24s;
            animation-delay: 3s;
        }
        .blood-cell:nth-child(14) {
            width: 10px;
            height: 10px;
            left: 92%;
            animation-duration: 21s;
            animation-delay: 6s;
        }
        .blood-cell:nth-child(15) {
            width: 12px;
            height: 12px;
            left: 8%;
            animation-duration: 19s;
            animation-delay: 10s;
        }
        .blood-cell:nth-child(16) {
            width: 14px;
            height: 14px;
            left: 22%;
            animation-duration: 23s;
            animation-delay: 4s;
        }
        .blood-cell:nth-child(17) {
            width: 11px;
            height: 11px;
            left: 35%;
            animation-duration: 20s;
            animation-delay: 11s;
        }
        .blood-cell:nth-child(18) {
            width: 13px;
            height: 13px;
            left: 48%;
            animation-duration: 22s;
            animation-delay: 5s;
        }
        .blood-cell:nth-child(19) {
            width: 15px;
            height: 15px;
            left: 62%;
            animation-duration: 18s;
            animation-delay: 12s;
        }
        .blood-cell:nth-child(20) {
            width: 10px;
            height: 10px;
            left: 75%;
            animation-duration: 24s;
            animation-delay: 7s;
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
            animation: float 3s ease-in-out infinite;
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
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(220, 38, 38, 0.4);
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 14px;
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

        .btn-danger {
            background-color: #dc2626;
            color: white;
        }

        .btn-danger:hover {
            background-color: #b91c1c;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
        }

        .table-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out 0.2s both;
            position: relative;
        }

        .table-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(180deg, #dc2626 0%, #b91c1c 100%);
        }

        .table {
            width: 100%;
            margin: 0;
            border-collapse: collapse;
        }

        .table thead {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            color: white;
        }

        .table th {
            padding: 18px 20px;
            font-weight: 600;
            text-align: left;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
        }

        .table td {
            padding: 16px 20px;
            border-bottom: 1px solid #f3f4f6;
            transition: all 0.3s ease;
        }

        .table tbody tr {
            animation: fadeInUp 0.6s ease-out backwards;
            transition: all 0.3s ease;
        }

        .table tbody tr:nth-child(1) { animation-delay: 0.1s; }
        .table tbody tr:nth-child(2) { animation-delay: 0.2s; }
        .table tbody tr:nth-child(3) { animation-delay: 0.3s; }
        .table tbody tr:nth-child(4) { animation-delay: 0.4s; }
        .table tbody tr:nth-child(5) { animation-delay: 0.5s; }
        .table tbody tr:nth-child(6) { animation-delay: 0.6s; }
        .table tbody tr:nth-child(7) { animation-delay: 0.7s; }
        .table tbody tr:nth-child(8) { animation-delay: 0.8s; }
        .table tbody tr:nth-child(9) { animation-delay: 0.9s; }
        .table tbody tr:nth-child(10) { animation-delay: 1.0s; }

        .table tbody tr:hover {
            background-color: #fef2f2;
            transform: translateX(8px);
            box-shadow: -8px 0 20px rgba(220, 38, 38, 0.15);
        }

        .table tbody tr:hover td {
            border-color: #fecaca;
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

        .badge-green {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #059669;
            border: 1px solid #a7f3d0;
            animation: heartbeat 2s ease-in-out infinite;
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

        .badge:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
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
            animation: float 3s ease-in-out infinite;
            transition: all 0.3s ease;
        }

        .empty-state:hover i {
            color: #dc2626;
            transform: scale(1.1);
        }

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

            .table-card {
                overflow-x: auto;
            }

            .blood-cells {
                display: none;
            }
        }
    </style>
</head>
<body>
<!-- Cellules sanguines animées en arrière-plan - PLUS NOMBREUSES ET VISIBLES -->
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
        <a href="${pageContext.request.contextPath}/receivers" class="nav-link active">
            <i class="fas fa-user-injured"></i>
            <span>Receveurs</span>
        </a>
        <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="nav-link">
            <i class="fas fa-handshake"></i>
            <span>Matching</span>
        </a>
    </nav>
</div>

<div class="main-content">
    <div class="page-header">
        <h1 class="page-title">
            <i class="fas fa-user-injured me-2"></i>
            Liste des Receveurs
        </h1>
        <a href="${pageContext.request.contextPath}/receivers?action=new" class="btn btn-primary">
            <i class="fas fa-plus"></i>
            Nouveau Receveur
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

    <div class="table-card">
        <c:choose>
            <c:when test="${empty receivers}">
                <div class="empty-state">
                    <i class="fas fa-users"></i>
                    <h3>Aucun receveur trouvé</h3>
                    <p>Commencez par ajouter votre premier receveur</p>
                    <a href="${pageContext.request.contextPath}/receivers?action=new" class="btn btn-primary" style="margin-top: 20px;">
                        <i class="fas fa-plus"></i>
                        Nouveau Receveur
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="table">
                    <thead>
                    <tr>
                        <th>Nom Complet</th>
                        <th>CIN</th>
                        <th>Âge</th>
                        <th>Groupe Sanguin</th>
                        <th>Urgence</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="receiver" items="${receivers}">
                        <tr>
                            <td><strong>${receiver.fullName}</strong></td>
                            <td>${receiver.cin}</td>
                            <td>${receiver.age} ans</td>
                            <td>
                                <span class="badge badge-red">${receiver.bloodGroup.displayName}</span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">
                                        <span class="badge badge-red">CRITIQUE</span>
                                    </c:when>
                                    <c:when test="${receiver.medicalUrgency == 'URGENT'}">
                                        <span class="badge badge-orange">URGENT</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-gray">NORMAL</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                        <span class="badge ${receiver.status == 'SATISFAIT' ? 'badge-green' : 'badge-gray'}">
                                                ${receiver.status}
                                        </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/receivers?action=edit&id=${receiver.id}"
                                   class="btn btn-sm btn-secondary">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <form method="post" action="${pageContext.request.contextPath}/receivers"
                                      style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${receiver.id}">
                                    <button type="submit" class="btn btn-sm btn-danger"
                                            onclick="return confirm('Supprimer ce receveur?')">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>