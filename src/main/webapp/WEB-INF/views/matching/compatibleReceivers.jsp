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

        /* Donor info card with green gradient */
        .donor-info {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(40, 167, 69, 0.3);
        }

        /* Compatibility cards with hover effect */
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

        .card-header {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border: none;
            padding: 20px 24px;
        }

        .bg-info {
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%) !important;
        }

        /* Modern progress bars */
        .progress {
            height: 12px;
            border-radius: 10px;
            background-color: #f0f0f0;
        }

        .progress-bar {
            border-radius: 10px;
        }

        /* Red-themed badges */
        .badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
        }

        /* Red-themed buttons */
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            border: none;
            padding: 12px 28px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(108, 117, 125, 0.3);
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(220, 53, 69, 0.3);
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
                <h1 class="h2 mb-0">Receveurs Compatibles</h1>
                <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn btn-secondary">
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


            <div class="card donor-info mb-4">
                <div class="card-body p-4">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h4 class="card-title mb-3 fw-bold">${donor.fullName}</h4>
                            <p class="card-text mb-2">
                                <strong>CIN:</strong> ${donor.cin} |
                                <strong>Âge:</strong> ${donor.age} ans |
                                <strong>Téléphone:</strong> ${donor.phone}
                            </p>
                            <p class="card-text mb-2">
                                <span class="badge bg-light text-dark me-2">Groupe Sanguin: ${donor.bloodGroup.displayName}</span>
                                <span class="badge bg-light text-dark">Poids: ${donor.weight} kg</span>
                            </p>
                            <p class="card-text mb-0">
                                <span class="badge ${donor.status == 'DISPONIBLE' ? 'bg-success' : 'bg-secondary'}">
                                    ${donor.status}
                                </span>
                            </p>
                        </div>
                        <div class="col-md-4 text-center">
                            <i class="fas fa-user-plus fa-4x mb-2" style="opacity: 0.3;"></i>
                            <p class="mb-0 fw-semibold">Donneur Disponible</p>
                        </div>
                    </div>
                </div>
            </div>


            <div class="card">
                <div class="card-header text-white">
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
                                <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Retour au Matching
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <c:forEach var="receiver" items="${compatibleReceivers}">
                                    <div class="col-md-6 mb-4">
                                        <div class="card compatibility-card h-100">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-start mb-3">
                                                    <h6 class="card-title mb-0 fw-bold">${receiver.fullName}</h6>
                                                    <span class="badge bg-danger">Compatible</span>
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
                                                            <span class="badge bg-danger">${receiver.bloodGroup.displayName}</span>
                                                        </p>
                                                    </div>
                                                    <div class="col-6">
                                                        <small class="text-muted">Urgence</small>
                                                        <p class="mb-1">
                                                            <span class="badge
                                                                <c:choose>
                                                                    <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                                                    <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning text-dark</c:when>
                                                                    <c:otherwise>bg-info</c:otherwise>
                                                                </c:choose>">
                                                                    ${receiver.medicalUrgency}
                                                            </span>
                                                        </p>
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <small class="text-muted">Progression</small>
                                                    <div class="progress mt-1">
                                                        <div class="progress-bar
                                                            <c:choose>
                                                                <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                                                <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning</c:when>
                                                                <c:otherwise>bg-info</c:otherwise>
                                                            </c:choose>"
                                                             style="width: ${(receiver.currentDonationCount / receiver.requiredDonationCount) * 100}%">
                                                        </div>
                                                    </div>
                                                    <small class="text-muted">${receiver.currentDonationCount}/${receiver.requiredDonationCount} poches</small>
                                                </div>

                                                Association Button
                                                <form method="post" action="${pageContext.request.contextPath}/matching"
                                                      class="mt-auto">
                                                    <input type="hidden" name="action" value="createDonation">
                                                    <input type="hidden" name="donorId" value="${donor.id}">
                                                    <input type="hidden" name="receiverId" value="${receiver.id}">
                                                    <button type="submit" class="btn btn-danger w-100"
                                                            onclick="return confirm('Associer ${donor.fullName} avec ${receiver.fullName}?')">
                                                        <i class="fas fa-handshake me-2"></i>Associer
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


            <div class="card mt-4">
                <div class="card-header bg-info text-white">
                    <h6 class="mb-0">
                        <i class="fas fa-info-circle me-2"></i>
                        Informations de Compatibilité
                    </h6>
                </div>
                <div class="card-body">
                    <p class="mb-2">
                        <strong>Donneur:</strong> Groupe ${donor.bloodGroup.displayName}
                    </p>
                    <p class="mb-0">
                        <strong>Receveurs compatibles:</strong>
                        <c:forEach var="compatibleGroup" items="${compatibleReceivers}" varStatus="status">
                            ${compatibleGroup.bloodGroup.displayName}<c:if test="${!status.last}">, </c:if>
                        </c:forEach>
                    </p>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
