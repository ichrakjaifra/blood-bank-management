<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row">
    <div class="col-md-3">
        <div class="card text-white bg-primary mb-3">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4>${donorsCount}</h4>
                        <p>Donneurs Total</p>
                    </div>
                    <i class="fas fa-user-plus fa-2x"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-success mb-3">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4>${availableDonorsCount}</h4>
                        <p>Donneurs Disponibles</p>
                    </div>
                    <i class="fas fa-check-circle fa-2x"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-warning mb-3">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4>${waitingReceiversCount}</h4>
                        <p>Receveurs en Attente</p>
                    </div>
                    <i class="fas fa-clock fa-2x"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-info mb-3">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4>${satisfiedReceiversCount}</h4>
                        <p>Receveurs Satisfaits</p>
                    </div>
                    <i class="fas fa-heart fa-2x"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5>Actions Rapides</h5>
            </div>
            <div class="card-body">
                <div class="d-grid gap-2">
                    <a href="${pageContext.request.contextPath}/donors?action=new"
                       class="btn btn-danger">
                        <i class="fas fa-plus"></i> Nouveau Donneur
                    </a>
                    <a href="${pageContext.request.contextPath}/receivers?action=new"
                       class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouveau Receveur
                    </a>
                    <a href="${pageContext.request.contextPath}/donors"
                       class="btn btn-outline-danger">
                        <i class="fas fa-list"></i> Voir tous les Donneurs
                    </a>
                    <a href="${pageContext.request.contextPath}/receivers"
                       class="btn btn-outline-primary">
                        <i class="fas fa-list"></i> Voir tous les Receveurs
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5>Statistiques</h5>
            </div>
            <div class="card-body">
                <p>Dons réalisés aujourd'hui: <strong>${todayDonations}</strong></p>
                <p>Receveurs satisfaits: <strong>${satisfiedReceiversCount}</strong></p>
                <p>Taux de compatibilité: <strong>${compatibilityRate}%</strong></p>
                <p>Donneurs disponibles: <strong>${availableDonorsCount}/${donorsCount}</strong></p>
            </div>
        </div>
    </div>
</div>