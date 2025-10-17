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

        /* Main Content */
        .main-content {
            margin-left: 260px;
            padding: 40px;
            min-height: 100vh;
        }

        .page-header {
            margin-bottom: 40px;
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
        }

        .hero-title {
            font-size: 42px;
            font-weight: 700;
            margin-bottom: 16px;
            position: relative;
            z-index: 2;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
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
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
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
        }

        .stat-icon.red { background-color: #fee2e2; color: #dc2626; }
        .stat-icon.gray { background-color: #f3f4f6; color: #4b5563; }
        .stat-icon.green { background-color: #d1fae5; color: #059669; }
        .stat-icon.orange { background-color: #fed7aa; color: #ea580c; }

        .stat-value {
            font-size: 36px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 4px;
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
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
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
            transition: all 0.2s ease;
            margin-bottom: 12px;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #dc2626;
            color: white;
        }

        .btn-primary:hover {
            background-color: #b91c1c;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
        }

        .btn-secondary {
            background-color: #f3f4f6;
            color: #1a1a1a;
        }

        .btn-secondary:hover {
            background-color: #e5e7eb;
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

            .hero-section {
                padding: 40px 24px;
            }

            .hero-title {
                font-size: 32px;
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