<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/header.jsp"%>

<section>
	<div class="container-fluid">
		<div class="row">
			<!--lg에서 9그리드, xs에서 전체그리드-->
			<div class="col-lg-9 col-xs-12 board-table">
				<div class="titlebox">
					<p>후기 게시판</p>
				</div>
				<hr>

				<!--form select를 가져온다 -->
				<form action="<c:url value='/review/reviewList' />">
					<div class="search-wrap">
						<button type="submit" class="btn btn-info search-btn">검색</button>
						<input type="text" name="keyword"
							class="form-control search-input" value="${pc.paging.keyword}">
						<select name="condition" class="form-control search-select">
							<option value="title"
								${pc.paging.condition == 'title' ? 'selected' : ''}>제목</option>
							<option value="content"
								${pc.paging.condition == 'content' ? 'selected' : ''}>내용</option>
							<option value="writer"
								${pc.paging.condition == 'writer' ? 'selected' : ''}>작성자</option>
							<option value="titleContent"
								${pc.paging.condition == 'titleContent' ? 'selected' : ''}>제목+내용</option>
						</select>
					</div>
				</form>

				<table class="table table-bordered">
					<thead>
						<tr>
							<th>번호</th>
							<th class="board-title">제목</th>
							<th>작성자</th>
							<th>등록일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="vo" items="${reviewList}">
							<%-- <tr>
								<td>${vo.review_no}</td>
								<td><a
									href="${pageContext.request.contextPath}/reviewList/content/${vo.review_no}?pageNum=${pc.paging.pageNum}&cpp=${pc.paging.cpp}&keyword=${pc.paging.keyword}&condition=${pc.paging.condition}">${vo.title}</a>
								</td>
								<td>${vo.writer}</td>
								<td><fmt:parseDate value="${vo.regDate}"
										pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime"
										type="both" /> <fmt:formatDate value="${parsedDateTime}"
										pattern="yyyy년 MM월 dd일 HH시 mm분" /></td>
								<td><fmt:parseDate value="${vo.updateDate}"
										pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedUpdateTime"
										type="both" /> <fmt:formatDate value="${parsedUpdateTime}"
										pattern="yyyy년 MM월 dd일 HH시 mm분" /></td>
							</tr> --%>
						</c:forEach>
					</tbody>

				</table>


				<!--페이지 네이션을 가져옴-->
				<form action="${pageContext.request.contextPath}/review/reviewList"
					name="pageForm">
					<div class="text-center">
						<hr>
						<ul id="pagination" class="pagination pagination-sm">
							<c:if test="${pc.prev}">
								<li><a href="#" data-pagenum="${pc.beginPage-1}">이전</a></li>
							</c:if>

							<c:forEach var="num" begin="${pc.beginPage}" end="${pc.endPage}">
								<li class="${pc.paging.pageNum == num ? 'active' : ''}"><a
									href="#" data-pagenum="${num}">${num}</a></li>
							</c:forEach>

							<c:if test="${pc.next}">
								<li><a href="#" data-pagenum="${pc.endPage+1}">다음</a></li>
							</c:if>
						</ul>
						<button type="button" class="btn btn-info"
							onclick="location.href='${pageContext.request.contextPath}/review/reviewRegist'">글쓰기</button>
					</div>

					<input type="hidden" name="pageNum" value="${pc.paging.pageNum}">
					<input type="hidden" name="cpp" value="${pc.paging.cpp}"> <input
						type="hidden" name="keyword" value="${pc.paging.keyword}">
					<input type="hidden" name="condition"
						value="${pc.paging.condition}">

				</form>

			</div>
		</div>
	</div>
</section>

<%@ include file="../../include/footer.jsp"%>

<script>

   
    window.onload = function() {

   
        document.getElementById('pagination').addEventListener('click', e => {
            if(!e.target.matches('a')) {
                return;
            }

            e.preventDefault(); 

            
            const value = e.target.dataset.pagenum;

            document.pageForm.pageNum.value = value;
            document.pageForm.submit();

        });

    }

</script>