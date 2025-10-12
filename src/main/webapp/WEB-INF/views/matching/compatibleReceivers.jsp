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
        .compatibility-card {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .compatibility-card:hover {
            border-color: #007bff;
            transform: translateY(-2px);
        }
        .donor-info {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }
        .priority-critical { border-left: 4px solid #dc3545; }
        .priority-urgent { border-left: 4px solid #ffc107; }
        .priority-normal { border-left: 4px solid #0dcaf0; }
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/receivers">
                            <i class="fas fa-user-injured me-2"></i> Receveurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/matching">
                            <i class="fas fa-handshake me-2"></i> Matching
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2 text-dark">Receveurs Compatibles</h1>
                <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i> Retour au Matching
                </a>
            </div>

            <!-- Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Informations du Donneur -->
            <div class="card donor-info mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8">
                            <h4 class="card-title">${donor.fullName}</h4>
                            <p class="card-text mb-1">
                                <strong>CIN:</strong> ${donor.cin} |
                                <strong>Âge:</strong> ${donor.age} ans |
                                <strong>Téléphone:</strong> ${donor.phone}
                            </p>
                            <p class="card-text mb-1">
                                <span class="badge bg-light text-dark me-2">Groupe Sanguin: ${donor.bloodGroup.displayName}</span>
                                <span class="badge bg-success">${donor.status}</span>
                            </p>
                            <p class="card-text mb-0">
                                <strong>Poids:</strong> ${donor.weight} kg |
                                <strong>Sexe:</strong> ${donor.gender.displayName}
                            </p>
                        </div>
                        <div class="col-md-4 text-end">
                            <div class="mb-3">
                                <span class="badge bg-${donor.isAvailable() ? 'success' : 'secondary'} fs-6">
                                    <i class="fas fa-${donor.isAvailable() ? 'check' : 'clock'} me-1"></i>
                                    ${donor.status}
                                </span>
                            </div>
                            <p class="mb-0">
                                <small>Donneur éligible et disponible</small>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Receveurs Compatibles -->
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-user-injured me-2"></i>
                        Receveurs Compatibles (${compatibleReceivers.size()})
                    </h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty compatibleReceivers}">
                            <div class="text-center text-muted py-5">
                                <i class="fas fa-users-slash fa-3x mb-3"></i>
                                <h4>Aucun receveur compatible trouvé</h4>
                                <p class="mb-3">Aucun receveur en attente n'est compatible avec le groupe sanguin ${donor.bloodGroup.displayName}</p>
                                <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn btn-primary">
                                    <i class="fas fa-arrow-left me-2"></i> Retour au Matching
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <c:forEach var="receiver" items="${compatibleReceivers}">
                                    <div class="col-md-6 mb-3">
                                        <div class="card compatibility-card h-100
                                            priority-${receiver.medicalUrgency.toString().toLowerCase()}">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-start mb-3">
                                                    <h6 class="card-title mb-0">${receiver.fullName}</h6>
                                                    <span class="badge
                                                        <c:choose>
                                                            <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                                            <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning text-dark</c:when>
                                                            <c:otherwise>bg-info</c:otherwise>
                                                        </c:choose>">
                                                            ${receiver.medicalUrgency}
                                                    </span>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-6">
                                                        <small class="text-muted">CIN</small>
                                                        <p class="mb-1 fw-semibold">${receiver.cin}</p>
                                                    </div>
                                                    <div class="col-6">
                                                        <small class="text-muted">Âge</small>
                                                        <p class="mb-1 fw-semibold">${receiver.age} ans</p>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-6">
                                                        <small class="text-muted">Groupe Sanguin</small>
                                                        <p class="mb-1">
                                                            <span class="badge bg-primary">${receiver.bloodGroup.displayName}</span>
                                                        </p>
                                                    </div>
                                                    <div class="col-6">
                                                        <small class="text-muted">Besoin</small>
                                                        <p class="mb-1 fw-semibold">${receiver.requiredDonationCount} poche(s)</p>
                                                    </div>
                                                </div>

                                                <!-- Barre de progression -->
                                                <div class="mb-3">
                                                    <small class="text-muted">Progression</small>
                                                    <div class="progress" style="height: 12px;">
                                                        <div class="progress-bar
                                                            <c:choose>
                                                                <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                                                <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning</c:when>
                                                                <c:otherwise>bg-info</c:otherwise>
                                                            </c:choose>"
                                                             style="width: ${(receiver.currentDonationCount / receiver.requiredDonationCount) * 100}%">
                                                        </div>
                                                    </div>
                                                    <small class="text-muted">
                                                            ${receiver.currentDonationCount}/${receiver.requiredDonationCount} poches
                                                    </small>
                                                </div>

                                                <div class="mb-3">
                                                    <small class="text-muted">Statut</small>
                                                    <p class="mb-2">
                                                        <span class="badge bg-${receiver.status == 'SATISFAIT' ? 'success' : 'secondary'}">
                                                                ${receiver.status}
                                                        </span>
                                                    </p>
                                                </div>

                                                <!-- Bouton d'association -->
                                                <form method="post" action="${pageContext.request.contextPath}/matching"
                                                      class="mt-auto">
                                                    <input type="hidden" name="action" value="createDonation">
                                                    <input type="hidden" name="donorId" value="${donor.id}">
                                                    <input type="hidden" name="receiverId" value="${receiver.id}">
                                                    <button type="submit" class="btn btn-primary w-100"
                                                            onclick="return confirm('Associer ${donor.fullName} avec ${receiver.fullName}?')">
                                                        <i class="fas fa-handshake me-2"></i> Associer
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Statistiques -->
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card text-white bg-danger">
                        <div class="card-body text-center">
                            <h4>
                                <c:set var="criticalCount" value="0" />
                                <c:forEach var="receiver" items="${compatibleReceivers}">
                                    <c:if test="${receiver.medicalUrgency == 'CRITIQUE'}">
                                        <c:set var="criticalCount" value="${criticalCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${criticalCount}
                            </h4>
                            <p class="mb-0">Cas Critiques</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-warning">
                        <div class="card-body text-center">
                            <h4>
                                <c:set var="urgentCount" value="0" />
                                <c:forEach var="receiver" items="${compatibleReceivers}">
                                    <c:if test="${receiver.medicalUrgency == 'URGENT'}">
                                        <c:set var="urgentCount" value="${urgentCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${urgentCount}
                            </h4>
                            <p class="mb-0">Cas Urgents</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-info">
                        <div class="card-body text-center">
                            <h4>
                                <c:set var="normalCount" value="0" />
                                <c:forEach var="receiver" items="${compatibleReceivers}">
                                    <c:if test="${receiver.medicalUrgency == 'NORMAL'}">
                                        <c:set var="normalCount" value="${normalCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${normalCount}
                            </h4>
                            <p class="mb-0">Cas Normaux</p>
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