<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank - Matching Donneurs/Receveurs</title>
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
        .compatibility-card {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .compatibility-card:hover {
            border-color: #dc3545;
            transform: translateY(-2px);
        }
        .match-success {
            border-left: 4px solid #28a745;
        }
        .match-warning {
            border-left: 4px solid #ffc107;
        }
        .progress {
            height: 10px;
        }
        .blood-badge {
            font-size: 0.8em;
            padding: 0.3em 0.6em;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/receivers">
                            <i class="fas fa-user-injured me-2"></i> Receveurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/matching?action=showMatching">
                            <i class="fas fa-handshake me-2"></i> Matching
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2 text-dark">Matching Donneurs/Receveurs</h1>
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

            <div class="row">
                <!-- Donneurs Disponibles -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0">
                                <i class="fas fa-user-plus me-2"></i>
                                Donneurs Disponibles (${availableDonors.size()})
                            </h5>
                        </div>
                        <div class="card-body" style="max-height: 400px; overflow-y: auto;">
                            <c:forEach var="donor" items="${availableDonors}">
                                <div class="card compatibility-card mb-3">
                                    <div class="card-body">
                                        <h6 class="card-title">${donor.fullName}</h6>
                                        <p class="card-text mb-1">
                                            <span class="badge blood-badge bg-danger">${donor.bloodGroup.displayName}</span>
                                            <span class="badge bg-secondary">${donor.age} ans</span>
                                        </p>
                                        <p class="card-text small text-muted mb-2">
                                            CIN: ${donor.cin} | Tél: ${donor.phone}
                                        </p>
                                        <a href="${pageContext.request.contextPath}/matching?action=findCompatibleReceivers&donorId=${donor.id}"
                                           class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-search me-1"></i> Voir receveurs compatibles
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty availableDonors}">
                                <div class="text-center text-muted py-4">
                                    <i class="fas fa-users fa-2x mb-2"></i>
                                    <p>Aucun donneur disponible</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Receveurs en Attente -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-warning text-dark">
                            <h5 class="mb-0">
                                <i class="fas fa-user-injured me-2"></i>
                                Receveurs en Attente (${waitingReceivers.size()})
                            </h5>
                        </div>
                        <div class="card-body" style="max-height: 400px; overflow-y: auto;">
                            <c:forEach var="receiver" items="${waitingReceivers}">
                                <div class="card compatibility-card mb-3
                                    <c:choose>
                                        <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">match-warning</c:when>
                                        <c:when test="${receiver.medicalUrgency == 'URGENT'}">match-warning</c:when>
                                        <c:otherwise></c:otherwise>
                                    </c:choose>">
                                    <div class="card-body">
                                        <h6 class="card-title">${receiver.fullName}</h6>
                                        <p class="card-text mb-1">
                                            <span class="badge blood-badge bg-primary">${receiver.bloodGroup.displayName}</span>
                                            <span class="badge
                                                <c:choose>
                                                    <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                                    <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning</c:when>
                                                    <c:otherwise>bg-info</c:otherwise>
                                                </c:choose>">
                                                    ${receiver.medicalUrgency}
                                            </span>
                                        </p>
                                        <div class="progress mb-2">
                                            <div class="progress-bar
                                                <c:choose>
                                                    <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                                    <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning</c:when>
                                                    <c:otherwise>bg-info</c:otherwise>
                                                </c:choose>"
                                                 style="width: ${(receiver.currentDonationCount / receiver.requiredDonationCount) * 100}%">
                                            </div>
                                        </div>
                                        <p class="card-text small text-muted mb-2">
                                                ${receiver.currentDonationCount}/${receiver.requiredDonationCount} poches
                                        </p>
                                        <a href="${pageContext.request.contextPath}/matching?action=findCompatibleDonors&receiverId=${receiver.id}"
                                           class="btn btn-sm btn-outline-success">
                                            <i class="fas fa-search me-1"></i> Voir donneurs compatibles
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty waitingReceivers}">
                                <div class="text-center text-muted py-4">
                                    <i class="fas fa-users fa-2x mb-2"></i>
                                    <p>Aucun receveur en attente</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Donations Actives -->
            <div class="row mt-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0">
                                <i class="fas fa-handshake me-2"></i>
                                Donations Actives (${activeDonations.size()})
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>Donneur</th>
                                        <th>Receveur</th>
                                        <th>Groupe Donneur</th>
                                        <th>Groupe Receveur</th>
                                        <th>Date</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="donation" items="${activeDonations}">
                                        <tr>
                                            <td>${donation.donor.fullName}</td>
                                            <td>${donation.receiver.fullName}</td>
                                            <td>
                                                <span class="badge blood-badge bg-danger">${donation.donor.bloodGroup.displayName}</span>
                                            </td>
                                            <td>
                                                <span class="badge blood-badge bg-primary">${donation.receiver.bloodGroup.displayName}</span>
                                            </td>
                                            <td>${donation.donationDate}</td>
                                            <td>
                                                <form method="post" action="${pageContext.request.contextPath}/matching"
                                                      style="display: inline;">
                                                    <input type="hidden" name="action" value="cancelDonation">
                                                    <input type="hidden" name="donationId" value="${donation.id}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger"
                                                            onclick="return confirm('Annuler cette donation?')">
                                                        <i class="fas fa-times"></i> Annuler
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
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