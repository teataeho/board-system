<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="utf-8">
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<title>혼밥말고 여러밥!</title>

			<!-- style.css -->
			<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
			<link href="${pageContext.request.contextPath}/css/userJoin.css" rel="stylesheet">

			<!-- bootstrap.css -->
			<link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.css" rel="stylesheet">
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

			<!-- JS -->
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>

			<!-- favicon -->
			<link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">

		</head>

		<body>
			<header>
				<div class="container">
					<div class="inner-container">
						<!-- 로고 -->
						<a class="logo" href="${pageContext.request.contextPath}/"><img width="85"
								src="${pageContext.request.contextPath}/img/logo.png" alt="Yeoreobap"></a>

						<!-- 우측 상단 메뉴 -->
						<ul class="login-menu">
							<c:if test="${login == null}">
								<li><a href="${pageContext.request.contextPath}/user/userJoin">Join</a></li>
								<li><a href="${pageContext.request.contextPath}/user/userLogin">Login</a></li>
							</c:if>
							<c:if test="${login != null}">
								<li><a href="${pageContext.request.contextPath}/user/userMypage">MyPage</a></li>
								<li><a href="${pageContext.request.contextPath}/user/userLogout">Logout</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</header>
		</body>