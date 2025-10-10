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