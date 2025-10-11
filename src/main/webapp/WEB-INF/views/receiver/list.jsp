<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank Management - Gestion des Receveurs</title>
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
            font-size: 0.8em;
            padding: 0.3em 0.6em;
            border-radius: 10px;
        }
        .table th {
            background-color: #343a40;
            color: white;
            font-weight: 600;
            border: none;
        }
        .table td {
            vertical-align: middle;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .progress {
            height: 8px;
            border-radius: 10px;
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
                    <i class="fas fa-tint me-2"></i> Blood Bank
                </h4>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-2"></i> Accueil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/donors">
                            <i class="fas fa-user-plus me-2"></i> Donneurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/receivers">
                            <i class="fas fa-user-injured me-2"></i> Receveurs
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2 text-dark">Gestion des Receveurs</h1>
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
                <h3 class="text-dark mb-0">Liste des Receveurs</h3>
                <a href="${pageContext.request.contextPath}/receivers?action=new" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i> Nouveau Receveur
                </a>
            </div>

            <c:choose>
                <c:when test="${empty receivers}">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center py-5">
                            <i class="fas fa-users fa-3x text-muted mb-3"></i>
                            <h4 class="text-muted">Aucun receveur trouvé</h4>
                            <p class="text-muted mb-4">Il n'y a pas de receveurs enregistrés pour le moment.</p>
                            <a href="${pageContext.request.contextPath}/receivers?action=new" class="btn btn-primary">
                                <i class="fas fa-plus me-2"></i> Ajouter le premier receveur
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
                                        <th>CIN</th>
                                        <th>Nom Complet</th>
                                        <th>Téléphone</th>
                                        <th>Âge</th>
                                        <th>Groupe Sanguin</th>
                                        <th>Urgence</th>
                                        <th>Statut</th>
                                        <th>Progression</th>
                                        <th class="text-center">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="receiver" items="${receivers}">
                                        <tr>
                                            <td class="fw-semibold"><c:out value="${receiver.cin}" /></td>
                                            <td class="fw-semibold"><c:out value="${receiver.fullName}" /></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty receiver.phone}">
                                                        <c:out value="${receiver.phone}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Non renseigné</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="badge bg-light text-dark">${receiver.age} ans</span>
                                            </td>
                                            <td>
                                                <span class="badge blood-badge bg-danger">
                                                        ${receiver.bloodGroup.displayName}
                                                </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">
                                                        <span class="badge bg-danger">CRITIQUE</span>
                                                    </c:when>
                                                    <c:when test="${receiver.medicalUrgency == 'URGENT'}">
                                                        <span class="badge bg-warning">URGENT</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-info">NORMAL</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${receiver.status == 'SATISFAIT'}">
                                                        <span class="badge bg-success">SATISFAIT</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">EN ATTENTE</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="progress" style="height: 20px;">
                                                    <div class="progress-bar
                                                            <c:choose>
                                                                <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                                                <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning</c:when>
                                                                <c:otherwise>bg-info</c:otherwise>
                                                            </c:choose>"
                                                         role="progressbar"
                                                         style="width: ${(receiver.currentDonationCount / receiver.requiredDonationCount) * 100}%">
                                                            ${receiver.currentDonationCount}/${receiver.requiredDonationCount}
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group btn-group-sm">
                                                    <a href="${pageContext.request.contextPath}/receivers?action=edit&id=${receiver.id}"
                                                       class="btn btn-outline-primary">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/receivers?action=delete&id=${receiver.id}"
                                                       class="btn btn-outline-danger"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce receveur?')">
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
                            <div class="mt-3 text-muted text-center">
                                <small>Total: ${fn:length(receivers)} receveur(s)</small>
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