<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/header.jsp"%>

<section>
<br><br><br><br><br>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 content-wrap" style="align-content: center;">
				<div class="titlebox">
					<p>후기게시판</p>
				</div>

				<form action="${pageContext.request.contextPath}/review/regist"
					method="post" name="reviewForm">
					<table class="table">
						<tbody class="t-control">
							<tr>
								<td class="t-title">작성자</td>
								<td><input class="form-control input-sm" value="${userInfo.userNick}" readonly></td>
							</tr>
							<tr>
								<td class="t-title">제목</td>
								<td><input class="form-control input-sm" name="title"></td>
							</tr>
							<tr>
								<td class="t-title">식당 이름</td>
								<td>
									<c:set var="party" value="${party}" />
									<c:set var="attendedParty" value="${attendedParty}" />
									<select name="sno" id="sno">
									  <c:forEach items="${party}" var="party" varStatus="status">
									    <option value="${party.sno}">${party.bplcNm}</option>
									  </c:forEach>
									  <c:forEach items="${attendedParty}" var="attendedParty" varStatus="status">
									    <option value="${attendedParty.sno}">${attendedParty.bplcNm}</option>
									  </c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td class="t-title">내용</td>
								<td><textarea class="form-control" rows="7" name="content"></textarea></td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" name="writer" id="userId" value="${userInfo.userId}">
					<div class="titlefoot">
						<button class="btn register" type="button">등록</button>
						<button class="btn" type="button" onclick="location.href='${pageContext.request.contextPath}/review/reviewList'">목록</button>
					</div>
					
				</form>

			</div>
		</div>
	</div>
</section>

<!-- 모달 -->
<div id="ratingModal" class="modal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">가게의 별점을 매겨주세요!</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="rating-stars">
            <span class="star" data-value="1"><i class="bi bi-star-fill"></i></span>
            <span class="star" data-value="2"><i class="bi bi-star-fill"></i></span>
            <span class="star" data-value="3"><i class="bi bi-star-fill"></i></span>
            <span class="star" data-value="4"><i class="bi bi-star-fill"></i></span>
            <span class="star" data-value="5"><i class="bi bi-star-fill"></i></span>
          </div>
        </div>
      </div>
    </div>
</div>

<%@ include file="../include/footer.jsp"%>

<script>
	var myModal = new bootstrap.Modal(document.getElementById("ratingModal"));
	
	document.querySelector('.register').addEventListener('click', () => {
		myModal.show();
	});

	const $stars = document.querySelectorAll("#ratingModal .rating-stars .star");
    let rating = 0;

    $stars.forEach(function(star) {
      star.addEventListener('click', function() {
        var starValue = parseInt(this.getAttribute('data-value'));
        rating = starValue;
        $stars.forEach(function(s, index) {
          if (index < starValue) {
            s.classList.add('active');
          } else {
            s.classList.remove('active');
          }
        });

        console.log('별점: ' + rating);

		if(!confirm('별점을 매기시겠습니까?')) {
			return;
		} else {
			fetch('${pageContext.request.contextPath}/star/insertStar', {
                    method: 'post',
                    headers: {
                        'Content-Type':'application/json'
                    },
                    body: JSON.stringify({
                        'userId' : document.getElementById('userId').value,
						'sno' : document.getElementById('sno').value,
						'starRate' : rating
                    })
            })
			.then(res => res.text())
			.then(text => {
				if(text !== 'success') {
					console.log(text);
				} else {
					document.reviewForm.submit();
				}
			});
		}
      });
    });
</script>