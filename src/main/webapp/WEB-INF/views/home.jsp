<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank Management - Tableau de Bord</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-red: #dc3545;
            --dark-red: #c82333;
            --light-red: #f8d7da;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }

        .sidebar {
            min-height: 100vh;
            background: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.05);
            border-right: 3px solid var(--primary-red);
        }

        .sidebar-header {
            padding: 30px 20px;
            background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
            border-bottom: 3px solid var(--dark-red);
        }

        .sidebar-logo {
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
            text-align: center;
            margin: 0;
        }

        .sidebar-logo i {
            font-size: 2rem;
            display: block;
            margin-bottom: 10px;
        }

        .sidebar .nav-link {
            color: #495057;
            padding: 15px 25px;
            margin: 8px 15px;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
            border-left: 3px solid transparent;
        }

        .sidebar .nav-link:hover {
            background-color: var(--light-red);
            color: var(--primary-red);
            border-left-color: var(--primary-red);
            transform: translateX(5px);
        }

        .sidebar .nav-link.active {
            background-color: var(--primary-red);
            color: white;
            border-left-color: var(--dark-red);
            box-shadow: 0 4px 10px rgba(220, 53, 69, 0.3);
        }

        .sidebar .nav-link i {
            width: 25px;
            text-align: center;
        }

        .main-content {
            background-color: white;
            min-height: 100vh;
            padding: 30px;
        }

        .page-header {
            border-bottom: 3px solid var(--primary-red);
            padding-bottom: 20px;
            margin-bottom: 30px;
        }

        .page-header h1 {
            color: var(--primary-red);
            font-weight: 700;
            font-size: 2rem;
        }

        .stat-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            overflow: hidden;
            border-left: 5px solid;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .stat-card.primary {
            border-left-color: #0d6efd;
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
        }

        .stat-card.success {
            border-left-color: #198754;
            background: linear-gradient(135deg, #198754 0%, #146c43 100%);
        }

        .stat-card.warning {
            border-left-color: #ffc107;
            background: linear-gradient(135deg, #ffc107 0%, #ffb300 100%);
        }

        .stat-card.info {
            border-left-color: #0dcaf0;
            background: linear-gradient(135deg, #0dcaf0 0%, #31d2f2 100%);
        }

        .stat-card .card-body {
            padding: 25px;
        }

        .stat-card h4 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-card p {
            font-size: 0.95rem;
            margin-bottom: 0;
            opacity: 0.95;
        }

        .stat-card i {
            font-size: 3rem;
            opacity: 0.3;
        }

        .action-card, .stats-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .action-card .card-header, .stats-card .card-header {
            background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
            color: white;
            padding: 20px;
            border: none;
        }

        .action-card .card-header h5, .stats-card .card-header h5 {
            margin: 0;
            font-weight: 600;
        }

        .action-card .card-body, .stats-card .card-body {
            padding: 25px;
        }

        .btn-action {
            padding: 15px;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
            border: none;
        }

        .alert {
            border-radius: 10px;
            border: none;
            border-left: 4px solid;
        }

        .alert-success {
            background-color: #d1e7dd;
            border-left-color: #198754;
            color: #0f5132;
        }

        .alert-danger {
            background-color: var(--light-red);
            border-left-color: var(--primary-red);
            color: #842029;
        }

        .stats-info {
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 10px;
            border-left: 4px solid var(--primary-red);
        }

        .stats-info p {
            margin-bottom: 10px;
            color: #495057;
        }

        .stats-info strong {
            color: var(--primary-red);
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block sidebar p-0">
            <div class="sidebar-header">
                <h4 class="sidebar-logo">
                    <i class="fas fa-tint"></i>
                    Blood Bank
                </h4>
            </div>
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-2"></i> Accueil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/donors">
                            <i class="fas fa-user-plus me-2"></i> Donneurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/receivers">
                            <i class="fas fa-user-injured me-2"></i> Receveurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/matching?action=showMatching">
                            <i class="fas fa-handshake me-2"></i> Matching
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
            <div class="page-header">
                <h1><i class="fas fa-chart-line me-2"></i>Tableau de Bord</h1>
            </div>

            <!-- Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <c:out value="${success}" />
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <c:out value="${error}" />
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-3 mb-3">
                    <div class="stat-card primary text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4>${donorsCount}</h4>
                                    <p>Donneurs Total</p>
                                </div>
                                <i class="fas fa-user-plus"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stat-card success text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4>${availableDonorsCount}</h4>
                                    <p>Donneurs Disponibles</p>
                                </div>
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stat-card warning text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4>${waitingReceiversCount}</h4>
                                    <p>Receveurs en Attente</p>
                                </div>
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stat-card info text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4>${satisfiedReceiversCount}</h4>
                                    <p>Receveurs Satisfaits</p>
                                </div>
                                <i class="fas fa-heart"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="action-card">
                        <div class="card-header">
                            <h5><i class="fas fa-bolt me-2"></i>Actions Rapides</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-3">
                                <a href="${pageContext.request.contextPath}/donors?action=new"
                                   class="btn btn-danger btn-action">
                                    <i class="fas fa-plus me-2"></i> Nouveau Donneur
                                </a>
                                <a href="${pageContext.request.contextPath}/receivers?action=new"
                                   class="btn btn-primary btn-action">
                                    <i class="fas fa-plus me-2"></i> Nouveau Receveur
                                </a>
                                <a href="${pageContext.request.contextPath}/matching?action=showMatching"
                                   class="btn btn-success btn-action">
                                    <i class="fas fa-handshake me-2"></i> Matching Donneurs/Receveurs
                                </a>
                                <a href="${pageContext.request.contextPath}/donors"
                                   class="btn btn-outline-danger btn-action">
                                    <i class="fas fa-list me-2"></i> Voir tous les Donneurs
                                </a>
                                <a href="${pageContext.request.contextPath}/receivers"
                                   class="btn btn-outline-primary btn-action">
                                    <i class="fas fa-list me-2"></i> Voir tous les Receveurs
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="stats-card">
                        <div class="card-header">
                            <h5><i class="fas fa-chart-bar me-2"></i>Statistiques</h5>
                        </div>
                        <div class="card-body">
                            <div class="stats-info">
                                <p><i class="fas fa-calendar-day me-2"></i>Dons réalisés aujourd'hui: <strong>${todayDonations}</strong></p>
                                <p><i class="fas fa-heart me-2"></i>Receveurs satisfaits: <strong>${satisfiedReceiversCount}</strong></p>
                                <p><i class="fas fa-percentage me-2"></i>Taux de compatibilité: <strong>${compatibilityRate}%</strong></p>
                                <p class="mb-0"><i class="fas fa-users me-2"></i>Donneurs disponibles: <strong>${availableDonorsCount}/${donorsCount}</strong></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
