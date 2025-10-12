<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank Management - Gestion des Donneurs</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            color: var(--primary-red);
            font-weight: 700;
            font-size: 2rem;
            margin: 0;
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
        }

        .table-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .table-card .card-body {
            padding: 0;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: linear-gradient(135deg, #343a40 0%, #495057 100%);
            color: white;
            font-weight: 600;
            border: none;
            padding: 18px 20px;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .table tbody td {
            padding: 18px 20px;
            vertical-align: middle;
            border-color: #f1f3f5;
        }

        .table tbody tr {
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(220, 53, 69, 0.05);
            transform: scale(1.01);
        }

        .blood-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-block;
        }

        .status-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.8rem;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-group-sm .btn {
            padding: 8px 12px;
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .btn-outline-primary:hover {
            transform: translateY(-2px);
        }

        .btn-outline-danger:hover {
            transform: translateY(-2px);
        }

        .stats-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 25px;
            border-radius: 10px;
            border-top: 3px solid var(--primary-red);
        }

        .stat-item {
            text-align: center;
        }

        .stat-item h5 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-item small {
            color: #6c757d;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-state i {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 20px;
        }

        .empty-state h4 {
            color: #6c757d;
            margin-bottom: 15px;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-2"></i> Accueil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/donors">
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
                <h1><i class="fas fa-users me-2"></i>Gestion des Donneurs</h1>
                <a href="${pageContext.request.contextPath}/donors?action=new" class="btn btn-danger">
                    <i class="fas fa-plus me-2"></i>Nouveau Donneur
                </a>
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

            <c:choose>
                <c:when test="${empty donors}">
                    <div class="table-card">
                        <div class="card-body">
                            <div class="empty-state">
                                <i class="fas fa-users"></i>
                                <h4>Aucun donneur trouvé</h4>
                                <p class="text-muted mb-4">Il n'y a pas de donneurs enregistrés pour le moment.</p>
                                <a href="${pageContext.request.contextPath}/donors?action=new" class="btn btn-danger">
                                    <i class="fas fa-plus me-2"></i>Ajouter le premier donneur
                                </a>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-card mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead>
                                    <tr>
                                        <th>CIN</th>
                                        <th>Nom Complet</th>
                                        <th>Téléphone</th>
                                        <th>Âge</th>
                                        <th>Groupe Sanguin</th>
                                        <th>Poids</th>
                                        <th>Statut</th>
                                        <th class="text-center">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="donor" items="${donors}">
                                        <tr>
                                            <td class="fw-semibold"><c:out value="${donor.cin}" /></td>
                                            <td class="fw-semibold"><c:out value="${donor.fullName}" /></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty donor.phone}">
                                                        <c:out value="${donor.phone}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Non renseigné</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="badge bg-light text-dark">${donor.age} ans</span>
                                            </td>
                                            <td>
                                                <span class="badge blood-badge bg-danger text-white">
                                                        ${donor.bloodGroup.displayName}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="fw-semibold">${donor.weight} kg</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${donor.status == 'DISPONIBLE'}">
                                                        <span class="status-badge bg-success text-white">
                                                            <i class="fas fa-check"></i>Disponible
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${donor.status == 'NON_DISPONIBLE'}">
                                                        <span class="status-badge bg-warning text-dark">
                                                            <i class="fas fa-clock"></i>Non Disponible
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge bg-danger text-white">
                                                            <i class="fas fa-times"></i>Non Éligible
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group btn-group-sm">
                                                    <a href="${pageContext.request.contextPath}/donors?action=edit&id=${donor.id}"
                                                       class="btn btn-outline-primary"
                                                       title="Modifier">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/donors?action=delete&id=${donor.id}"
                                                       class="btn btn-outline-danger"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce donneur?')"
                                                       title="Supprimer">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Statistics -->
                    <div class="stats-section">
                        <div class="row">
                            <div class="col-md-3 stat-item">
                                <h5 class="text-primary">${fn:length(donors)}</h5>
                                <small>Total Donneurs</small>
                            </div>
                            <div class="col-md-3 stat-item">
                                <h5 class="text-success">
                                    <c:set var="availableCount" value="0" />
                                    <c:forEach var="donor" items="${donors}">
                                        <c:if test="${donor.status == 'DISPONIBLE'}">
                                            <c:set var="availableCount" value="${availableCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                        ${availableCount}
                                </h5>
                                <small>Disponibles</small>
                            </div>
                            <div class="col-md-3 stat-item">
                                <h5 class="text-warning">
                                    <c:set var="unavailableCount" value="0" />
                                    <c:forEach var="donor" items="${donors}">
                                        <c:if test="${donor.status == 'NON_DISPONIBLE'}">
                                            <c:set var="unavailableCount" value="${unavailableCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                        ${unavailableCount}
                                </h5>
                                <small>Non Disponibles</small>
                            </div>
                            <div class="col-md-3 stat-item">
                                <h5 class="text-danger">
                                    <c:set var="ineligibleCount" value="0" />
                                    <c:forEach var="donor" items="${donors}">
                                        <c:if test="${donor.status == 'NON_ELIGIBLE'}">
                                            <c:set var="ineligibleCount" value="${ineligibleCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                        ${ineligibleCount}
                                </h5>
                                <small>Non Éligibles</small>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
