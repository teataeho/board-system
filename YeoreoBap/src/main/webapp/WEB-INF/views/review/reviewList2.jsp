<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 메인 화면에서 여러밥 후기 목록 5개를 보여주기 위한 파일입니다 -->
<section>
	<form action="<c:url value='/review/reviewList2' />">
		<table class="table table-bordered table-hover" id="table">
			<thead>
				<tr>
					<th class="reviewNo">리뷰 번호</th>
					<th id="board-title">제목</th>
					<th class="reviewWriter">작성자</th>
					<th>식당 이름</th>
					<th class="day">등록일</th>
					<th class="day">수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${reviewList}">
					<tr>
						<td class="reviewNo">${vo.reviewNo}</td>
						<td id="review-title">
							<div class="text-truncate">
								<a
									href="${pageContext.request.contextPath}/review/content/${vo.reviewNo}">${vo.title}</a>
							</div>
						</td>
						<td class="reviewWriter">${vo.userNick}</td>
						<td>${vo.bplcNm}</td>
						<td class="day"><fmt:parseDate value="${vo.regDate}"
								pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" /> <fmt:formatDate
								value="${parsedDateTime}" pattern="yy.MM.dd. HH:mm" /></td>
						<td class="day"><fmt:parseDate value="${vo.updateDate}"
								pattern="yyyy-MM-dd'T'HH:mm" var="parsedUpdateDateTime" /> <fmt:formatDate
								value="${parsedUpdateDateTime}" pattern="yy.MM.dd. HH:mm" /></td>
					</tr>
				</c:forEach>
			</tbody>

		</table>

	</form>
</section>