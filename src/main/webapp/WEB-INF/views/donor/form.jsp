<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${empty donor ? 'Nouveau Donneur' : 'Modifier Donneur'}" />
<c:set var="content" value="donor/form-content.jsp" />
<jsp:include page="../template.jsp" />