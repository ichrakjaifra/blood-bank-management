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
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.12);
        }

        .card-header {
            border: none;
            padding: 20px 24px;
            font-weight: 600;
        }

        .bg-success {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%) !important;
        }

        .bg-warning {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%) !important;
        }

        .bg-info {
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%) !important;
        }

        /* Compatibility cards with red hover effect */
        .compatibility-card {
            border: 2px solid #f0f0f0;
            border-radius: 12px;
            transition: all 0.3s ease;
            background: #ffffff;
        }

        .compatibility-card:hover {
            border-color: #dc3545;
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(220, 53, 69, 0.15);
        }

        .match-warning {
            border-left: 4px solid #ffc107;
        }

        /* Modern progress bars */
        .progress {
            height: 12px;
            border-radius: 10px;
            background-color: #f0f0f0;
        }

        .blood-badge {
            font-size: 0.85rem;
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 600;
        }

        /* Red-themed buttons */
        .btn-outline-primary {
            color: #dc3545;
            border-color: #dc3545;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background-color: #dc3545;
            border-color: #dc3545;
            transform: scale(1.05);
        }

        .btn-outline-success {
            transition: all 0.3s ease;
        }

        .btn-outline-success:hover {
            transform: scale(1.05);
        }

        .btn-outline-danger {
            transition: all 0.3s ease;
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

        /* Scrollable card body */
        .scrollable-body {
            max-height: 500px;
            overflow-y: auto;
        }

        .scrollable-body::-webkit-scrollbar {
            width: 8px;
        }

        .scrollable-body::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .scrollable-body::-webkit-scrollbar-thumb {
            background: #dc3545;
            border-radius: 10px;
        }

        .scrollable-body::-webkit-scrollbar-thumb:hover {
            background: #c82333;
        }

        /* Table styling */
        .table th {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            font-weight: 600;
            border: none;
            padding: 16px;
        }

        .table td {
            padding: 16px;
            vertical-align: middle;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(220, 53, 69, 0.03);
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
            <div class="page-header">
                <h1 class="h2">Matching Donneurs/Receveurs</h1>
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

            <div class="row">

                <div class="col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0">
                                <i class="fas fa-user-plus me-2"></i>
                                Donneurs Disponibles (${availableDonors.size()})
                            </h5>
                        </div>
                        <div class="card-body scrollable-body">
                            <c:forEach var="donor" items="${availableDonors}">
                                <div class="card compatibility-card mb-3">
                                    <div class="card-body">
                                        <h6 class="card-title fw-bold mb-2">${donor.fullName}</h6>
                                        <p class="card-text mb-2">
                                            <span class="badge blood-badge bg-danger">${donor.bloodGroup.displayName}</span>
                                            <span class="badge bg-secondary">${donor.age} ans</span>
                                        </p>
                                        <p class="card-text small text-muted mb-3">
                                            <i class="fas fa-id-card me-1"></i>CIN: ${donor.cin} |
                                            <i class="fas fa-phone me-1"></i>${donor.phone}
                                        </p>
                                        <a href="${pageContext.request.contextPath}/matching?action=findCompatibleReceivers&donorId=${donor.id}"
                                           class="btn btn-sm btn-outline-primary w-100">
                                            <i class="fas fa-search me-1"></i>Voir receveurs compatibles
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty availableDonors}">
                                <div class="text-center text-muted py-5">
                                    <i class="fas fa-users fa-3x mb-3"></i>
                                    <p>Aucun donneur disponible</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>


                <div class="col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-header bg-warning text-dark">
                            <h5 class="mb-0">
                                <i class="fas fa-user-injured me-2"></i>
                                Receveurs en Attente (${waitingReceivers.size()})
                            </h5>
                        </div>
                        <div class="card-body scrollable-body">
                            <c:forEach var="receiver" items="${waitingReceivers}">
                                <div class="card compatibility-card mb-3
                                    <c:if test="${receiver.medicalUrgency == 'CRITIQUE' || receiver.medicalUrgency == 'URGENT'}">match-warning</c:if>">
                                    <div class="card-body">
                                        <h6 class="card-title fw-bold mb-2">${receiver.fullName}</h6>
                                        <p class="card-text mb-2">
                                            <span class="badge blood-badge bg-danger">${receiver.bloodGroup.displayName}</span>
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
                                        <p class="card-text small text-muted mb-3">
                                                ${receiver.currentDonationCount}/${receiver.requiredDonationCount} poches
                                        </p>
                                        <a href="${pageContext.request.contextPath}/matching?action=findCompatibleDonors&receiverId=${receiver.id}"
                                           class="btn btn-sm btn-outline-success w-100">
                                            <i class="fas fa-search me-1"></i>Voir donneurs compatibles
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty waitingReceivers}">
                                <div class="text-center text-muted py-5">
                                    <i class="fas fa-users fa-3x mb-3"></i>
                                    <p>Aucun receveur en attente</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0">
                                <i class="fas fa-handshake me-2"></i>
                                Donations Actives (${activeDonations.size()})
                            </h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-striped mb-0">
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
                                            <td class="fw-semibold">${donation.donor.fullName}</td>
                                            <td class="fw-semibold">${donation.receiver.fullName}</td>
                                            <td>
                                                <span class="badge blood-badge bg-danger">${donation.donor.bloodGroup.displayName}</span>
                                            </td>
                                            <td>
                                                <span class="badge blood-badge bg-danger">${donation.receiver.bloodGroup.displayName}</span>
                                            </td>
                                            <td>${donation.donationDate}</td>
                                            <td>
                                                <form method="post" action="${pageContext.request.contextPath}/matching"
                                                      style="display: inline;">
                                                    <input type="hidden" name="action" value="cancelDonation">
                                                    <input type="hidden" name="donationId" value="${donation.id}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger"
                                                            onclick="return confirm('Annuler cette donation?')">
                                                        <i class="fas fa-times me-1"></i>Annuler
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty activeDonations}">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted py-4">
                                                Aucune donation active
                                            </td>
                                        </tr>
                                    </c:if>
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
