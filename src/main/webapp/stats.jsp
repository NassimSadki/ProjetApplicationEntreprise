<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Statistiques</title>
<link href="${contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container">
		<c:if test="${pageContext.request.userPrincipal.name != null}">
			<form id="logoutForm" method="POST" action="${contextPath}/logout">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>

			<nav class="navbar navbar-expand-lg navbar-light"
				style="background-color: #e3f2fd;">
				<div class="container">
					<a class="navbar-brand" href="/admin">Application
						anti-gaspillage</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#navbarNav" aria-controls="navbarNav"
						aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>

					<div class="collapse navbar-collapse" id="navbarNav">
						<ul class="navbar-nav me-auto mb-2 mb-lg-0">
							<li class="nav-item"><a class="nav-link"
								href="/admin">Espace admin</a></li>
							<li class="nav-item active"><a class="nav-link" href="/admin/stats">Statistiques</a></li>
						</ul>

						<div class="d-flex align-items-center">
							<ul class="navbar-nav me-auto mb-2 mb-lg-0">
								<li class="nav-item"><span class="nav-link">Connecté
										en tant que ${pageContext.request.userPrincipal.name}</span></li>
								<li class="nav-item"><button type="button"
										class="btn btn-primary px-3 me-2"
										onclick="document.forms['logoutForm'].submit()">Se
										déconnecter</button></li>
							</ul>
						</div>
					</div>
				</div>
			</nav>

			<br />

			<h5>Espace Admin</h5>

			<br />
			
			<p class="fs-5">Statistiques</p>
			<br />
			<p class="fs-6">Nombre d'utilisateurs inscrits : ${nombreUser}</p>
			<p class="fs-6">Nombre de commercants : ${nombreCommercant}</p>
			<p class="fs-6">Nombre de paniers proposés actuellement : ${nombrePanier}</p>
			<p class="fs-6">Nombre de paniers réservés : ${nombrePanierReserve}</p>


		</c:if>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>