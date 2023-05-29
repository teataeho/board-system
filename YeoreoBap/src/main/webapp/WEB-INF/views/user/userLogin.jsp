<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ include file="../include/header.jsp" %> --%>

<div class="login">
	<h2 class="title">로그인</h2>
	<form action="" method="POST">
		<div class="border"><input type="text" class="form-id" name="userId" id="userId" placeholder="아이디"
				autocomplete="off">
		</div>
		<div class="border"><input type="password" class="form-pw" name="userPw" id="userPw" placeholder="비밀번호">
		</div>
		<button type="button" id="loginBtn">Login</button>
	</form>
</div>

<%-- <%@ include file="../include/footer.jsp" %> --%>
