<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>

   
<title>first</title>



<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
</head>
<body>
<div class="container">
	<div>
			
	<div>
      <a href="#this" name="GOODS_KIND1" style="float:left;width:25%;" align="center"><img class="img-reponsive"
            src="\first\resources\CKimg\과일.jpg" /></a> 
            <input type="hidden" id="IDX" value="${row.GOODS_IDX }" >
      <a href="#this" name="GOODS_KIND2" style="float:left;width:25%;" align="center"><img class="img-reponsive"
            src="\first\resources\CKimg\잡곡.jpg" /></a> 
            <input type="hidden"id="IDX" value="${row.GOODS_IDX }">
      <a href="#this" name="GOODS_KIND3" style="float:left;width:25%;" align="center"><img class="img-reponsive"
            src="\first\resources\CKimg\축산.jpg" /></a> 
            <input type="hidden"id="IDX" value="${row.GOODS_IDX }">
      <a href="#this" name="GOODS_KIND4" style="float:left;width:25%;" align="center"><img class="img-reponsive"
            src="\first\resources\CKimg\채소.jpg" /></a> 
            <input type="hidden"id="IDX" value="${row.GOODS_IDX }">
      </div>
	
	<br />
	<br />
	<br />
	<center>--------------------------------------------------------------------------------------------------------인
		기 상
		품--------------------------------------------------------------------------------------------------------</center>
	<br />
	
	
	<center>pullsoyu에서 가장 잘나가는 인기 상품입니다.</center>
	<hr>
		
			<div class="wrapper">
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach items="${list}" var="row">


							
							<div class="col-lg-4 col-md-6 mb-4">
								<div class="card h-100">
									<a href="#this" name="GOODS_SUMIMG"><img
										src="/first/resources/CKimg/${row.GOODS_SUMIMG }" height="200"
										width="338" alt=""/></a> <input type="hidden" id="IDX"
										value="${row.GOODS_IDX }">
									<div class="card-body">
										<h4 class="card-title">
											<td class="GOODS_NAME"><a href="#this" name="GOODS_NAME">${row.GOODS_NAME }</a>
												<input type="hidden" id="IDX" value="${row.GOODS_IDX }"></td>
										</h4>
										<p class="card-text">${row.GOODS_COMPANY }</p>
										<h5 align="center" style="color:red;">${row.GOODS_PRICE }원</h5>
										<td>
											<a href="#this" name="GOODSLIKE">찜하기</a>
											<input type="hidden" id="IDX" value="${row.GOODS_IDX }"></td>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4">조회된 결과가 없습니다.</td>
					</tr>
				</c:otherwise>
				</c:choose>

	<br/>
	<br/>
	
	<div class="imgslider" align="center">
	
	<img src="\first\resources\CKimg\군위군농업기술센터.png" class="item" width="110" height="90" />
	<img src="\first\resources\CKimg\군위군의회.png" class="item" width="110" height="90"/>
	<img src="\first\resources\CKimg\군위넷.png" class="item" width="110" height="90" /> 
	<img src="\first\resources\CKimg\군위문화원.png" class="item" width="110" height="90" />   
	
	
	</div>
</div>
	



	


	<%@ include file="/WEB-INF/include/include-body.jspf"%>
	 <script src="http://code.jquery.com/jquery-1.7.js"></script>
	<script type="text/javascript">
		 $(document).ready(function() {

			

			$('img.item').css('width', 250);

            // 함수를 2초마다 실행합니다.
            setInterval(function () {
                // 첫 번째 이미지를 마지막으로 보냅니다.
                $('img.item').first().appendTo('div.imgslider');
            }, 2000);  

			$("a[name='GOODS_NAME']").on("click", function(e) { //상품상세보기
				e.preventDefault();
				fn_openGoodsDetail($(this));
			});

			$("a[name='GOODS_SUMIMG']").on("click", function(e) { //상품상세보기
				e.preventDefault();
				fn_openGoodsDetail($(this));
			});

			$("a[name='GOODS_KIND1']").on("click", function(e) { //상품상세보기
				e.preventDefault();
				fn_openGoodsKind1($(this));
			});

			$("a[name='GOODS_KIND2']").on("click", function(e) { //상품상세보기
				e.preventDefault();
				fn_openGoodsKind2($(this));
			});

			$("a[name='GOODS_KIND3']").on("click", function(e) { //상품상세보기
				e.preventDefault();
				fn_openGoodsKind3($(this));
			});

			$("a[name='GOODS_KIND4']").on("click", function(e) { //상품상세보기
				e.preventDefault();
				fn_openGoodsKind4($(this));
			});

			$("a[name='GOODSLIKE']").on("click", function(e){ //제목 
				e.preventDefault();
				fn_goodsLike($(this));
			});

		});

		function fn_openGoodsDetail(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/main/goodsDetail.do' />");
			comSubmit.addParam("GOODS_IDX", obj.parent().find("#IDX").val());
			comSubmit.submit();
		}

		function fn_openGoodsKind1(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/main/fruitList.do' />");
			comSubmit.addParam("GOODS_IDX", obj.parent().find("#IDX").val());
			comSubmit.submit();
		}
		function fn_openGoodsKind2(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/main/grainList.do' />");
			comSubmit.addParam("GOODS_IDX", obj.parent().find("#IDX").val());
			comSubmit.submit();
		}
		function fn_openGoodsKind3(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/main/meatList.do' />");
			comSubmit.addParam("GOODS_IDX", obj.parent().find("#IDX").val());
			comSubmit.submit();
		}
		function fn_openGoodsKind4(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/main/vegetableList.do' />");
			comSubmit.addParam("GOODS_IDX", obj.parent().find("#IDX").val());
			comSubmit.submit();
		}

		function fn_goodsLike(obj){

			var comAjax = new ComAjax(); 
			comAjax.setUrl("<c:url value='/shop/addLike2.do' />");
			comAjax.setCallback("fn_selectSearchList");
			comAjax.addParam("MEMBER_ID", "${session_MEMBER_ID}");
			comAjax.addParam("GOODS_IDX", obj.parent().find("#IDX").val());

			comAjax.ajax();
		}
	</script>
</div>
</body>
</html>