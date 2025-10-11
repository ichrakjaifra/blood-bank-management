<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank Management - ${empty receiver ? 'Nouveau Receveur' : 'Modifier Receveur'}</title>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/donors">
                            <i class="fas fa-user-plus me-2"></i> Donneurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/receivers">
                            <i class="fas fa-user-injured me-2"></i> Receveurs
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2 text-dark">${empty receiver ? 'Nouveau Receveur' : 'Modifier Receveur'}</h1>
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
                                <h5>Informations Personnelles</h5>

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
                                <h5>Informations Médicales</h5>

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
                                    <div class="alert alert-info">
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
                                <i class="fas fa-save"></i>
                                ${empty receiver ? 'Créer le receveur' : 'Modifier le receveur'}
                            </button>
                            <a href="${pageContext.request.contextPath}/receivers" class="btn btn-secondary">
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