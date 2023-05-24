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
</head>


<body>

    <div class="wrape">

        <div class="container">
            <!--section main-->
            <section class="main">
                <ul class="slide">
                    <img src="${pageContext.request.contextPath }/img/logo.png" alt="메인 이미지1">
                </ul>
            </section>
            <!--end section main-->

            <!--section about-->
            <div class="mainArea">
                <div class="boardArea">
                    <a href="#">파티모집</a>
                    <div class="hotParty">
                        <table class="partyTable">
                            <tr>
                                <th>현재 핫!한 동행!</th>
                            </tr>
                            <tr>
                                <td>
                                    <div class="">
                                        <a href="#">img</a>
                                    </div>
                                    <div></div>
                                </td>
                            </tr>
                        </table>
                        <table class="partyTable">
                            <tr>
                                <th>마감이 임박한 동행!</th>
                            </tr>
                            <tr>
                                <td>
                                    <div class="">
                                        <a href="#">img</a>
                                    </div>
                                    <div></div>
                                </td>
                            </tr>
                        </table>
                        <table class="partyTable">
                            <tr>
                                <th>우리 동네랑 가까운 동행!</th>
                            </tr>
                            <tr>
                                <td>
                                    <div class="">
                                        <a href="#">img</a>
                                    </div>
                                    <div></div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    
                </div>                
            </div>
            <!--end section.mainArea-->
        </div>
    </div>

</body>
