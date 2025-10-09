<div class="d-flex justify-content-between mb-3">
    <h3>Liste des Donneurs</h3>
    <a href="${pageContext.request.contextPath}/donors?action=new" class="btn btn-danger">
        <i class="fas fa-plus"></i> Nouveau Donneur
    </a>
</div>

<div class="card">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                <tr>
                    <th>CIN</th>
                    <th>Nom Complet</th>
                    <th>Téléphone</th>
                    <th>Âge</th>
                    <th>Groupe Sanguin</th>
                    <th>Poids</th>
                    <th>Statut</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="donor" items="${donors}">
                    <tr>
                        <td><c:out value="${donor.cin}" /></td>
                        <td><c:out value="${donor.fullName}" /></td>
                        <td><c:out value="${donor.phone}" /></td>
                        <td>${donor.age} ans</td>
                        <td>
                                <span class="badge blood-badge bg-danger">
                                        ${donor.bloodGroup.displayName}
                                </span>
                        </td>
                        <td>${donor.weight} kg</td>
                        <td>
                            <c:choose>
                                <c:when test="${donor.status == 'DISPONIBLE'}">
                                    <span class="badge bg-success">Disponible</span>
                                </c:when>
                                <c:when test="${donor.status == 'NON_DISPONIBLE'}">
                                    <span class="badge bg-warning">Non Disponible</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger">Non Éligible</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="btn-group btn-group-sm">
                                <a href="${pageContext.request.contextPath}/donors?action=edit&id=${donor.id}"
                                   class="btn btn-outline-primary">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/donors?action=delete&id=${donor.id}"
                                   class="btn btn-outline-danger"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce donneur?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>