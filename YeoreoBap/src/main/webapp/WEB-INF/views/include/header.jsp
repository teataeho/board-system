<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>혼밥 말고 여러밥!</title>

            <link href="${pageContext.request.contextPath }/css/bootstrap.css" rel="stylesheet">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
            <!--개인 디자인 추가-->
            <link href="${pageContext.request.contextPath }/css/header.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath }/css/style.css" rel="stylesheet">
            <script src="${pageContext.request.contextPath }/js/bootstrap.js"></script>
        </head>

        <body>
            <header>
                <div class="container">

                    <a class="logo" href="#"><img width="100" src="${pageContext.request.contextPath }/img/logo.png"
                            alt="Brand"></a>
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

            </header>