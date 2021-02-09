<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="//cdn.ckeditor.com/4.4.4/standard/ckeditor.js"></script>
<%@ include file="/WEB-INF/include/include-board_header.jspf"%>
</head>
<body>
	<form id="update_frm" name="update_frm" enctype="multipart/form-data">
		<table class="board_view">
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			<caption>게시글 상세</caption>
			<tbody>
				<tr>
					<input type="hidden" id="KIND" name="BOARD_KIND" value="${map.BOARD_KIND }">
					<th scope="row">글 번호</th>
					<td>${map.BOARD_IDX } <input type="hidden" id="IDX" name="BOARD_IDX" value="${map.BOARD_IDX }">
					</td>
					<th scope="row">조회수</th>
					<td>${map.BOARD_COUNT }</td>
				</tr>
				<tr>
					<th scope="row">작성자</th>
					<td>${map.MEMBER_ID }</td>
					<th scope="row">작성시간</th>
					<td>${map.BOARD_REGDATE }</td>
				</tr>
				<tr>
					<th scope="row">제목</th>
					<td colspan="3"><input type="text" id="TITLE" name="BOARD_TITLE"
						class="wdp_90" value="${map.BOARD_TITLE }" /></td>
				</tr>
				<tr>
					<td colspan="4" class="view_text">
					<textarea rows="20" cols="100" title="내용" id="CONTENTS" name="BOARD_CONTENT">${map.BOARD_CONTENT }</textarea>
						<script>
								CKEDITOR.replace( 'BOARD_CONTENT', {
									filebrowserUploadUrl: "${pageContext.request.contextPath}/imageUpload.do"
								});
						</script>
					
					</td>
				</tr>
				<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3">
					<div id="fileDiv">
						<c:forEach var="row" items="${list }" varStatus="var">
							<p>
								<input type="hidden" id="IDX" name="IDX_${var.index }"
									value="${row.FILE_IDX }"> <a href="#this"
									id="name_${var.index }" name="name_${var.index }">${row.ORIGINAL_FILE_NAME }</a>
								<input type="file" id="file_${var.index }"
									name="file_${var.index }"> (${row.FILE_SIZE }kb) <a
									href="#this" class="btn" id="delete_${var.index }"
									name="delete_${var.index }">삭제</a>
							</p>
						</c:forEach>
					</div>
				</td>
				</tr>

			</tbody>
		</table>
	</form>
	
	<a href="#this" class="btn" id="addFile">파일 추가</a>
	<a href="#this" class="btn" id="list">목록으로</a>
	<a href="#this" class="btn" id="update">저장하기</a>
	<a href="#this" class="btn" id="delete">삭제하기</a>
	
	<%@ include file="/WEB-INF/include/include-board_body.jspf"%>
	
	<script type="text/javascript"> 
		var gfv_count = '${fn:length(list)+1}';
		
		$(document).ready(function(){ 
		$("#list").on("click", function(e){ //목록으로 버튼 
			e.preventDefault(); 
			fn_openBoardList(); 
		}); 

		$("#update").on("click", function(e){ //저장하기 버튼 
			e.preventDefault(); 
			fn_updateBoard(); 
		}); 

		$("#delete").on("click", function(e){ //삭제하기 버튼 
			e.preventDefault(); 
			fn_deleteBoard(); 
		}); 

		$("#addFile").on("click", function(e){ //파일 추가 버튼 
			e.preventDefault(); 
			fn_addFile(); 
		}); 

		$("a[name^='delete']").on("click", function(e){ //삭제 버튼 
			e.preventDefault(); 
			fn_deleteFile($(this)); 
		}); 
	});

		function fn_openBoardList(){ 
			var comSubmit = new ComSubmit(); 
			comSubmit.setUrl("<c:url value='/admin/board/openNoticeBoardList.do' />"); 
			comSubmit.submit(); 
		} 

		function fn_updateBoard(){ 
			var comSubmit = new ComSubmit("update_frm"); 
			comSubmit.setUrl("<c:url value='/admin/board/updateNoticeBoard.do' />"); 
			comSubmit.submit();
		} 

		function fn_deleteBoard(){ 
			var comSubmit = new ComSubmit(); 
			comSubmit.setUrl("<c:url value='/admin/board/deleteNoticeBoard.do' />"); 
			comSubmit.addParam("BOARD_KIND", $("#KIND").val()); 
			comSubmit.addParam("BOARD_IDX", $("#IDX").val()); 
			comSubmit.submit(); 
		} 

		function fn_addFile(){ 
			var str = "<p>" + 
						"<input type='file' id='file_"+(gfv_count)+"' name='file_"+(gfv_count)+"'>"+ 
						"<a href='#this' class='btn' id='delete_"+(gfv_count)+"' name='delete_"+(gfv_count)+"'>삭제</a>" + 
						"</p>"; 
						$("#fileDiv").append(str); 
						$("#delete_"+(gfv_count++)).on("click", function(e){ //삭제 버튼 
							e.preventDefault(); 
							fn_deleteFile($(this)); 
					}); 
				}

		function fn_deleteFile(obj){ 
			obj.parent().remove(); 
		}
				
	</script>

</body>
</html>
