<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Bank Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-danger">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class="fas fa-tint"></i> Blood Bank Management
        </a>
    </div>
</nav>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-12 text-center">
            <h1>Bienvenue au Système de Gestion de Banque de Sang</h1>
            <p class="lead">Gérez les donneurs et receveurs efficacement</p>

            <div class="row mt-5">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Donneurs</h5>
                            <p class="card-text">Gérer les donneurs de sang</p>
                            <a href="${pageContext.request.contextPath}/donors" class="btn btn-danger">
                                <i class="fas fa-user-plus"></i> Voir les donneurs
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Receveurs</h5>
                            <p class="card-text">Gérer les receveurs de sang</p>
                            <a href="${pageContext.request.contextPath}/receivers" class="btn btn-primary">
                                <i class="fas fa-user-injured"></i> Voir les receveurs
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>