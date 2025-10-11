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
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #dc3545 0%, #c82333 100%);
        }
        .sidebar .nav-link {
            color: white;
            padding: 12px 20px;
            margin: 4px 0;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            transform: translateX(5px);
        }
        .main-content {
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        .blood-badge {
            font-size: 0.75em;
            padding: 0.4em 0.8em;
            border-radius: 20px;
            font-weight: 600;
        }
        .table th {
            background-color: #343a40;
            color: white;
            font-weight: 600;
            border: none;
            padding: 12px 15px;
        }
        .table td {
            padding: 12px 15px;
            vertical-align: middle;
            border-color: #dee2e6;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 0, 0, 0.02);
        }
        .table-hover tbody tr:hover {
            background-color: rgba(220, 53, 69, 0.08);
            transform: translateY(-1px);
            transition: all 0.2s ease;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse bg-danger">
            <div class="position-sticky pt-3">
                <h4 class="text-white text-center mb-4">
                    <i class="fas fa-tint me-2"></i>Blood Bank
                </h4>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-2"></i>Accueil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/donors">
                            <i class="fas fa-user-plus me-2"></i>Donneurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/receivers">
                            <i class="fas fa-user-injured me-2"></i>Receveurs
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2 text-dark">Gestion des Donneurs</h1>
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

            <!-- محتوى القائمة -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="text-dark mb-0">Liste des Donneurs</h3>
                <a href="${pageContext.request.contextPath}/donors?action=new" class="btn btn-danger">
                    <i class="fas fa-plus me-2"></i>Nouveau Donneur
                </a>
            </div>

            <c:choose>
                <c:when test="${empty donors}">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center py-5">
                            <i class="fas fa-users fa-3x text-muted mb-3"></i>
                            <h4 class="text-muted">Aucun donneur trouvé</h4>
                            <p class="text-muted mb-4">Il n'y a pas de donneurs enregistrés pour le moment.</p>
                            <a href="${pageContext.request.contextPath}/donors?action=new" class="btn btn-danger">
                                <i class="fas fa-plus me-2"></i>Ajouter le premier donneur
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover align-middle">
                                    <thead class="table-dark">
                                    <tr>
                                        <th class="ps-3">CIN</th>
                                        <th>Nom Complet</th>
                                        <th>Téléphone</th>
                                        <th>Âge</th>
                                        <th>Groupe Sanguin</th>
                                        <th>Poids</th>
                                        <th>Statut</th>
                                        <th class="text-center pe-3">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="donor" items="${donors}">
                                        <tr>
                                            <td class="ps-3 fw-semibold"><c:out value="${donor.cin}" /></td>
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
                                                <span class="badge blood-badge bg-danger">
                                                        ${donor.bloodGroup.displayName}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="fw-semibold">${donor.weight} kg</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${donor.status == 'DISPONIBLE'}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-check me-1"></i>Disponible
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${donor.status == 'NON_DISPONIBLE'}">
                                                        <span class="badge bg-warning text-dark">
                                                            <i class="fas fa-clock me-1"></i>Non Disponible
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">
                                                            <i class="fas fa-times me-1"></i>Non Éligible
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center pe-3">
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

                            <!-- Statistiques -->
                            <div class="mt-4 pt-3 border-top">
                                <div class="row text-center">
                                    <div class="col-md-3">
                                        <h5 class="text-primary mb-1">${fn:length(donors)}</h5>
                                        <small class="text-muted">Total Donneurs</small>
                                    </div>
                                    <div class="col-md-3">
                                        <h5 class="text-success mb-1">
                                            <c:set var="availableCount" value="0" />
                                            <c:forEach var="donor" items="${donors}">
                                                <c:if test="${donor.status == 'DISPONIBLE'}">
                                                    <c:set var="availableCount" value="${availableCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                                ${availableCount}
                                        </h5>
                                        <small class="text-muted">Disponibles</small>
                                    </div>
                                    <div class="col-md-3">
                                        <h5 class="text-warning mb-1">
                                            <c:set var="unavailableCount" value="0" />
                                            <c:forEach var="donor" items="${donors}">
                                                <c:if test="${donor.status == 'NON_DISPONIBLE'}">
                                                    <c:set var="unavailableCount" value="${unavailableCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                                ${unavailableCount}
                                        </h5>
                                        <small class="text-muted">Non Disponibles</small>
                                    </div>
                                    <div class="col-md-3">
                                        <h5 class="text-danger mb-1">
                                            <c:set var="ineligibleCount" value="0" />
                                            <c:forEach var="donor" items="${donors}">
                                                <c:if test="${donor.status == 'NON_ELIGIBLE'}">
                                                    <c:set var="ineligibleCount" value="${ineligibleCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                                ${ineligibleCount}
                                        </h5>
                                        <small class="text-muted">Non Éligibles</small>
                                    </div>
                                </div>
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