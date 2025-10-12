<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank - Donneurs Compatibles</title>
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

        /* Receiver info card with gradient */
        .receiver-info {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(220, 53, 69, 0.3);
        }

        /* Compatibility cards with hover effect */
        .compatibility-card {
            border: 2px solid #f0f0f0;
            border-radius: 12px;
            transition: all 0.3s ease;
            background: #ffffff;
        }

        .compatibility-card:hover {
            border-color: #28a745;
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(40, 167, 69, 0.15);
        }

        .card-header {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            border: none;
            padding: 20px 24px;
        }

        .bg-info {
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%) !important;
        }

        /* Modern progress bars */
        .progress {
            height: 24px;
            border-radius: 12px;
            background-color: rgba(255, 255, 255, 0.3);
        }

        .progress-bar {
            border-radius: 12px;
            font-weight: 600;
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

        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(40, 167, 69, 0.3);
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
                <h1 class="h2 mb-0">Donneurs Compatibles</h1>
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


            <div class="card receiver-info mb-4">
                <div class="card-body p-4">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h4 class="card-title mb-3 fw-bold">${receiver.fullName}</h4>
                            <p class="card-text mb-2">
                                <strong>CIN:</strong> ${receiver.cin} |
                                <strong>Âge:</strong> ${receiver.age} ans |
                                <strong>Téléphone:</strong> ${receiver.phone}
                            </p>
                            <p class="card-text mb-2">
                                <span class="badge bg-light text-dark me-2">Groupe Sanguin: ${receiver.bloodGroup.displayName}</span>
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                        <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning text-dark</c:when>
                                        <c:otherwise>bg-info</c:otherwise>
                                    </c:choose>">
                                    Urgence: ${receiver.medicalUrgency}
                                </span>
                            </p>
                            <p class="card-text mb-0">
                                <strong>Progression:</strong> ${receiver.currentDonationCount}/${receiver.requiredDonationCount} poches
                            </p>
                        </div>
                        <div class="col-md-4">
                            <div class="progress mb-3">
                                <div class="progress-bar
                                    <c:choose>
                                        <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                        <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning</c:when>
                                        <c:otherwise>bg-info</c:otherwise>
                                    </c:choose>"
                                     style="width: ${(receiver.currentDonationCount / receiver.requiredDonationCount) * 100}%">
                                    ${receiver.currentDonationCount}/${receiver.requiredDonationCount}
                                </div>
                            </div>
                            <span class="badge ${receiver.status == 'SATISFAIT' ? 'bg-success' : 'bg-secondary'} w-100">
                                ${receiver.status}
                            </span>
                        </div>
                    </div>
                </div>
            </div>


            <div class="card">
                <div class="card-header text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-user-check me-2"></i>
                        Donneurs Compatibles (${compatibleDonors.size()})
                    </h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty compatibleDonors}">
                            <div class="text-center text-muted py-5">
                                <i class="fas fa-users-slash fa-3x mb-3"></i>
                                <h4>Aucun donneur compatible trouvé</h4>
                                <p class="mb-3">Aucun donneur disponible n'est compatible avec le groupe sanguin ${receiver.bloodGroup.displayName}</p>
                                <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Retour au Matching
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <c:forEach var="donor" items="${compatibleDonors}">
                                    <div class="col-md-6 mb-4">
                                        <div class="card compatibility-card h-100">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-start mb-3">
                                                    <h6 class="card-title mb-0 fw-bold">${donor.fullName}</h6>
                                                    <span class="badge bg-success">Compatible</span>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-6">
                                                        <small class="text-muted">CIN</small>
                                                        <p class="mb-1 fw-semibold">${donor.cin}</p>
                                                    </div>
                                                    <div class="col-6">
                                                        <small class="text-muted">Âge</small>
                                                        <p class="mb-1 fw-semibold">${donor.age} ans</p>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-6">
                                                        <small class="text-muted">Groupe Sanguin</small>
                                                        <p class="mb-1">
                                                            <span class="badge bg-danger">${donor.bloodGroup.displayName}</span>
                                                        </p>
                                                    </div>
                                                    <div class="col-6">
                                                        <small class="text-muted">Poids</small>
                                                        <p class="mb-1 fw-semibold">${donor.weight} kg</p>
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <small class="text-muted">Téléphone</small>
                                                    <p class="mb-2 fw-semibold">
                                                        <c:choose>
                                                            <c:when test="${not empty donor.phone}">
                                                                ${donor.phone}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Non renseigné</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>

                                                Association Button
                                                <form method="post" action="${pageContext.request.contextPath}/matching"
                                                      class="mt-auto">
                                                    <input type="hidden" name="action" value="createDonation">
                                                    <input type="hidden" name="donorId" value="${donor.id}">
                                                    <input type="hidden" name="receiverId" value="${receiver.id}">
                                                    <button type="submit" class="btn btn-success w-100"
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
                        <strong>Receveur:</strong> Groupe ${receiver.bloodGroup.displayName}
                    </p>
                    <p class="mb-0">
                        <strong>Donneurs compatibles:</strong>
                        <c:forEach var="compatibleGroup" items="${compatibleDonors}" varStatus="status">
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
