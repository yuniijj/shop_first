<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>FAQ</title>

<%@ include file="/WEB-INF/include/include-header.jspf" %>




</head>
<body>




<div id="con_lf" class="container">
	<h2 class="pg_tit">
		<span>���ֹ��� ����</span>
	</h2>
	
	<nav class="navbar  navbar-expand-sm  bg-light">
		<ul class="navbar-nav" id="tab_cate_ul">

			<li class="nav-item"><a class="nav-link" href="faqList.do?faq_category=1">��۹���</a></li>
			<li class="nav-item"><a class="nav-link" href="faqList.do?faq_category=2">���/��ȯ/��ǰ</a></li>
			<li class="nav-item"><a class="nav-link" href="faqList.do?faq_category=3">ȯ�Ұ���</a></li>
			<li class="nav-item"><a class="nav-link" href="faqList.do?faq_category=4">�ֹ�/����</a></li>
			<li class="nav-item"><a class="nav-link" href="faqList.do?faq_category=5">����/����Ʈ</a></li>
			<li class="nav-item"><a class="nav-link" href="faqList.do?faq_category=6">ȸ������</a></li>
			<li class="nav-item"><a class="nav-link" href="faqList.do?faq_category=7">��Ÿ</a></li>
		</ul>
	</nav>
	<table class="table table-hover">
		<tbody>
			<c:choose>
				<c:when test="${fn:length(faqlist) > 0}">
					<c:forEach items="${faqlist }" var="row">
						<tr>
							<td>${row.FAQ_IDX}</td>
							<td>
								<a href="#this" name="FAQ_QUESTION">${row.FAQ_QUESTION }</a>
								<input type="hidden" id="IDX" value="${row.FAQ_IDX }">
							</td>
							<td>${row.FAQ_ANSWER}</td>

						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4">��ȸ�� ����� �����ϴ�.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<a class="btn btn-primary" id="faqWriteForm" href="#this">Write</a>
</div>

<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){

			$("a[name='FAQ_QUESTION']").on("click", function(e){ //��ǰ�󼼺���
				e.preventDefault();
				fn_faqModifyForm($(this));
			});
			

			$("#faqWriteForm").on("click", function(e){ //��ǰ���
				e.preventDefault();
				fn_faqWriteForm($(this));
			});

		});


		function fn_faqModifyForm(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/admin/faqModifyForm.do' />");
			comSubmit.addParam("FAQ_IDX", obj.parent().find("#IDX").val());
			comSubmit.submit();
		}
		
		function fn_faqWriteForm(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/admin/faqWriteForm.do' />");
			comSubmit.submit();
		}

		</script>

</body>
</html>