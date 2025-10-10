<div class="d-flex justify-content-between mb-3">
    <h3>Liste des Receveurs</h3>
    <a href="${pageContext.request.contextPath}/receivers?action=new" class="btn btn-primary">
        <i class="fas fa-plus"></i> Nouveau Receveur
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
                    <th>Urgence</th>
                    <th>Statut</th>
                    <th>Progression</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="receiver" items="${receivers}">
                    <tr>
                        <td><c:out value="${receiver.cin}" /></td>
                        <td><c:out value="${receiver.fullName}" /></td>
                        <td><c:out value="${receiver.phone}" /></td>
                        <td>${receiver.age} ans</td>
                        <td>
                                <span class="badge blood-badge bg-danger">
                                        ${receiver.bloodGroup.displayName}
                                </span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">
                                    <span class="badge bg-danger">CRITIQUE</span>
                                </c:when>
                                <c:when test="${receiver.medicalUrgency == 'URGENT'}">
                                    <span class="badge bg-warning">URGENT</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-info">NORMAL</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${receiver.status == 'SATISFAIT'}">
                                    <span class="badge bg-success">SATISFAIT</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">EN ATTENTE</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="progress" style="height: 20px;">
                                <div class="progress-bar
                                        <c:choose>
                                            <c:when test="${receiver.medicalUrgency == 'CRITIQUE'}">bg-danger</c:when>
                                            <c:when test="${receiver.medicalUrgency == 'URGENT'}">bg-warning</c:when>
                                            <c:otherwise>bg-info</c:otherwise>
                                        </c:choose>"
                                     role="progressbar"
                                     style="width: ${(receiver.currentDonationCount / receiver.requiredDonationCount) * 100}%">
                                        ${receiver.currentDonationCount}/${receiver.requiredDonationCount}
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="btn-group btn-group-sm">
                                <a href="${pageContext.request.contextPath}/receivers?action=edit&id=${receiver.id}"
                                   class="btn btn-outline-primary">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/receivers?action=delete&id=${receiver.id}"
                                   class="btn btn-outline-danger"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce receveur?')">
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