<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank - Tableau de Bord</title>
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

        /* Solid Red Sidebar */
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

        /* Main Content */
        .main-content {
            margin-left: 260px;
            padding: 40px;
            min-height: 100vh;
            position: relative;
            z-index: 2;
        }

        .page-header {
            margin-bottom: 40px;
            animation: fadeInUp 0.8s ease-out;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 8px;
        }

        .page-subtitle {
            color: #666;
            font-size: 16px;
        }

        /* Hero Section - GRADIENT RÉDUIT */
        .hero-section {
            background:
                    linear-gradient(135deg, rgba(220, 38, 38, 0.3), rgba(185, 28, 28, 0.3)),
                    url('https://images.unsplash.com/photo-1638272467190-4ff6f773315c?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=2030') center/cover;
            border-radius: 16px;
            padding: 60px;
            color: white;
            margin-bottom: 40px;
            box-shadow: 0 4px 20px rgba(220, 38, 38, 0.2);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }

        .hero-title {
            font-size: 42px;
            font-weight: 700;
            margin-bottom: 16px;
            position: relative;
            z-index: 2;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            /* RETIRÉ l'animation float pour garder le titre fixe */
        }

        .hero-text {
            font-size: 18px;
            opacity: 0.95;
            max-width: 600px;
            position: relative;
            z-index: 2;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 28px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out backwards;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(180deg, #dc2626 0%, #b91c1c 100%);
        }

        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }

        .stat-icon {
            width: 56px;
            height: 56px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 16px;
            transition: all 0.3s ease;
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1);
        }

        .stat-icon.red { background-color: #fee2e2; color: #dc2626; }
        .stat-icon.gray { background-color: #f3f4f6; color: #4b5563; }
        .stat-icon.green {
            background-color: #d1fae5;
            color: #059669;
            animation: heartbeat 2s ease-in-out infinite;
        }
        .stat-icon.orange { background-color: #fed7aa; color: #ea580c; }

        .stat-value {
            font-size: 36px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 4px;
            transition: all 0.3s ease;
        }

        .stat-card:hover .stat-value {
            color: #dc2626;
            transform: scale(1.05);
        }

        .stat-label {
            color: #666;
            font-size: 14px;
            font-weight: 500;
        }

        /* Action Cards */
        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
        }

        .action-card {
            background: white;
            border-radius: 12px;
            padding: 32px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            animation: fadeInUp 0.8s ease-out 0.5s both;
            position: relative;
            overflow: hidden;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(180deg, #dc2626 0%, #b91c1c 100%);
        }

        .action-card h3 {
            font-size: 20px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 24px;
        }

        .btn-action {
            display: block;
            width: 100%;
            padding: 14px 20px;
            border-radius: 8px;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
            transition: all 0.3s ease;
            margin-bottom: 12px;
            border: none;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .btn-action::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn-action:hover::before {
            left: 100%;
        }

        .btn-primary {
            background-color: #dc2626;
            color: white;
        }

        .btn-primary:hover {
            background-color: #b91c1c;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(220, 38, 38, 0.4);
        }

        .btn-secondary {
            background-color: #f3f4f6;
            color: #1a1a1a;
        }

        .btn-secondary:hover {
            background-color: #e5e7eb;
            transform: translateY(-3px);
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

            .hero-section {
                padding: 40px 24px;
            }

            .hero-title {
                font-size: 32px;
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
        <a href="${pageContext.request.contextPath}/home" class="nav-link active">
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
        <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="nav-link">
            <i class="fas fa-handshake"></i>
            <span>Matching</span>
        </a>
    </nav>
</div>

<div class="main-content">

    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i>
            <c:out value="${success}" />
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>
            <c:out value="${error}" />
        </div>
    </c:if>

    <div class="hero-section">
        <h1 class="hero-title">Sauver des vies ensemble</h1>
        <p class="hero-text">
            Gérez efficacement les donneurs et receveurs de sang.
            Chaque don compte, chaque vie est précieuse.
        </p>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon red">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-value">${donorsCount}</div>
            <div class="stat-label">Donneurs Total</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon green">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-value">${availableDonorsCount}</div>
            <div class="stat-label">Donneurs Disponibles</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon orange">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-value">${waitingReceiversCount}</div>
            <div class="stat-label">Receveurs en Attente</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon gray">
                <i class="fas fa-heart"></i>
            </div>
            <div class="stat-value">${satisfiedReceiversCount}</div>
            <div class="stat-label">Receveurs Satisfaits</div>
        </div>
    </div>

    <div class="action-grid">
        <div class="action-card">
            <h3>Actions Rapides</h3>
            <a href="${pageContext.request.contextPath}/donors?action=new" class="btn-action btn-primary">
                <i class="fas fa-plus me-2"></i> Nouveau Donneur
            </a>
            <a href="${pageContext.request.contextPath}/receivers?action=new" class="btn-action btn-primary">
                <i class="fas fa-plus me-2"></i> Nouveau Receveur
            </a>
            <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn-action btn-secondary">
                <i class="fas fa-handshake me-2"></i> Matching
            </a>
        </div>

        <div class="action-card">
            <h3>Statistiques du Jour</h3>
            <div style="padding: 16px 0;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 16px;">
                    <span style="color: #666;">Dons réalisés</span>
                    <strong style="color: #dc2626;">${todayDonations}</strong>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 16px;">
                    <span style="color: #666;">Taux de compatibilité</span>
                    <strong style="color: #dc2626;">${compatibilityRate}%</strong>
                </div>
                <div style="display: flex; justify-content: space-between;">
                    <span style="color: #666;">Disponibilité</span>
                    <strong style="color: #dc2626;">${availableDonorsCount}/${donorsCount}</strong>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>