<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 메인 화면에서 여러밥 후기 목록 5개를 보여주기 위한 파일입니다 -->
			<thead>
				<tr>
					<th class="reviewNo">번호</th>
					<th id="board-title">제목</th>
					<th class="reviewWriter">작성자</th>
					<!-- <th>식당 이름</th> -->
					<th class="day">등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="re" items="${reviewList}">
					<tr>
						<td class="reviewNo">${re.reviewNo}</td>
						<td id="review-title">
							<div class="text-truncate">
								<a
									href="${pageContext.request.contextPath}/review/content/${re.reviewNo}">${re.title}</a>
							</div>
						</td>
						<td class="reviewWriter">${re.writer}</td>
						<!-- <td>${re.bplcNm}</td> -->
						<td class="day"><fmt:parseDate value="${re.regDate}"
								pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" /> <fmt:formatDate
								value="${parsedDateTime}" pattern="yy.MM.dd. HH:mm" /></td>
					</tr>
				</c:forEach>
			</tbody>