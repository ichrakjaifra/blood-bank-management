<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${empty receiver ? 'Nouveau Receveur' : 'Modifier Receveur'}" />
<c:set var="content" value="receiver/form-content.jsp" />
<jsp:include page="../template.jsp" />