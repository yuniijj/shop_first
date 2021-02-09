<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>QnA</title>

<%@ include file="/WEB-INF/include/include-header.jspf" %>

</head>
<body>


<div id="con_lf" class="container">
	<h2 class="pg_tit">
		<span>QnA�Խ��Ǹ��</span>
	</h2>
	
	
	<table class="table table-hover">
		
		<thead>
			<tr>
				<th>��ȣ</th>
				<th>�з�</th>
				<th>����</th>
				<th>���̵�</th>
				<th>��¥</th>
				<th>�亯����</th>
			</tr>
		</thead>
		<tbody>
		<!-- 
			<c:choose>
				<c:when test="${fn:length(qnalist) > 0}">
					<c:forEach items="${qnalist }" var="row">
						<tr>
							<td>${row.QNA_IDX}</td>
							<td>${row.QNA_CATEGORY}</td>
							<td>
								<a href="#this" name="QNA_TITLE">${row.QNA_TITLE }</a>
								<input type="hidden" id="IDX" value="${row.QNA_IDX }">
							</td>
							<td>${row.MEMBER_ID}</td>
							<td>${row.QNA_REGDATE}</td>
							<td>${row.REPLY_STATE}</td>

						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4">��ȸ�� ����� �����ϴ�.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		-->
		</tbody>
	</table>

	<div id="PAGE_NAVI"></div>
	<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
	
</div>

<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){

			
			fn_selectQnaList(1);
			$("a[name='QNA_TITLE']").on("click", function(e){ //��ǰ�󼼺���
				e.preventDefault();
				fn_qnaDetail($(this));
			});
			

			
		});


		function fn_qnaDetail(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/admin/qnaDetail.do' />");
			comSubmit.addParam("QNA_IDX", obj.parent().find("#QNA_IDX").val());
			comSubmit.submit();
		}
		
		function fn_selectQnaList(pageNo){
			
			var comAjax = new ComAjax();
			comAjax.setUrl("<c:url value='/admin/selectQnaList.do' />");
			comAjax.setCallback("fn_selectQnaListCallback");
			comAjax.addParam("PAGE_INDEX",pageNo);
			comAjax.addParam("PAGE_ROW", 15);
			comAjax.ajax();
		}
		
		function fn_selectQnaListCallback(data){
			
			var total = data.TOTAL;
			var body = $("table>tbody");
			body.empty();
			if(total == 0){
				var str = "<tr>" + 
								"<td colspan='4'>��ȸ�� ����� �����ϴ�.</td>" + 
							"</tr>";
				body.append(str);
			}
			else{
				var params = {
					divId : "PAGE_NAVI",
					pageIndex : "PAGE_INDEX",
					totalCount : total,
					eventName : "fn_selectQnaList"
				};
				gfn_renderPaging(params);
				
				var str = "";
				$.each(data.list, function(key, value){
					str += "<tr>" + 
								"<td>" + value.QNA_CATEGORY + "</td>" + 
								"<td class='title'>" +
									"<a href='#this' name='QNA_TITLE'>" + value.QNA_TITLE + "</a>" +
									"<input type='hidden' id='QNA_IDX' name='QNA_IDX' value=" + value.QNA_IDX + ">" + 
								"</td>" +
								"<td>" + value.MEMBER_ID + "</td>" + 
								"<td>" + value.QNA_REGISTDATE + "</td>" + 
								"<td>" + value.REPLY_STATE + "</td>" + 
							"</tr>";
				});
				body.append(str);
				
				
				$("a[name='QNA_TITLE']").on("click", function(e){ //Qna�󼼺���
					e.preventDefault();
					fn_qnaDetail($(this));
				});
				
			}
		}



		
	</script>



</body>
</html>


						