<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>
    <section>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-9 write-wrap">
                        <div class="titlebox">
                            <h2>수정하기</h2>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/review/update" method="post" name="updateForm">
                            <div class="form-group">
                                <p>후기 번호<span>|</span></p>
                                <input class="form-control" id="inputForm" name="reviewNo" value="${article.reviewNo}" readonly>
                            </div>
                            <div class="form-group">
                                <p>작성자<span>|</span></p>
                                <input class="form-control" id="inputForm" name="userNick" value="${article.userNick}" readonly>
                            </div>    
                            <div class="form-group">
                                <p>제목<span>|</span></p>
                                <input class="form-control" id="inputForm" name="title" value="${article.title}">
                            </div>
                            <input type="hidden" name="writer" value="${article.writer}">
                            <div class="form-group">
                                <p>내용<span>|</span></p>
                                <textarea class="form-control" id="inputForm" rows="10" name="content">${article.content}</textarea>
                            </div>
							<div class="modifyBtns">
	                            <button type="button" id="updateBtn" class="btn">변경</button>
	                            <button type="button" id="delBtn" class="btn">삭제</button>
	                            <button type="button" id="listBtn" class="btn">목록</button> 
                            </div>
                    </form>
                                    
                </div>
            </div>
        </div>
        </section>
<%@ include file="../include/footer.jsp" %>      


        <script>
            //목록 이동 처리
            document.getElementById('listBtn').onclick= function() {
                location.href="${pageContext.request.contextPath}/review/reviewList";
            }

            const $form = document.updateForm;

            //수정 버튼 이벤트 처리
            document.getElementById('updateBtn').onclick = function() {
                if ($form.title.value === '') {
                    alert('제목은 필수 항목입니다.');
                    $form.title.focus();
                    return;
                } else if ($form.content.value === '') {
                    alert('내용은 필수 항목입니다.');
                    $form.content.focus();
                    return;
                } else {
                    $form.submit();
                }
            }

            //삭제 버튼 이벤트 처리
            document.getElementById('delBtn').onclick = () => {
                if (confirm('정말 삭제하시겠습니까?')) {
                    $form.setAttribute('action', '${pageContext.request.contextPath}/review/delete');
                    $form.submit();
                }
            }
        </script>