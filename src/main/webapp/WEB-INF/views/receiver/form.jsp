<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank - ${empty receiver ? 'Nouveau Receveur' : 'Modifier Receveur'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            color: #1a1a1a;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 260px;
            background-color: #dc2626;
            padding: 0;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 32px 24px;
            background-color: #b91c1c;
            text-align: center;
        }

        .logo {
            color: #ffffff;
            font-size: 24px;
            font-weight: 700;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .logo i {
            font-size: 32px;
        }

        .nav-menu {
            padding: 24px 0;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 24px;
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            transition: all 0.2s ease;
            font-weight: 500;
            border-left: 4px solid transparent;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-left-color: #ffffff;
        }

        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.15);
            color: #ffffff;
            border-left-color: #ffffff;
        }

        .nav-link i {
            width: 20px;
            text-align: center;
        }

        .main-content {
            margin-left: 260px;
            padding: 40px;
            min-height: 100vh;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-success {
            background-color: #059669;
            color: white;
        }

        .btn-success:hover {
            background-color: #047857;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(5, 150, 105, 0.3);
        }

        .btn-secondary {
            background-color: #6b7280;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #4b5563;
            transform: translateY(-2px);
        }

        .form-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            margin-bottom: 32px;
        }

        .form-card .card-body {
            padding: 35px;
        }

        .section-title {
            color: #dc2626;
            font-weight: 600;
            font-size: 1.3rem;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #fef2f2;
        }

        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #dc2626;
            box-shadow: 0 0 0 0.2rem rgba(220, 38, 38, 0.15);
        }

        .form-check-input:checked {
            background-color: #dc2626;
            border-color: #dc2626;
        }

        .form-check-input:focus {
            border-color: #dc2626;
            box-shadow: 0 0 0 0.2rem rgba(220, 38, 38, 0.15);
        }

        .form-check-label {
            font-weight: 500;
            color: #374151;
        }

        .alert {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            border-left: 4px solid;
        }

        .alert-success {
            background-color: #d1fae5;
            border-color: #059669;
            color: #065f46;
        }

        .alert-danger {
            background-color: #fee2e2;
            border-color: #dc2626;
            color: #991b1b;
        }

        .form-text {
            background-color: #eff6ff;
            padding: 12px;
            border-radius: 6px;
            border-left: 3px solid #3b82f6;
            margin-top: 8px;
        }

        .form-text ul {
            margin-bottom: 0;
            padding-left: 20px;
        }

        .form-text li {
            margin-bottom: 4px;
            color: #6b7280;
        }

        .status-info {
            background-color: #f0fdf4;
            padding: 16px;
            border-radius: 8px;
            border-left: 3px solid #22c55e;
        }

        .status-info strong {
            color: #1a1a1a;
        }

        .badge {
            font-size: 0.875rem;
            padding: 4px 12px;
            border-radius: 6px;
        }

        .bg-success {
            background-color: #059669 !important;
        }

        .bg-secondary {
            background-color: #6b7280 !important;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="sidebar-header">
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <i class="fas fa-tint"></i>
            <span>Blood Bank</span>
        </a>
    </div>
    <nav class="nav-menu">
        <a href="${pageContext.request.contextPath}/home" class="nav-link">
            <i class="fas fa-home"></i>
            <span>Accueil</span>
        </a>
        <a href="${pageContext.request.contextPath}/donors" class="nav-link">
            <i class="fas fa-user-plus"></i>
            <span>Donneurs</span>
        </a>
        <a href="${pageContext.request.contextPath}/receivers" class="nav-link active">
            <i class="fas fa-user-injured"></i>
            <span>Receveurs</span>
        </a>
        <a href="${pageContext.request.contextPath}/matching?action=showMatching" class="nav-link">
            <i class="fas fa-handshake"></i>
            <span>Matching</span>
        </a>
    </nav>
</div>

<div class="main-content">
    <div class="page-header">
        <h1 class="page-title">
            <i class="fas fa-user-injured me-2"></i>
            ${empty receiver ? 'Nouveau Receveur' : 'Modifier Receveur'}
        </h1>
        <a href="${pageContext.request.contextPath}/receivers" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i>
            Retour
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i>
                ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>
                ${error}
        </div>
    </c:if>

    <div class="form-card">
        <div class="card-body">
            <form method="post" action="${pageContext.request.contextPath}/receivers">
                <c:if test="${not empty receiver}">
                    <input type="hidden" name="id" value="${receiver.id}">
                    <input type="hidden" name="action" value="update">
                </c:if>
                <c:if test="${empty receiver}">
                    <input type="hidden" name="action" value="create">
                </c:if>

                <div class="row">
                    <div class="col-md-6">
                        <h5 class="section-title">Informations Personnelles</h5>

                        <div class="mb-3">
                            <label for="cin" class="form-label">CIN *</label>
                            <input type="text" class="form-control" id="cin" name="cin"
                                   value="${receiver.cin}" required>
                        </div>

                        <div class="mb-3">
                            <label for="firstName" class="form-label">Prénom *</label>
                            <input type="text" class="form-control" id="firstName" name="firstName"
                                   value="${receiver.firstName}" required>
                        </div>

                        <div class="mb-3">
                            <label for="lastName" class="form-label">Nom *</label>
                            <input type="text" class="form-control" id="lastName" name="lastName"
                                   value="${receiver.lastName}" required>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Téléphone</label>
                            <input type="tel" class="form-control" id="phone" name="phone"
                                   value="${receiver.phone}">
                        </div>

                        <div class="mb-3">
                            <label for="birthDate" class="form-label">Date de Naissance *</label>
                            <input type="date" class="form-control" id="birthDate" name="birthDate"
                                   value="${receiver.birthDate}" required>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <h5 class="section-title">Informations Médicales</h5>

                        <div class="mb-3">
                            <label class="form-label">Sexe *</label>
                            <div>
                                <c:forEach var="gender" items="${genders}">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="gender"
                                               id="gender${gender}" value="${gender}"
                                               <c:if test="${receiver.gender == gender}">checked</c:if> required>
                                        <label class="form-check-label" for="gender${gender}">
                                                ${gender.displayName}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="bloodGroup" class="form-label">Groupe Sanguin *</label>
                            <select class="form-select" id="bloodGroup" name="bloodGroup" required>
                                <option value="">Sélectionnez un groupe</option>
                                <c:forEach var="bloodGroup" items="${bloodGroups}">
                                    <option value="${bloodGroup}"
                                            <c:if test="${receiver.bloodGroup == bloodGroup}">selected</c:if>>
                                            ${bloodGroup.displayName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="medicalUrgency" class="form-label">Niveau d'Urgence *</label>
                            <select class="form-select" id="medicalUrgency" name="medicalUrgency" required>
                                <option value="">Sélectionnez une urgence</option>
                                <c:forEach var="urgency" items="${medicalUrgencies}">
                                    <option value="${urgency}"
                                            <c:if test="${receiver.medicalUrgency == urgency}">selected</c:if>>
                                            ${urgency} (${urgency.requiredBags} poche(s) nécessaire(s))
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="form-text">
                                <ul class="small">
                                    <li><strong>CRITIQUE:</strong> 4 poches de sang nécessaires</li>
                                    <li><strong>URGENT:</strong> 3 poches de sang nécessaires</li>
                                    <li><strong>NORMAL:</strong> 1 poche de sang nécessaire</li>
                                </ul>
                            </div>
                        </div>

                        <c:if test="${not empty receiver}">
                            <div class="status-info">
                                <strong>Statut actuel:</strong>
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${receiver.status == 'SATISFAIT'}">bg-success</c:when>
                                        <c:otherwise>bg-secondary</c:otherwise>
                                    </c:choose>">
                                        ${receiver.status}
                                </span>
                                <br>
                                <strong>Progression:</strong>
                                    ${receiver.currentDonationCount} / ${receiver.requiredDonationCount} poches
                            </div>
                        </c:if>
                    </div>
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save me-2"></i>
                        ${empty receiver ? 'Créer le receveur' : 'Modifier le receveur'}
                    </button>
                    <a href="${pageContext.request.contextPath}/receivers" class="btn btn-secondary">
                        <i class="fas fa-times me-2"></i> Annuler
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>