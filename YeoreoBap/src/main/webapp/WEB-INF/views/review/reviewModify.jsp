<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../include/header.jsp" %>
    <section>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-9 write-wrap">
                        <div class="titlebox">
                            <h2>수정하기</h2>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/review/update" method="post" name="updateForm">
                            <input type="hidden" name="reviewNo" value="${article.reviewNo}" />
                            <div class="form-group modify-form-group">
                                <p>작성자<span>|</span></p>
                                <input class="form-control modify-form-control" maxlength='20' id="inputForm" name="userNick" value="${article.writer}" readonly>
                            </div>    
                            <div class="form-group modify-form-group">
                                <p>제목<span>|</span></p>
                                <input class="form-control modify-form-control" maxlength='100' id="inputForm" name="title" value="${article.title}">
                            </div>
                            <div class="form-group modify-form-group">
                                <p>내용<span>|</span></p>
                                <textarea class="form-control modify-form-control content" id="inputForm" rows="7" name="content" type='text'
                                maxlength='1000'><c:out value="${article.content}"></c:out></textarea>
                            </div>
                            <div id="content_cnt"></div>
							<div class="modifyBtns">
	                            <button type="button" id="updateBtn" class="btn">변경</button>
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
                if ($form.title.value.trim() === '') {
                    alert('제목은 필수 항목입니다.');
                    $form.title.focus();
                    return;
                } else if ($form.content.value.trim() === '') {
                    alert('내용은 필수 항목입니다.');
                    $form.content.focus();
                    return;
                } else {
                    $form.submit();
                }
            }

            $(document).ready(function () {
                $('.content').on('keyup', function () {
                    $('#content_cnt').html("(" + $(this).val().length + "/1000)");
                    if ($(this).val().length > 1000) {
                        $(this).val($(this).val.substring(0, 1000));
                        $('#content_cnt').html("(1000/1000)");
                    }
                })
            })
        </script>