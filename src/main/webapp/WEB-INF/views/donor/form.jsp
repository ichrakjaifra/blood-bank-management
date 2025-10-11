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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/donors">
                            <i class="fas fa-user-plus me-2"></i> Donneurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/receivers">
                            <i class="fas fa-user-injured me-2"></i> Receveurs
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2 text-dark">${empty donor ? 'Nouveau Donneur' : 'Modifier Donneur'}</h1>
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

            <!-- محتوى الفورم -->
            <div class="card">
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
                                <h5>Informations Personnelles</h5>

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
                                <h5>Caractéristiques Médicales</h5>

                                <div class="mb-3">
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

                                <div class="mb-3">
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

                                <h6 class="mt-4">Contre-indications Médicales</h6>

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

                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" id="isBreastfeeding"
                                           name="isBreastfeeding" <c:if test="${donor.isBreastfeeding}">checked</c:if>>
                                    <label class="form-check-label" for="isBreastfeeding">
                                        Allaitement
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i>
                                ${empty donor ? 'Créer le donneur' : 'Modifier le donneur'}
                            </button>
                            <a href="${pageContext.request.contextPath}/donors" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Retour
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