<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Espace admin</title>
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
							<li class="nav-item active"><a class="nav-link"
								href="/admin">Espace admin</a></li>
							<li class="nav-item"><a class="nav-link" href="/admin/stats">Statistiques</a></li>
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

			<h6>Liste des commercants :</h6>

			<table class="table">
				<thead>
					<tr>
						<th scope="col">n°</th>
						<th scope="col">Commercant</th>
						<th scope="col">Catégorie</th>
						<th scope="col">Localisation</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listeCommercant}" var="c">
						<tr>
							<th scope="row">${c.getId()}</th>
							<td>${c.getNom()}</td>
							<td>${c.getCategorieCommercant().getCategorie()}</td>
							<td>${c.getLocalisation()}</td>
							<td>
								<form method="GET"
									action="/admin/supprimer/commercant/${c.getId()}">
									<button type="submit" class="btn btn-secondary"
										onClick="return confirm('Êtes-vous sûr de vouloir supprimer ce commercant, ses paniers et leurs réservations ?')">Supprimer</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<h6>Ajouter un commercant :</h6>
			<f:form method="POST" modelAttribute="ajouterCommercant"
				action="/admin/ajouter/commercant">
				<label for="inputNom" class="form-label">Nom</label>
				<f:input type="text" path="nom" id="inputNom" class="form-control" />
				<label for="selectCategorieCommercant" class="form-label">Catégorie</label>
				<f:select path="categorie" id="selectCategorieCommercant"
					class="form-select">
					<c:forEach items="${categorieCommercant}" var="cc">
						<f:option value="${cc.getCategorie()}" />
					</c:forEach>
				</f:select>
				<label for="inputLocalisation" class="form-label">Localisation</label>
				<f:input type="text" path="localisation" id="inputLocalisation"
					class="form-control" />
				<br />
				<button type="submit" class="btn btn-primary" id="btnAddCommercant">Ajouter</button>
			</f:form>

			<br />
			<hr />

			<h6>Liste des paniers :</h6>

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

					<c:forEach items="${listePanier}" var="p">
						<tr>
							<th scope="row">${p.getId()}</th>
							<td>${p.getNom()}</td>
							<td>${p.getDescription()}</td>
							<td>${p.getCategoriePanier().getCategorie()}</td>
							<td>${p.getCommercant().getNom()}</td>
							<td>${p.getCommercant().getLocalisation()}</td>
							<td>${p.getPrix()}€</td>
							<td>
								<form method="GET" action="/admin/supprimer/panier/${p.getId()}">
									<button type="submit" class="btn btn-secondary"
										onClick="return confirm('Êtes-vous sûr de vouloir supprimer ce panier ?')">Supprimer</button>
								</form>
							</td>
						</tr>

					</c:forEach>

				</tbody>
			</table>

			<h6>Ajouter un panier :</h6>
			<f:form method="POST" modelAttribute="ajouterPanier"
				action="/admin/ajouter/panier">
				<label for="inputNom" class="form-label">Nom</label>
				<f:input type="text" path="nom" id="inputNom" class="form-control" />
				<label for="inputDescription" class="form-label">Description</label>
				<f:input type="text" path="description" id="inputDescription"
					class="form-control" />
				<label for="inputPrix" class="form-label">Prix</label>
				<f:input type="number" path="prix" id="inputPrix"
					class="form-control" />
				<label for="selectCategoriePanier" class="form-label">Catégorie</label>
				<f:select path="categorie" id="selectCategoriePanier"
					class="form-select">
					<c:forEach items="${categoriePanier}" var="cp">
						<f:option value="${cp.getCategorie()}" />
					</c:forEach>
				</f:select>
				<label for="selectCommercantPanier" class="form-label">Commercant</label>
				<f:select path="commercant" id="selectCommercantPanier"
					class="form-select">
					<c:forEach items="${listeCommercant}" var="c">
						<f:option value="${c.getNom()}" />
					</c:forEach>
				</f:select>

				<br />
				<button type="submit" class="btn btn-primary" id="btnAddPanier">Ajouter</button>
			</f:form>



		</c:if>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>