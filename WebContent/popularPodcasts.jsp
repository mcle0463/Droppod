<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="language"
	value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}"
	scope="session" />
<fmt:setLocale value="${language}" />
<fmt:bundle basename="app">
	<html lang="${language}">
<head>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/navbar.css">

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title><fmt:message key="welcome.addapodcast" /></title>
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
									key="welcome.signedinas" />: <%=session.getAttribute("name")%>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/welcome.jsp"> <span
								data-feather="cast"></span> <fmt:message key="welcome.casts" />
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/following.jsp"> <span
								data-feather="users"></span>
							<fmt:message key="welcome.following" />
						</a></li>
						<li class="nav-item"><a class="nav-link active"
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
					</ul>
				</div>
			</nav>
		</div>
	</div>



	<div role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h2>
			<fmt:message key="popular.popular" />
		</h2>
		<p>
			<fmt:message key="popular.piya" />
			${area}
		</p>
		<table class="table table-striped">
			<thead>
				<tr>
					<th><fmt:message key="popular.podcast" /></th>
					<th><fmt:message key="popular.listeners" /></th>
					<th><fmt:message key="popular.description" /></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="podresult" items="${search}">
					<tr>
						<td>${podresult.name}</td>
						<td>${podresult.subscriptions}</td>
						<td>${podresult.description}</td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
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
</fmt:bundle>
</html>