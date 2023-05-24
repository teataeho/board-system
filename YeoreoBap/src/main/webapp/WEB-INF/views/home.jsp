<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ include file="include/header.jsp" %>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <!-- reset css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
	<!-- css 디자인 -->
	<link href="${pageContext.request.contextPath }/css/style.css" rel="stylesheet">

</head>


<body>

    <div class="wrap">

        <div class="container">
            <!--section main-->
            <section class="main">
                <ul class="slide">
                    <img src="${pageContext.request.contextPath }/img/carousel.png" alt="메인 이미지1">
                </ul>
            </section>
            <!--end section main-->

            <!--section about-->
            <div class="mainArea">
                <div class="boardMenu">
                	<p>파티 모집<a href="#">더보기 ></a></p>
                    <p>Hot</p>
                    <p>마감 임박!</p>
                    <span>시간</span>
                </div>               
                
                <ul class="party">
                    <li><img src="#" alt="party1"><span></span></li>
                </ul>
                
            </div>
            <!--end section.mainArea-->
        </div>
    </div>

</body>
