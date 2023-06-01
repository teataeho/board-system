<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/header.jsp"%>
<section>
<br><br><br><br><br>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 content-wrap">
				<div class="titlebox">
					<p>후기게시판</p>
				</div>

				<form action="${pageContext.request.contextPath}/review/reviewRegist"
					method="post">
					<table class="table">
						<tbody class="t-control">
							<tr>
								<td class="t-title">음식점 명</td>
								<td><input class="form-control input-sm" name="restId"></td>
							</tr>
							<tr>
								<td class="t-title">작성자</td>
								<td><input class="form-control input-sm" name="writer"></td>
							</tr>
							<tr>
								<td class="t-title">제목</td>
								<td><input class="form-control input-sm" name="title"></td>
							</tr>
							<tr>
								<td class="t-title">내용</td>
								<td><textarea class="form-control" rows="7" name="content"></textarea></td>
							</tr>
						</tbody>
					</table>
					
					<div class="titlefoot">
						<button class="btn" type="submit">등록</button>
						<button class="btn" type="button" onclick="location.href='${pageContext.request.contextPath}/review/reviewList'">목록</button>
					</div>
					
				</form>

			</div>
		</div>
	</div>
</section>
<%@ include file="../include/footer.jsp"%>