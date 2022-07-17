<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<!-- Bootstrap 외부라이브러리등록 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- CK Editor -->
<script src="//cdn.ckeditor.com/4.19.0/full/ckeditor.js"></script>
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_insert_form.css">
<!-- 자바스크립트 -->
<script type="text/javascript">

	function insert(f) {
		
		var b_subject = f.b_subject.value.trim();
		var b_content = CKEDITOR.instances.b_content.getData().trim(); //CKEditor로부터 데이터 얻어오기
		
		//입력한 값의 유무 확인
		if(b_subject=='') {
			alert('제목을 입력하세요.');
			f.b_subject='';
			f.b_subject.focus();
			return;
		}
		if(b_content=='') {
			alert('내용을 입력하세요.');
			//문제 : 공백 -> &nbsp; 로 들어감, 공백이 2개 이상이면 p 태그로 감싸짐
			//CKEDITOR.instances.b_content.setData(); : CKEditor 값 비우기
			//f.b_content='';
			//f.b_content.focus();
			return;
		}
		f.method="POST";
		f.action="insert.do";
		f.submit();
	}// end : insert(f)
</script>
</head>
<body>
<form>
	<!-- Session Tracking -->
	<input type="hidden" name="u_idx"      value="${user.u_idx}">
	<input type="hidden" name="u_nickname" value="${user.u_nickname}">
	
	<div id="box">
	  <div class="panel panel-primary">
	    <div class="panel-heading">
      		<h3>새 글 쓰기</h3>
      	</div>
	    <div class="panel-body">
	    	
	    	<table class="table table-striped">
	    		<tr>
	    			<th width="15%">작성자</th>
	    			<td><span class="badge">${user.u_nickname}</span></td>
	    		</tr>
	    		<tr>
	    			<th>제목</th>
	    			<td><input name="b_subject" id="b_subject"></td>
	    		</tr>
	    		<tr>
	    			<td colspan="2">
	    				<textarea name="b_content" rows="8"></textarea>
	    					<!-- CK Editor 등록 -->
	    					<script>
		    					CKEDITOR.replace( 'b_content', {
		    						filebrowserUploadUrl: '${pageContext.request.contextPath}/ckeditorImageUpload.do'	
		    					});
		    						
		    					CKEDITOR.on('dialogDefinition', function( ev ) {
		    					       
		    							var dialogName       = ev.data.name;
		    					        var dialogDefinition = ev.data.definition;
		    					      
		    					        switch (dialogName) {
		    					            case 'image': dialogDefinition.removeContents('Link');
				    						              dialogDefinition.removeContents('advanced');
				    						              break;
		    					    	}
		    					 });
	    					</script>
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    			<td colspan="2" align="center">
	    				<input class="btn btn-primary" type="button" value="새글작성" onclick="insert(this.form);">
	    				<input class="btn btn-success" type="button" value="취소"     onclick="location.href='list.do'">
	    			</td>
	    		</tr>
	    	</table>
	    </div>
      </div>
	</div>
</form>

</body>
</html>