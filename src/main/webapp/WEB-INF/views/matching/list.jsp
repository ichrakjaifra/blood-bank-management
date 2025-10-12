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
        body {
            background-color: #ffffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Modern sidebar with red gradient */
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #dc3545 0%, #c82333 100%);
            box-shadow: 2px 0 10px rgba(220, 53, 69, 0.1);
        }

        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.9);
            padding: 14px 24px;
            margin: 6px 12px;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .sidebar .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.15);
            color: #ffffff;
            transform: translateX(5px);
        }

        .sidebar .nav-link.active {
            background-color: rgba(255, 255, 255, 0.25);
            color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .sidebar h4 {
            padding: 24px 0;
            border-bottom: 2px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 20px;
        }

        /* Clean white main content */
        .main-content {
            background-color: #f8f9fa;
            min-height: 100vh;
            padding: 30px;
        }

        /* Modern card design */
        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            background: #ffffff;
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
            border: none;
            padding: 20px 24px;
        }

        /* Red-themed table styling */
        .table th {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            font-weight: 600;
            border: none;
            padding: 16px;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .table td {
            padding: 16px;
            vertical-align: middle;
            border-color: #f0f0f0;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(220, 53, 69, 0.03);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(220, 53, 69, 0.08);
            transform: scale(1.01);
            transition: all 0.2s ease;
        }

        .blood-badge {
            font-size: 0.85rem;
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 600;
        }

        /* Red-themed buttons */
        .btn-primary {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border: none;
            padding: 12px 28px;
            border-radius: 10px;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(220, 53, 69, 0.4);
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
        }

        .btn-outline-danger:hover {
            transform: scale(1.05);
        }

        /* Page header with red border */
        .page-header {
            border-bottom: 3px solid #dc3545;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }

        .page-header h1 {
            color: #2c3e50;
            font-weight: 700;
        }

        /* Statistics styling */
        .stats-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 12px;
            padding: 24px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">

        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
            <div class="position-sticky pt-3">
                <h4 class="text-white text-center">
                    <i class="fas fa-tint me-2"></i>Blood Bank
                </h4>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-2"></i>Accueil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/donors">
                            <i class="fas fa-user-plus me-2"></i>Donneurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/receivers">
                            <i class="fas fa-user-injured me-2"></i>Receveurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/matching?action=showMatching">
                            <i class="fas fa-handshake me-2"></i>Matching
                        </a>
                    </li>
                </ul>
            </div>
        </nav>


        <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
            <div class="d-flex justify-content-between align-items-center page-header">
                <h1 class="h2 mb-0">Liste des Donations</h1>
                <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn btn-primary">
                    <i class="fas fa-arrow-left me-2"></i>Retour au Matching
                </a>
            </div>


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


            <div class="card">
                <div class="card-header text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-handshake me-2"></i>
                        Toutes les Donations (${donations.size()})
                    </h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty donations}">
                            <div class="text-center text-muted py-5">
                                <i class="fas fa-handshake fa-3x mb-3"></i>
                                <h4>Aucune donation trouvée</h4>
                                <p class="mb-3">Il n'y a pas de donations actives pour le moment.</p>
                                <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i>Créer une donation
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover mb-0">
                                    <thead>
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
                                            <td class="fw-bold text-danger">#${donation.id}</td>
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
                                                <span class="badge blood-badge bg-danger">${donation.receiver.bloodGroup.displayName}</span>
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
                                                            <i class="fas fa-times me-1"></i>Annuler
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            Statistics
                            <div class="stats-section m-4">
                                <div class="row text-center">
                                    <div class="col-md-4">
                                        <h4 class="text-danger mb-1 fw-bold">${donations.size()}</h4>
                                        <small class="text-muted fw-semibold">Total Donations</small>
                                    </div>
                                    <div class="col-md-4">
                                        <h4 class="text-success mb-1 fw-bold">
                                            <c:set var="activeCount" value="0" />
                                            <c:forEach var="donation" items="${donations}">
                                                <c:if test="${donation.isActive}">
                                                    <c:set var="activeCount" value="${activeCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                                ${activeCount}
                                        </h4>
                                        <small class="text-muted fw-semibold">Actives</small>
                                    </div>
                                    <div class="col-md-4">
                                        <h4 class="text-secondary mb-1 fw-bold">
                                            <c:set var="cancelledCount" value="0" />
                                            <c:forEach var="donation" items="${donations}">
                                                <c:if test="${!donation.isActive}">
                                                    <c:set var="cancelledCount" value="${cancelledCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                                ${cancelledCount}
                                        </h4>
                                        <small class="text-muted fw-semibold">Annulées</small>
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
