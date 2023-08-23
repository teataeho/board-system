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
                        
                    <form action="${pageContext.request.contextPath}/review/update" method="post" name="updateForm" enctype="multipart/form-data">
                        <input type="hidden" name="reviewNo" value="${article.reviewNo}" />
                        <div id="uploaded-file-container">
                            <label class="upload-label">기존 첨부 파일</label>
                            <c:forEach var="file" items="${fileList}">
                                <div>
                                    <input type="hidden" value="${file.fileName}">
                                    <input type="checkbox" checked="true">
                                    <p>${file.fileRealName}</p>
                                </div>
                            </c:forEach>
                        </div>
                        <div id="file-upload-container">
                            <label class="upload-label">업로드할 파일</label>
                            <button type="button" class="btn" id="uploadPlusBtn">+</button>
                            <button type="button" class="btn" id="uploadMinusBtn">-</button>
                        </div>
                        <div class="form-group modify-form-group">
                            <p>작성자<span>|</span></p>
                            <input class="form-control modify-form-control" id="inputForm" name="userNick" value="${article.writer}" readonly>
                        </div>    
                        <div class="form-group modify-form-group">
                            <p>제목<span>|</span></p>
                            <input class="form-control modify-form-control title" id="inputForm" name="title" value="${article.title}">
                        </div>
                        <div class="form-group modify-form-group">
                            <p>내용<span>|</span></p>
                            <textarea class="form-control modify-form-control content" id="inputForm" rows="7" name="content" type='text'><c:out value="${article.content}"></c:out></textarea>
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
        };

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
            }  else {
                $form.submit();
            }
        };

        document.querySelector('.title').addEventListener('keyup', e => {
            if(e.target.value.length > 100) {
                alert('제목은 100글자 이내로 제한됩니다.');
                e.target.value = e.target.value.substr(0, 100);
                document.querySelector('.title').focus();
                return;
            }
        });
        document.querySelector('.title').addEventListener('mouseup', e => {
            if(e.target.value.length > 100) {
                alert('제목은 100글자 이내로 제한됩니다.');
                e.target.value = e.target.value.substr(0, 100);
                document.querySelector('.title').focus();
                return;
            }
        });
        document.querySelector('.title').addEventListener('input', e => {
            if(e.target.value.length > 100) {
                alert('제목은 100글자 이내로 제한됩니다.');
                e.target.value = e.target.value.substr(0, 100);
                document.querySelector('.title').focus();
                return;
            }
        });
        

        document.querySelector('.content').addEventListener('keyup', e => {
            if(e.target.value.length > 1000) {
                alert('내용은 1000글자 이내로 제한됩니다.');
                e.target.value = e.target.value.substr(0, 1000);
                document.querySelector('.content').focus();
                document.getElementById('content_cnt').textContent = '(' + e.target.value.length + '/1000)';
                return;
            }
        });
        document.querySelector('.content').addEventListener('mouseup', e => {
            if(e.target.value.length > 1000) {
                alert('내용은 1000글자 이내로 제한됩니다.');
                e.target.value = e.target.value.substr(0, 1000);
                document.querySelector('.content').focus();
                document.getElementById('content_cnt').textContent = '(' + e.target.value.length + '/1000)';
                return;
            }
        });
        document.querySelector('.content').addEventListener('input', e => {
            document.getElementById('content_cnt').textContent = '(' + e.target.value.length + '/1000)';
            if(e.target.value.length > 1000) {
                alert('내용은 1000글자 이내로 제한됩니다.');
                e.target.value = e.target.value.substr(0, 1000);
                document.querySelector('.content').focus();
                document.getElementById('content_cnt').textContent = '(' + e.target.value.length + '/1000)';
                return;
            }
        });

        const $fileUploadContainer = document.getElementById('file-upload-container');

        //파일 업로드 추가
        document.getElementById('uploadPlusBtn').addEventListener('click', e => {
            e.preventDefault();
            const str = `<br><input type="file" name="file">`;
            $fileUploadContainer.insertAdjacentHTML('beforeend', str);
        });

        //파일 업로드 빼기
        document.getElementById('uploadMinusBtn').addEventListener('click', e => {
            e.preventDefault();
            if($fileUploadContainer.lastElementChild.tagName === 'INPUT') {
                $fileUploadContainer.lastElementChild.remove();
                $fileUploadContainer.lastElementChild.remove();
            }
        });

        //파일 확장자 제어
        document.getElementById('file-upload-container').addEventListener('change', e=> {
            if(!e.target.matches('input')) return;
            const ext = e.target.value.slice(e.target.value.lastIndexOf('.')+1).toLowerCase();

            if(ext !== 'docx' && ext !== 'xls' && ext !== 'hwp' && ext !== 'pdf' && ext !== 'xlsx' && ext !== 'zip') {
                alert('문서파일(docx, hwp, pdf, xls, xlsx, zip)만 등록이 가능합니다.');
                e.target.value = '';
                return;
            }
            if(e.target.files[0].size > 5*1024*1024) {
                alert('첨부파일의 사이즈는 5MB 이내로 가능합니다.');
                e.target.value = '';
                return;
            }
        });

        //기존 첨부파일 삭제 버튼
        document.getElementById('uploaded-file-container').addEventListener('change', e => {
            if(!e.target.matches('input')) return;
            if(e.target.checked) {                
                e.target.previousElementSibling.removeAttribute('name');
                e.target.nextElementSibling.classList.toggle('shade');
            } else {
                e.target.previousElementSibling.setAttribute('name', 'fileName');
                e.target.nextElementSibling.classList.toggle('shade');
            }
        });

    </script>