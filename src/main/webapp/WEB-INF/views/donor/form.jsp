<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank Management - ${empty donor ? 'Nouveau Donneur' : 'Modifier Donneur'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-red: #dc3545;
            --dark-red: #c82333;
            --light-red: #f8d7da;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }

        .sidebar {
            min-height: 100vh;
            background: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.05);
            border-right: 3px solid var(--primary-red);
        }

        .sidebar-header {
            padding: 30px 20px;
            background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
            border-bottom: 3px solid var(--dark-red);
        }

        .sidebar-logo {
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
            text-align: center;
            margin: 0;
        }

        .sidebar-logo i {
            font-size: 2rem;
            display: block;
            margin-bottom: 10px;
        }

        .sidebar .nav-link {
            color: #495057;
            padding: 15px 25px;
            margin: 8px 15px;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
            border-left: 3px solid transparent;
        }

        .sidebar .nav-link:hover {
            background-color: var(--light-red);
            color: var(--primary-red);
            border-left-color: var(--primary-red);
            transform: translateX(5px);
        }

        .sidebar .nav-link.active {
            background-color: var(--primary-red);
            color: white;
            border-left-color: var(--dark-red);
            box-shadow: 0 4px 10px rgba(220, 53, 69, 0.3);
        }

        .sidebar .nav-link i {
            width: 25px;
            text-align: center;
        }

        .main-content {
            background-color: white;
            min-height: 100vh;
            padding: 30px;
        }

        .page-header {
            border-bottom: 3px solid var(--primary-red);
            padding-bottom: 20px;
            margin-bottom: 30px;
        }

        .page-header h1 {
            color: var(--primary-red);
            font-weight: 700;
            font-size: 2rem;
        }

        .form-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .form-card .card-body {
            padding: 35px;
        }

        .section-title {
            color: var(--primary-red);
            font-weight: 600;
            font-size: 1.3rem;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--light-red);
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-red);
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.15);
        }

        .form-check-input:checked {
            background-color: var(--primary-red);
            border-color: var(--primary-red);
        }

        .form-check-input:focus {
            border-color: var(--primary-red);
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.15);
        }

        .form-check-label {
            font-weight: 500;
            color: #495057;
        }

        .btn-success {
            background: linear-gradient(135deg, #198754 0%, #146c43 100%);
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(25, 135, 84, 0.3);
        }

        .btn-secondary {
            background: #6c757d;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
        }

        .alert {
            border-radius: 10px;
            border: none;
            border-left: 4px solid;
        }

        .alert-success {
            background-color: #d1e7dd;
            border-left-color: #198754;
            color: #0f5132;
        }

        .alert-danger {
            background-color: var(--light-red);
            border-left-color: var(--primary-red);
            color: #842029;
        }

        .contraindications-section {
            background-color: #fff3cd;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #ffc107;
        }

        .contraindications-section h6 {
            color: #856404;
            font-weight: 600;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block sidebar p-0">
            <div class="sidebar-header">
                <h4 class="sidebar-logo">
                    <i class="fas fa-tint"></i>
                    Blood Bank
                </h4>
            </div>
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-2"></i> Accueil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/donors">
                            <i class="fas fa-user-plus me-2"></i> Donneurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/receivers">
                            <i class="fas fa-user-injured me-2"></i> Receveurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/matching?action=showMatching">
                            <i class="fas fa-handshake me-2"></i> Matching
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
            <div class="page-header">
                <h1><i class="fas fa-user-plus me-2"></i>${empty donor ? 'Nouveau Donneur' : 'Modifier Donneur'}</h1>
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

            <!-- Form -->
            <div class="form-card">
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/donors">
                        <c:if test="${not empty donor}">
                            <input type="hidden" name="id" value="${donor.id}">
                            <input type="hidden" name="action" value="update">
                        </c:if>
                        <c:if test="${empty donor}">
                            <input type="hidden" name="action" value="create">
                        </c:if>

                        <div class="row">
                            <div class="col-md-6">
                                <h5 class="section-title"><i class="fas fa-user me-2"></i>Informations Personnelles</h5>

                                <div class="mb-3">
                                    <label for="cin" class="form-label">CIN *</label>
                                    <input type="text" class="form-control" id="cin" name="cin"
                                           value="${donor.cin}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="firstName" class="form-label">Prénom *</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName"
                                           value="${donor.firstName}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="lastName" class="form-label">Nom *</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName"
                                           value="${donor.lastName}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="phone" class="form-label">Téléphone</label>
                                    <input type="tel" class="form-control" id="phone" name="phone"
                                           value="${donor.phone}">
                                </div>

                                <div class="mb-3">
                                    <label for="birthDate" class="form-label">Date de Naissance *</label>
                                    <input type="date" class="form-control" id="birthDate" name="birthDate"
                                           value="${donor.birthDate}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="weight" class="form-label">Poids (kg) *</label>
                                    <input type="number" step="0.1" class="form-control" id="weight" name="weight"
                                           value="${donor.weight}" required min="0">
                                </div>
                            </div>

                            <div class="col-md-6">
                                <h5 class="section-title"><i class="fas fa-heartbeat me-2"></i>Caractéristiques Médicales</h5>

                                <div class="mb-4">
                                    <label class="form-label">Sexe *</label>
                                    <div>
                                        <c:forEach var="gender" items="${genders}">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender"
                                                       id="gender${gender}" value="${gender}"
                                                       <c:if test="${donor.gender == gender}">checked</c:if> required>
                                                <label class="form-check-label" for="gender${gender}">
                                                        ${gender.displayName}
                                                </label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="bloodGroup" class="form-label">Groupe Sanguin *</label>
                                    <select class="form-select" id="bloodGroup" name="bloodGroup" required>
                                        <option value="">Sélectionnez un groupe</option>
                                        <c:forEach var="bloodGroup" items="${bloodGroups}">
                                            <option value="${bloodGroup}"
                                                    <c:if test="${donor.bloodGroup == bloodGroup}">selected</c:if>>
                                                    ${bloodGroup.displayName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="contraindications-section">
                                    <h6><i class="fas fa-exclamation-triangle me-2"></i>Contre-indications Médicales</h6>

                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="hasHepatitisB"
                                               name="hasHepatitisB" <c:if test="${donor.hasHepatitisB}">checked</c:if>>
                                        <label class="form-check-label" for="hasHepatitisB">
                                            Hépatite B
                                        </label>
                                    </div>

                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="hasHepatitisC"
                                               name="hasHepatitisC" <c:if test="${donor.hasHepatitisC}">checked</c:if>>
                                        <label class="form-check-label" for="hasHepatitisC">
                                            Hépatite C
                                        </label>
                                    </div>

                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="hasHIV"
                                               name="hasHIV" <c:if test="${donor.hasHIV}">checked</c:if>>
                                        <label class="form-check-label" for="hasHIV">
                                            VIH
                                        </label>
                                    </div>

                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="hasInsulinDiabetes"
                                               name="hasInsulinDiabetes" <c:if test="${donor.hasInsulinDiabetes}">checked</c:if>>
                                        <label class="form-check-label" for="hasInsulinDiabetes">
                                            Diabète insulinodépendant
                                        </label>
                                    </div>

                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="isPregnant"
                                               name="isPregnant" <c:if test="${donor.isPregnant}">checked</c:if>>
                                        <label class="form-check-label" for="isPregnant">
                                            Grossesse
                                        </label>
                                    </div>

                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="isBreastfeeding"
                                               name="isBreastfeeding" <c:if test="${donor.isBreastfeeding}">checked</c:if>>
                                        <label class="form-check-label" for="isBreastfeeding">
                                            Allaitement
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 pt-3 border-top">
                            <button type="submit" class="btn btn-success me-2">
                                <i class="fas fa-save me-2"></i>
                                ${empty donor ? 'Créer le donneur' : 'Modifier le donneur'}
                            </button>
                            <a href="${pageContext.request.contextPath}/donors" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-2"></i> Retour
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
