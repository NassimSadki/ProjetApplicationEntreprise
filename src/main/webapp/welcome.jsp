<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Accueil</title>
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

			<f:form method="POST" action="welcome"
				modelAttribute="filtresCommercant">
				<fieldset>
					<legend>Rechercher des commerçants :</legend>
					<div class="mb-2">
						<label for="selectCategorieCommercant" class="form-label">Catégorie</label>
						<f:select path="categorie" id="selectCategorieCommercant"
							class="form-select">
							<f:option value="N'importe" />
							<c:forEach items="${CategorieCommercant}" var="cc">
								<f:option value="${cc.getCategorie()}" />
							</c:forEach>
						</f:select>
					</div>
					<div class="mb-2">
						<label for="selectLocalisationCommercant" class="form-label">Localisation</label>
						<f:select path="localisationCommercant"
							id="selectLocalisationCommercant" class="form-select">
							<f:option value="N'importe" />
							<c:forEach items="${Commercant}" var="c">
								<f:option value="${c.getLocalisation()}" />
							</c:forEach>
						</f:select>
					</div>
					<button type="submit" class="btn btn-primary" id="btnCommercant">Voir
						la liste</button>
				</fieldset>
			</f:form>
			<br />

			<table class="table">
				<thead>
					<tr>
						<th scope="col">n°</th>
						<th scope="col">Commercant</th>
						<th scope="col">Catégorie</th>
						<th scope="col">Localisation</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listeFiltreeCommercant}" var="c">
						<tr>
							<th scope="row">${c.getId()}</th>
							<td>${c.getNom()}</td>
							<td>${c.getCategorieCommercant().getCategorie()}</td>
							<td>${c.getLocalisation()}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<hr />

			<f:form method="POST" action="welcome" modelAttribute="filtresPanier">
				<fieldset>
					<legend>Rechercher des paniers :</legend>
					<div class="mb-3">
						<label for="selectCommercantPanier" class="form-label">Commerçant</label>
						<f:select path="commercant" id="selectCommercantPanier"
							class="form-select">
							<f:option value="N'importe" />
							<c:forEach items="${Panier}" var="p">
								<f:option value="${p.getCommercant().getNom()}" />
							</c:forEach>
						</f:select>
					</div>
					<div class="mb-3">
						<label for="selectCategoriePanier" class="form-label">Catégorie</label>
						<f:select path="categorie" id="selectCategoriePanier"
							class="form-select">
							<f:option value="N'importe" />
							<c:forEach items="${CategoriePanier}" var="cp">
								<f:option value="${cp.getCategorie()}" />/>
							</c:forEach>
						</f:select>
					</div>
					<div class="mb-3">
						<label for="selectLocalisationPanier" class="form-label">Localisation</label>
						<f:select path="localisationPanier" id="selectLocalisationPanier"
							class="form-select">
							<f:option value="N'importe" />
							<c:forEach items="${Panier}" var="p">
								<f:option value="${p.getCommercant().getLocalisation()}" />
							</c:forEach>
						</f:select>
					</div>
					<button type="submit" class="btn btn-primary" id="btnPanier">Voir
						la liste</button>
				</fieldset>
			</f:form>

			<br />

			<table class="table">
				<thead>
					<tr>
						<th scope="col">n°</th>
						<th scope="col">Panier</th>
						<th scope="col">Description</th>
						<th scope="col">Catégorie</th>
						<th scope="col">Commercant</th>
						<th scope="col">Localisation</th>
						<th scope="col">Prix</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody>

					<c:forEach items="${listeFiltreePanier}" var="p">
						<tr>
							<th scope="row">${p.getId()}</th>
							<td>${p.getNom()}</td>
							<td>${p.getDescription()}</td>
							<td>${p.getCategoriePanier().getCategorie()}</td>
							<td>${p.getCommercant().getNom()}</td>
							<td>${p.getCommercant().getLocalisation()}</td>
							<td>${p.getPrix()}€</td>
							<td>
								<form method="GET" action="/reserver/${p.getId()}">
									<button type="submit" class="btn btn-secondary">Réserver</button>
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