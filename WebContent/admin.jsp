<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="language"
	value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}"
	scope="session" />

<fmt:setLocale value="${language}" />
<fmt:bundle basename="app">
	<html lang="${language}">
	<html>
<head>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/navbar.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Administrative</title>
<link rel='stylesheet prefetch'
	href='http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css'>

</head>
<body>
	<nav class="navbar navbar-dark bg-mint sticky-top flex-md-nowrap p-0">
		<a class="navbar-brand col-sm-2 col-md-1 mr-0">DropPod</a>


		<form class="form-inline my-2 my-lg-0" action="setLanguageServlet"
			method="get">

			<div class="nav-item dropdown" role="group">
				<select class="btn dropdown-toggle btn-outline-dark"
					aria-labelledby="btnGroupDrop1" id="language" name="language"
					onchange="submit()">
					<option class="dropdown-item" value="en"
						${language == 'en' ? 'selected' : ''}>English</option>
					<option class="dropdown-item" value="fr"
						${language == 'fr' ? 'selected' : ''}>Français</option>
				</select>
			</div>

		</form>

		<form class="form-inline w-100 my-2 my-lg-0" action="searchResult"
			method="get">
			<input class="form-control form-control-mint w-100" type="text"
				name="search" placeholder="<fmt:message key="search.search" />"
				aria-label="Search">
		</form>
		<ul class="navbar-nav px-3">
			<li class="nav-item text-nowrap"><a class="nav-link"
				href="${pageContext.request.contextPath}/logout"><fmt:message
						key="welcome.signout" /></a></li>
		</ul>
	</nav>

	<div class="container-fluid">
		<div class="row no-gutter">
			<nav class="col-md-2 sidebar">
				<div class="sidebar-sticky">
					<ul class="nav flex-column">
						<li class="nav-item"><a class="nav-link" href="#"> <span
								data-feather="user"></span> <fmt:message
									key="welcome.signedinas" />: ${sessionScope.name}
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/welcome.jsp"> <span
								data-feather="cast"></span> <fmt:message key="welcome.casts" />
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/following.jsp"> <span
								data-feather="users"></span> <fmt:message
									key="welcome.following" />
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/popularPodcasts"> <span
								data-feather="globe"></span> <fmt:message key="welcome.popular" />
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/addPodcast.jsp"> <span
								data-feather="plus-square"></span> <fmt:message
									key="welcome.addapodcast" />
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/recommended.jsp"> <span
								data-feather="user-check"></span>
							<fmt:message key="welcome.recommended" />
						</a></li>
						<c:if test="${sessionScope.accessLevel == \"1\"}">
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/admin.jsp"> <span
									data-feather="shield"></span> <fmt:message key="welcome.admin" />
							</a></li>
						</c:if>
					</ul>
				</div>
			</nav>
		</div>
	</div>
	<div role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<div class="border-bottom mb-3">
			<h3>
				<fmt:message key="welcome.admin" />
			</h3>
		</div>
		<form action="userSearch" method="post">
			<div class="form-group">
				<input type="text" class="form-control" name="username"
					id="username" placeholder="<fmt:message key="admin.userSearch" />" />
			</div>
			<!--<input type="submit" class="btn btn-success"
				value="<fmt:message key="admin.search" />" /> -->
		</form>
		<c:if test="${not empty user}">
			<div class="col-sm-6">
				<form action="userEdit" method="post">
					<div class="form-group">
						<label for="id"><fmt:message key="admin.ID" /></label> <input
							type="text" class="form-control" value="${user.id}" name="id"
							id="id" readonly>
					</div>
					<div class="form-group">
						<label for="name"><fmt:message key="admin.username" /></label> <input
							type="text" class="form-control" value="${user.name}" id="name"
							readonly>
					</div>
					<div class="form-group">
						<label for="email"><fmt:message key="admin.email" /></label> <input
							type="text" class="form-control" value="${user.email}" id="email"
							readonly>
					</div>
					<div class="form-group">
						<label for="active"><fmt:message key="admin.active" /></label> 
						<select class="form-control" name="account_type_id" id="account_type_id">
							<c:if test="${user.activeStatus == 0}">
							<option value="0">Active</option>
							<option value="1">Disabled</option>
							</c:if>
							<c:if test="${user.activeStatus == 1}">
							<option value="1">Disabled</option>
							<option value="0">Active</option>
							</c:if>
						</select>
					</div>
					<div class="form-group">
						<label for="account_type_id"><fmt:message key="admin.accountlevel" /></label>
						<select class="form-control" name="account_type_id" id="account_type_id">
							<c:if test="${user.accountType == 0}">
							<option value="0">General User</option>
							<option value="1">Admin User</option>
							</c:if>
							<c:if test="${user.accountType == 1}">
							<option value="1">Admin User</option>
							<option value="0">General User</option>
							</c:if>
						</select>
					</div>

					<button type="submit" class="btn btn-info">
						<fmt:message key="admin.save" />
					</button>
				</form>
			</div>
		</c:if>

		<c:if test="${not empty users}">
			<div class="table-responsive">
				<table class="table">
					<tr>
						<th><fmt:message key="admin.ID" /></th>
						<th><fmt:message key="admin.username" /></th>
						<th><fmt:message key="admin.email" /></th>
						<th><fmt:message key="admin.active" /></th>
						<th><fmt:message key="admin.accountlevel" /></th>
						<th><fmt:message key="admin.action" /></th>
					</tr>
					<c:forEach var="user" items="${users}">
						<tr>
							<td>${user.id}</td>
							<td>${user.name}</td>
							<td>${user.email}</td>
							<td><c:if test="${user.activeStatus == 0}">Active</c:if><c:if test="${user.activeStatus == 1}">Disabled</c:if></td>
							<td><c:if test="${user.accountType == 0}">General User</c:if><c:if test="${user.accountType == 1}">Admin User</c:if></td>
							<td>
								<form action="userSearch" method="post"
									style="padding: 0; margin: 0;">
									<input type="hidden" value="${user.id}" name="id" id="id">
									<button type="submit" class="btn btn-info btn-sm">
										<fmt:message key="admin.edit" />
									</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</c:if>
	</div>


	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
	<script>
		feather.replace()
	</script>
	<script src="js/welcome.js"></script>
</body>
</body>
</fmt:bundle>
</html>