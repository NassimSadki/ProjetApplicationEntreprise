<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Mes réservations</title>
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
					<a class="navbar-brand" href="/welcome">Application anti-gaspillage</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#navbarNav" aria-controls="navbarNav"
						aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>

					<div class="collapse navbar-collapse" id="navbarNav">
						<ul class="navbar-nav me-auto mb-2 mb-lg-0">
							<li class="nav-item active"><a class="nav-link" href="/welcome">Accueil</a></li>
							<li class="nav-item"><f:form method="POST"
									id="mesReservationsForm" action="/mesreservations"
									modelAttribute="formulaireReservation">
									<f:input path="user" type="hidden"
										value="${pageContext.request.userPrincipal.name}"></f:input>
									<a class="nav-link" href="javascript:{}"
										onclick="document.forms['mesReservationsForm'].submit()">
										Mes réservations</a>
								</f:form></li>
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
			
			<p class="fs-5">Liste des paniers que vous avez réservé : </p>
			<br />
			<table class="table">
				<thead>
					<tr>
						<th scope="col">Panier</th>
						<th scope="col">Description</th>
						<th scope="col">Categorie</th>
						<th scope="col">Commercant</th>
						<th scope="col">Localisation</th>
						<th scope="col">Prix</th>
						<th scope="col">Date de récupération prévue</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listeReservation}" var="r">
						<tr>
							<td>${r.getPanier().getNom()}</td>
							<td>${r.getPanier().getDescription()}</td>
							<td>${r.getPanier().getCategoriePanier().getCategorie()}</td>
							<td>${r.getPanier().getCommercant().getNom()}</td>
							<td>${r.getPanier().getCommercant().getLocalisation()}</td>
							<td>${r.getPanier().getPrix()}€</td>
							<td>${r.getDateTime()}</td>
							<td>
								<form method="GET" action="annuler/reservation/${r.getId()}">
									<button type="submit" class="btn btn-secondary" onClick="return confirm('Êtes-vous sûr de vouloir annuler la réservation de ce panier ?')">Annuler</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>