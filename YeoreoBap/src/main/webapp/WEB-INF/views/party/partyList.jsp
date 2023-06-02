<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../include/header.jsp" %>

<div class="container">

	<!-- 파티 모집글 작성을 유도하는 글 -->
	<div class="size">
		<img src="${pageContext.request.contextPath}/img/ex_carousel1.png" class="d-block w-100" alt="메인 이미지1">
	</div>

	<!-- 최상단 이동 버튼 클릭 시 이동 위치 -->
	<a id="top" class="d-block w-100"></a>

	<div class="page-header border-bottom border-orange mb-4 partyList">
		<h2 class="text-center ms-2">
			여러밥 모집
		</h2>

		<!-- 정렬 선택 버튼 -->
		<div id="orderBy" class="dropdown">
			<button class="btn btn-white border-orange dropdown-toggle text-orange" type="button"
				data-bs-toggle="dropdown" aria-expanded="true">
				최신순
			</button>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="#">최신순</a></li>
				<li><a class="dropdown-item" href="#"><span class="necessary">핫!</span>한 순</a></li>
			</ul>
		</div>
	</div>

	<!-- 파티 리스트 -->
	<div class="partyContainer">
		<div id="partyList" class="d-inline-flex flex-wrap justify-content-around p-0">
		</div>
		<div class="stickyButtons">
			<!-- 최상단 이동 버튼 -->
			<a href="#top" class="toTheTop"><i class="bi bi-arrow-up-short"></i></a>
			<!-- 글 작성 버튼 -->
			<a href="${pageContext.request.contextPath}/party/map" id="register"><i class="bi bi-pencil"></i></a>
		</div>
	</div>
	<!-- 파티 리스트 끝 -->



</div>
<%@ include file="../include/footer.jsp" %>
<!-- 모달달 -->
<div class="modal" id="snsModal" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-body row">
				<div class="modal-img col-sm-8 col-xs-6" >
					<img src="#" id="snsImg" width="100%">
				</div>
				<div class="modal-con col-sm-4 col-xs-6">
					<div class="modal-inner">
					<div class="profile">
						<img src="#">
					</div>
					<div class="title">
						<p id="snsWriter">테스트</p>
						<small id="snsRegdate">21시간전</small>
					</div>
					<div class="content-inner">
						<p id="snsContent">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vulputate elit libero, quis mattis enim tincidunt non. Mauris consequat ante vel urna posuere consequat. </p>
					</div>
					<div class="link-inner">
						<a href="##"><i class="glyphicon glyphicon-thumbs-up"></i>좋아요</a>
						<a href="##"><i class="glyphicon glyphicon-comment"></i>댓글달기</a> 
						<a href="##"><i class="glyphicon glyphicon-share-alt"></i>공유하기</a>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	//리스트
	let str = '';
	let page = 1;
	let isFinish = false;
	const $partyList = document.getElementById('partyList');
	const $stickyButtons = document.querySelector('.stickyButtons');
	getList(1, true);

	function getList(page, reset) {
		str = '';
		console.log('page: ' + page);
		console.log('reset: ' + reset);

		fetch('${pageContext.request.contextPath}/party/' + page)
			.then(res => res.json())
			.then(list => {
				console.log(list);
				console.log(list.length);
				if (list.length === 0) isFinish = true;

				if (reset) {
					while ($partyList.firstChild) {
						$partyList.firstChild.remove();
					}
					page = 1;
				}

				for (vo of list) {
					str +=
						`<div class="thumbnail-size rounded mb-4" id="vo.partyNo">
									<img class="h-100" src="${pageContext.request.contextPath}/party/getImg/` + vo.fileName + `" alt="썸네일">
									<div id="rdnWhlAddr" class="invisible">` + '주소가 들어갈 공간' + `</div>
									<div id="title" class="invisible">` + vo.title + `</div>
								</div>`;
				}

				if (!reset) {
					$partyList.insertAdjacentHTML('beforeend', str);
				} else {
					$partyList.insertAdjacentHTML('afterbegin', str);
				}

			}); //end fetch

	} //end getList

	const handleScroll = _.throttle(() => {
		console.log('throttle activate!');
		const scrollPosition = window.pageYOffset;
		const height = document.body.offsetHeight;
		const windowHeight = window.innerHeight;

		if (!isFinish) {
			if (scrollPosition + windowHeight >= height * 0.9) {
				console.log('next Page call!');
				getList(++page, false);
			}
		}
	}, 1000);

	window.addEventListener('scroll', handleScroll);
</script>