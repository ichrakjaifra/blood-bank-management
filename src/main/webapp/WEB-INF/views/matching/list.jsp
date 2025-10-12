<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank - Liste des Donations</title>
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
                <h1 class="h2 text-dark">Liste des Donations</h1>
                <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn btn-primary">
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

            <!-- Liste des Donations -->
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-handshake me-2"></i>
                        Toutes les Donations (${donations.size()})
                    </h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty donations}">
                            <div class="text-center text-muted py-5">
                                <i class="fas fa-handshake fa-3x mb-3"></i>
                                <h4>Aucune donation trouvée</h4>
                                <p class="mb-3">Il n'y a pas de donations actives pour le moment.</p>
                                <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i> Créer une donation
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Donneur</th>
                                        <th>Receveur</th>
                                        <th>Groupe Donneur</th>
                                        <th>Groupe Receveur</th>
                                        <th>Date</th>
                                        <th>Statut</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="donation" items="${donations}">
                                        <tr>
                                            <td class="fw-semibold">#${donation.id}</td>
                                            <td>
                                                <div>
                                                    <strong>${donation.donor.fullName}</strong>
                                                    <br>
                                                    <small class="text-muted">${donation.donor.cin}</small>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <strong>${donation.receiver.fullName}</strong>
                                                    <br>
                                                    <small class="text-muted">${donation.receiver.cin}</small>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge blood-badge bg-danger">${donation.donor.bloodGroup.displayName}</span>
                                            </td>
                                            <td>
                                                <span class="badge blood-badge bg-primary">${donation.receiver.bloodGroup.displayName}</span>
                                            </td>
                                            <td>${donation.donationDate}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${donation.isActive}">
                                                            <span class="badge bg-success">
                                                                <i class="fas fa-check me-1"></i>Active
                                                            </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                            <span class="badge bg-secondary">
                                                                <i class="fas fa-times me-1"></i>Annulée
                                                            </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${donation.isActive}">
                                                    <form method="post" action="${pageContext.request.contextPath}/matching"
                                                          style="display: inline;">
                                                        <input type="hidden" name="action" value="cancelDonation">
                                                        <input type="hidden" name="donationId" value="${donation.id}">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger"
                                                                onclick="return confirm('Annuler cette donation?')">
                                                            <i class="fas fa-times"></i> Annuler
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Statistiques -->
                            <div class="mt-4 pt-3 border-top">
                                <div class="row text-center">
                                    <div class="col-md-4">
                                        <h5 class="text-primary mb-1">${donations.size()}</h5>
                                        <small class="text-muted">Total Donations</small>
                                    </div>
                                    <div class="col-md-4">
                                        <h5 class="text-success mb-1">
                                            <c:set var="activeCount" value="0" />
                                            <c:forEach var="donation" items="${donations}">
                                                <c:if test="${donation.isActive}">
                                                    <c:set var="activeCount" value="${activeCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                                ${activeCount}
                                        </h5>
                                        <small class="text-muted">Actives</small>
                                    </div>
                                    <div class="col-md-4">
                                        <h5 class="text-secondary mb-1">
                                            <c:set var="cancelledCount" value="0" />
                                            <c:forEach var="donation" items="${donations}">
                                                <c:if test="${!donation.isActive}">
                                                    <c:set var="cancelledCount" value="${cancelledCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                                ${cancelledCount}
                                        </h5>
                                        <small class="text-muted">Annulées</small>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>