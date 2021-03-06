<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">
<script>
function btn_Refund(){
	
	if(confirm("환불하시겠습니까?")){
		
		$.ajax({
	        type: "POST",
	        url: "/cafe/refundProc",
	        data: {
	           rsrvSeq: $("#rsrvSeq").val()
	        },
	        datatype: "JSON",
	        beforeSend : function (xhr){
	           xhr.setRequestHeader("AJAX","true");
	        },
	        success:function(response){
	           if(response.code == 0)
	           {
	              alert("환불");
	              location.href = "/mypage/userPayment";
	           }
	          
	           else{
	        	   alert("ee");
	           }
	           
	        },
	        complete: function(data)
	        {
	           //응답이 종료되면
	           icia.common.log(data);
	        },
	        error: function(xhr, status, error)
	        {
	           icia.common.error(error);
	        }
	     
	     });
	}
	else{
		alert("환불이 취소되었습니다.");
	}
}
</script>

</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!--상단-->
<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<ol class="breadcrumb">
						<li><a href="/../index">Home</a></li>
						<li class="active">purchase-confirmation</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- style="text-align: center;" -->
<div class="page-wrapper">
  	<div class="purchase-confirmation shopping">
    	<div class="container">

      		<div class="row">
        		<div class="col-md-8 col-md-offset-2" style="text-align: center;">
          			<div>
          			<c:if test="${!empty myPage}">
            			<div class="purchase-confirmation-details">
				            <table id="purchase-receipt" class="table" style="text-align: center;">
				                <thead>
									<tr>
					                    <td><strong>결제일시 </strong></td>
					                    <td>${myPage.payDate}</td>			                   
				                  	</tr>
				                </thead>

				                <tbody>
		
									<tr>
				                    	<td><strong>결제번호 </strong></td>
				                    	<td>${myPage.rsrvSeq}</td>
				                  	</tr>
				                  	<tr>
				                    	<td><strong>카페명 </strong></td>
				                    	<td>${myPage.cafeName}</td>
				                  	</tr>
				                  	
				                  	<tr>
				                    	<td><strong>예약된자리 </strong></td>
				                    	<td>${myPage.rsrvSeatList}</td>
				                  	</tr>
				                  	<tr>
				                    	<td><strong>예약시간 </strong></td>
				                    	<td>${myPage.rsrvTime}</td>
				                  	</tr>
				                  	
				                  	<tr>
				                    	<td><strong>주문내역 </strong></td>
				                  		
				                    	<td>
				                    		<c:forEach var="list" items="${myPage.orderList}" varStatus="status">
				                    			<c:out value="${list.menuName}" />
				                    			<c:out value="${list.menuCount}" />잔&nbsp;&nbsp;
				                    		</c:forEach>
				                    	</td>
				                    	
				                  	</tr>
				                  	
				                  	<tr>
				                    	<td><strong>결제금액 </strong></td>
				                    	<td>${myPage.originPrice_s}</td>
				                    </tr>
									<tr>
				                    	<td><strong>사용 포인트 </strong></td>
				                    	<td>${myPage.payPoint_s}</td>
				                    </tr>
				                    <tr>
				                    	<td><strong>최종 결제금액 </strong></td>
				                    	<td>${myPage.totalPrice_s}</td>
				                    </tr>
				                    <tr>
				                    	<td><strong>결제 상태 </strong></td>
				                    	<td>${myPage.payStep}</td>
				                    </tr>
				                    <tr>
				                      	<td><strong>결제방법 </strong></td>
				                      	<td>카카오페이</td>
				                    </tr>
				                </tbody>
				            </table>
              			</div>
              		</c:if>
            		</div>
            		<br/>
            		<input type="button" id="btn_Back" name="btn_Back" onclick="history.back(-1);" value="뒤로가기" style="width:80px;height:40px;"/>
            		<c:if test="${myPage.payStep ne '환불완료'}">
            			<input type="button" id="btn_Refund" name="btnRefund" onclick="btn_Refund();" value="환불하기" style="width:80px;height:40px;" />
            		</c:if>
            		<input type="hidden" id="rsrvSeq" name="rsrvSeq" value="${myPage.rsrvSeq}" />
          		</div>
        	</div>
      	</div>
    </div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>


  </body>
  </html>