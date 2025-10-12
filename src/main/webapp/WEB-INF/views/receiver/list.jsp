<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .priority-critical {
            background-color: #fff5f5 !important;
            border-left: 4px solid #dc3545;
        }
        .priority-urgent {
            background-color: #fff9e6 !important;
            border-left: 4px solid #ffc107;
        }
        .priority-normal {
            background-color: #f0f8ff !important;
            border-left: 4px solid #0dcaf0;
        }
        .urgency-badge {
            font-size: 0.7em;
            padding: 0.4em 0.8em;
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

            <!-- إحصائيات الأولوية -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card border-danger">
                        <div class="card-body text-center">
                            <h3 class="text-danger">
                                <c:set var="criticalCount" value="0" />
                                <c:forEach var="receiver" items="${receivers}">
                                    <c:if test="${receiver.medicalUrgency == 'CRITIQUE'}">
                                        <c:set var="criticalCount" value="${criticalCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${criticalCount}
                            </h3>
                            <p class="text-muted mb-0">Cas Critiques</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-warning">
                        <div class="card-body text-center">
                            <h3 class="text-warning">
                                <c:set var="urgentCount" value="0" />
                                <c:forEach var="receiver" items="${receivers}">
                                    <c:if test="${receiver.medicalUrgency == 'URGENT'}">
                                        <c:set var="urgentCount" value="${urgentCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${urgentCount}
                            </h3>
                            <p class="text-muted mb-0">Cas Urgents</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-info">
                        <div class="card-body text-center">
                            <h3 class="text-info">
                                <c:set var="normalCount" value="0" />
                                <c:forEach var="receiver" items="${receivers}">
                                    <c:if test="${receiver.medicalUrgency == 'NORMAL'}">
                                        <c:set var="normalCount" value="${normalCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${normalCount}
                            </h3>
                            <p class="text-muted mb-0">Cas Normaux</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- محتوى القائمة -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="text-dark mb-0">Liste des Receveurs</h3>
                    <small class="text-muted">Triée par priorité (CRITIQUE → URGENT → NORMAL)</small>
                </div>
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
                                <table class="table table-hover align-middle">
                                    <thead class="table-dark">
                                    <tr>
                                        <th>Priorité</th>
                                        <th>CIN</th>
                                        <th>Nom Complet</th>
                                        <th>Téléphone</th>
                                        <th>Âge</th>
                                        <th>Groupe Sanguin</th>
                                        <th>Statut</th>
                                        <th>Progression</th>
                                        <th class="text-center">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="receiver" items="${receivers}">
                                        <tr class="
                                            <c:choose>
                                                <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">priority-critical</c:when>
                                                <c:when test="${receiver.medicalUrgency == 'URGENT'}">priority-urgent</c:when>
                                                <c:otherwise>priority-normal</c:otherwise>
                                            </c:choose>">
                                            <td>
                                                <c:choose>
                                                    <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">
                                                        <span class="badge urgency-badge bg-danger">
                                                            <i class="fas fa-exclamation-triangle me-1"></i>CRITIQUE
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${receiver.medicalUrgency == 'URGENT'}">
                                                        <span class="badge urgency-badge bg-warning text-dark">
                                                            <i class="fas fa-exclamation-circle me-1"></i>URGENT
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge urgency-badge bg-info">
                                                            <i class="fas fa-info-circle me-1"></i>NORMAL
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
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
                                                    <c:when test="${receiver.status == 'SATISFAIT'}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-check me-1"></i>SATISFAIT
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">
                                                            <i class="fas fa-clock me-1"></i>EN ATTENTE
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="progress flex-grow-1 me-2" style="height: 12px;">
                                                        <div class="progress-bar
                                                                <c:choose>
                                                                    <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                                                    <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning</c:when>
                                                                    <c:otherwise>bg-info</c:otherwise>
                                                                </c:choose>"
                                                             role="progressbar"
                                                             style="width: ${(receiver.currentDonationCount / receiver.requiredDonationCount) * 100}%">
                                                        </div>
                                                    </div>
                                                    <small class="text-muted">
                                                            ${receiver.currentDonationCount}/${receiver.requiredDonationCount}
                                                    </small>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group btn-group-sm">
                                                    <a href="${pageContext.request.contextPath}/receivers?action=edit&id=${receiver.id}"
                                                       class="btn btn-outline-primary" title="Modifier">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/receivers?action=delete&id=${receiver.id}"
                                                       class="btn btn-outline-danger"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce receveur?')"
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

                            <!-- إحصائيات -->
                            <div class="mt-4 pt-3 border-top">
                                <div class="row text-center">
                                    <div class="col-md-3">
                                        <h5 class="text-primary mb-1">${receivers.size()}</h5>
                                        <small class="text-muted">Total Receveurs</small>
                                    </div>
                                    <div class="col-md-3">
                                        <h5 class="text-success mb-1">
                                            <c:set var="satisfiedCount" value="0" />
                                            <c:forEach var="receiver" items="${receivers}">
                                                <c:if test="${receiver.status == 'SATISFAIT'}">
                                                    <c:set var="satisfiedCount" value="${satisfiedCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                                ${satisfiedCount}
                                        </h5>
                                        <small class="text-muted">Satisfaits</small>
                                    </div>
                                    <div class="col-md-3">
                                        <h5 class="text-warning mb-1">
                                            <c:set var="waitingCount" value="0" />
                                            <c:forEach var="receiver" items="${receivers}">
                                                <c:if test="${receiver.status == 'EN_ATTENTE'}">
                                                    <c:set var="waitingCount" value="${waitingCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                                ${waitingCount}
                                        </h5>
                                        <small class="text-muted">En Attente</small>
                                    </div>
                                    <div class="col-md-3">
                                        <h5 class="text-info mb-1">
                                            <c:set var="totalNeeded" value="0" />
                                            <c:forEach var="receiver" items="${receivers}">
                                                <c:set var="totalNeeded" value="${totalNeeded + receiver.requiredDonationCount}" />
                                            </c:forEach>
                                                ${totalNeeded}
                                        </h5>
                                        <small class="text-muted">Poches Nécessaires</small>
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