<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="utf-8">
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<title>혼밥말고 여러밥!</title>

			<!-- 무언가 추가하고 싶으면 여기에 추가해주세요!!! -->

			<!-- style.css -->
			<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
			<link href="${pageContext.request.contextPath}/css/userJoin.css" rel="stylesheet">
			<link href="${pageContext.request.contextPath}/css/userLogin.css" rel="stylesheet">
			<link href="${pageContext.request.contextPath}/css/reviewList.css" rel="stylesheet">

			<!-- bootstrap.css -->
			<link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.css" rel="stylesheet">
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

			<!-- JS -->
			<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.js"></script>

			<!-- favicon -->
			<link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">

		</head>

		<body>
			<header class="sticky-top">
				<div class="container border-bottom border-2 border-orange">
					<div class="inner-container d-flex justify-content-between">
						<!-- 로고 -->
						<a class="logo" href="${pageContext.request.contextPath}/"><img width="85"
								src="${pageContext.request.contextPath}/img/logo.png" alt="Yeoreobap"></a>


						<!-- 우측 상단 메뉴 -->
						<ul class="login-menu d-flex flex-nowrap align-items-end">
							<c:if test="${userInfo == null}">
								<li><a class="text-orange" href="${pageContext.request.contextPath}/user/userJoin">Join</a></li>
								<li><a class="text-orange" href="${pageContext.request.contextPath}/user/userLogin">Login</a></li>
							</c:if>
							<c:if test="${userInfo != null}">
								<li><span class="text-orange">${userInfo.userNick == null ? userInfo.userId : userInfo.userNick}님 환영합니다</span></li>
								<li><a class="text-orange" href="${pageContext.request.contextPath}/user/userMypage">MyPage</a></li>
								<li><a class="text-orange" href="${pageContext.request.contextPath}/user/userLogout">Logout</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</header>