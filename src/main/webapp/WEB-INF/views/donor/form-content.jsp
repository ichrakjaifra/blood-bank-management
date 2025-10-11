<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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