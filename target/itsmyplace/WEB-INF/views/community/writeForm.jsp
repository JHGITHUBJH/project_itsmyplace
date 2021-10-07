<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
    
	$("#bbsTitle").focus();
	
	$("#btnWrite").on("click", function() {
		
		$("#btnWrite").prop("disabled", true); // 글쓰기 버튼 비활성화
		
		if($.trim($("#bbsTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#bbsTitle").val("");
			$("#bbsTitle").focus();
			
			$("#btnWrite").prop("disabled", false);  // 글쓰기 버튼 활성화
			
			return;
		}
		
		if($.trim($("#bbsContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#bbsContent").val("");
			$("#bbsContent").focus();
			
			$("#btnWrite").prop("disabled", false); // 글쓰기 버튼 활성화
			
			return;
		}
		
		var form = $("#writeForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: "/community/writeProc",
			data: formData,
			processData: false,			//formData를 string으로 변환하지 않겠다는 뜻
			contentType: false,			//content-type 헤더가 multipart/form-data로 전송
			cache: false,
			timeout: 600000,
			beforeSend: function(xhr){
				xhr.setRequestHeader("AJAX","true");
			},
			success: function(response){
				if(response.code == 0){
					alert("게시물이 등록되었습니다.");
					location.href = "/community/list";
				}
				else if(response.code == 400){
					alert("파라미터 값이 올바르지 않습니다.");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
				}
				else if(response.code == 800){
					alert("하나의 게시물에는 최대 5개의 사진만 첨부 가능합니다");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
				}
				else if(response.code == 900){
					alert("사진 확장자는 jpg, jpeg, png, bmp만 가능합니다.");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
				}
				else{
					alert("게시물 등록 중 오류가 발생했습니다.");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
				}
				
			},
			error: function(error){
				icia.common.error(error);
				alert("게시물 등록중 오류가 발생했습니다.");
				$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
			}
			
	    });
	});
	
/* 	$("#btnList").on("click", function(curPage) {
		document.bbsForm.curPage.value = curPage;
		document.bbsForm.action = "/community/list";
		document.bbsForm.submit();
	}); */
});

function fn_list(curPage)
{
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/community/list";
   document.bbsForm.submit();   
}

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="comm-custom"></div>
<div class="user-dashboard page-wrapper">
<div class="container">
	<div class="d-flex">
		<div class="logo text-center">
			<a href="/community/list"><img src="/resources/images/comm/commTitle.png" alt="커뮤니티 타이틀 이미지" height="80" /></a>
		</div>
	<div class="comm-custom2"></div>
	<div style="height:70px;"><img src="/resources/images/comm/writeFormTitle.png" alt="글쓰기페이지 이미지" height=70px;/></div>
	<div style="height:16.5px; background-color:#4397CF"></div>
	<form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
		<input type="text" name="userName" id="userName" maxlength="20" value="작성자명 : ${user.userName}" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
		<%-- <input type="text" name="userEmail" id="userEmail" maxlength="30" value="${user.userEmail}" style="ime-mode:inactive;" class="form-control mb-2" placeholder="이메일을 입력해주세요." readonly /> --%>
		<input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
		<div class="form-group">
			<textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" style="ime-mode:active;" placeholder="내용을 입력해주세요" required></textarea>
		</div>
		<input type="file" multiple="multiple" id="commPht" name="commPht" class="form-control mb-2" style="height:40px;" placeholder="사진을 선택하세요." required />
		<div class="form-group row" style="margin-top:15px;">
			<div class="col-sm-12">
				<button type="button" id="btnList" class="btn btn-main mb-3" style="height:45px;" title="리스트" onclick="fn_list(${curPage})">리스트</button>
				<button type="button" id="btnWrite" class="btn btn-main mb-3" style="height:45px;" title="저장">저장</button>
			</div>
		</div>
	</form>
	<form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>
</div>
</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>