<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta   charset="utf-8">
<script>

	function search_order_history(fixedSearchPeriod){
		
		var formObj = document.createElement("form");
		
		var i_fixedSearch_period = document.createElement("input");
		i_fixedSearch_period.name = "fixedSearchPeriod";
		i_fixedSearch_period.value = fixedSearchPeriod;
	    
		formObj.appendChild(i_fixedSearch_period);
	    
		document.body.appendChild(formObj); 
	    
		formObj.method = "get";
	    formObj.action = "${contextPath}/mypage/listMyOrderHistory.do";
	    formObj.submit();
	    
	}
	
	function fn_enable_detail_search(r_search) {
		
		var frm_delivery_list= document.frm_delivery_list;
		
		t_beginYear   			 = frm_delivery_list.beginYear;
		t_beginMonth 			 = frm_delivery_list.beginMonth;
		t_beginDay   			 = frm_delivery_list.beginDay;
		t_endYear     			 = frm_delivery_list.endYear;
		t_endMonth    			 = frm_delivery_list.endMonth;
		t_endDay     			 = frm_delivery_list.endDay;		
		s_search_type 			 = frm_delivery_list.s_search_type;
		t_search_word    		 = frm_delivery_list.t_search_word;
		btn_search     		 	 = frm_delivery_list.btn_search;
		
		if (r_search.value == 'detail_search'){
			
			t_beginYear.disabled   			= false;
			t_beginMonth.disabled 			= false;
			t_beginDay.disabled   			= false;
			t_endYear.disabled     			= false;
			t_endMonth.disabled    			= false;
			t_endDay.disabled      			= false;			
			s_search_type.disabled 			= false;
			t_search_word.disabled    		= false;
			btn_search.disabled      		= false;
		} 
		else {
			t_beginYear.disabled   			= true;
			t_beginMonth.disabled  			= true;
			t_beginDay.disabled    			= true;
			t_endYear.disabled     			= true;
			t_endMonth.disabled    			= true;
			t_endDay.disabled      			= true;			
			s_search_type.disabled 			= true;
			t_search_word.disabled    		= true;
			btn_search.disabled      		= true;
		}
		
	}
	
	function fn_detail_search() {
		
		var frm_delivery_list = document.frm_delivery_list;
		
		beginYear   		= frm_delivery_list.beginYear.value;
		beginMonth  		= frm_delivery_list.beginMonth.value;
		beginDay    		= frm_delivery_list.beginDay.value;
		endYear     		= frm_delivery_list.endYear.value;
		endMonth    		= frm_delivery_list.endMonth.value;
		endDay      		= frm_delivery_list.endDay.value;
		search_type 		= frm_delivery_list.s_search_type.value;
		search_word			= frm_delivery_list.t_search_word.value;
		
		if (beginYear < 10) 	beginYear = "0" + beginYear; 
		if (beginMonth < 10) 	beginMonth = "0" + beginMonth; 
		if (beginDay < 10) 		beginDay = "0" + beginDay; 
		if (endYear < 10) 		endYear = "0" + endYear; 
		if (endMonth < 10) 		endMonth = "0" + endMonth; 
		if (endDay < 10) 		endDay = "0" + endDay; 
		
		var url =  "${contextPath}/mypage/orderGoodsSearch.do?";
			url += "beginDate="+ beginYear + "-" + beginMonth + "-" + beginDay;
			url += "&endDate=" + endYear + "-" + endMonth + "-" + endDay;
			url += "&searchType=" + search_type;
			url += "&searchWord=" + search_word;
			
		location.href = url;
	}
	
	function fn_cancel_order(orderId){
		
		var answer = confirm("????????? ?????????????????????????");
		
		if (answer) {
		    location.href = "${contextPath}/mypage/cancelMyOrder.do?orderId=" + orderId;
		}
		
	}

</script>
</head>
<body>
	<h3>?????? ?????? ??????</h3>
	<form name="frm_delivery_list" method="post">	
		<table>
			<tbody>
				<tr>
					<td>
						<input type="radio" name="r_search_option" value="simple_search" checked onClick="fn_enable_detail_search(this)"/> ???????????? &nbsp;
						<input type="radio" name="r_search_option" value="detail_search"  onClick="fn_enable_detail_search(this)" /> ???????????? &nbsp;
					</td>
				</tr>
				<tr>
					<td>
						?????? ?????? &nbsp;&nbsp;
						<select name="curYear" disabled>
						    <c:forEach var="i" begin="0" end="5">
						      <c:choose>
						        <c:when test="${endYear==endYear-i}">
						          <option value="${endYear}" selected>${endYear}</option>
						        </c:when>
						        <c:otherwise>
						          <option value="${endYear-i }">${endYear-i }</option>
						        </c:otherwise>
						      </c:choose>
						    </c:forEach>
						</select>??? 
						<select name="curMonth" disabled>
							 <c:forEach var="i" begin="1" end="12">
						      <c:choose>
						        <c:when test="${endMonth==i}">
						          <option value="${i}"  selected>${i}</option>
						        </c:when>
						        <c:otherwise>
						          <option value="${i}">${i}</option>
						        </c:otherwise>
						      </c:choose>
						    </c:forEach>					
						</select>???
					 	<select name="curDay" disabled>
						  	<c:forEach var="i" begin="1" end="31">
						      <c:choose>
						        <c:when test="${endDay==i}">
						          <option value="${i}" selected>${i}</option>
						        </c:when>
						        <c:otherwise>
						          <option value="${i}">${i}</option>
						        </c:otherwise>
						      </c:choose>
						    </c:forEach>	
					    </select>??? &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					    <input type="button" value="??????"  onclick="search_order_history('today')">
						<input type="button" value="1???"   onclick="search_order_history('one_week')">
						<input type="button" value="2???"   onclick="search_order_history('two_week')">
						<input type="button" value="1??????" onclick="search_order_history('one_month')">
						<input type="button" value="2??????" onclick="search_order_history('two_month')">
						<input type="button" value="3??????" onclick="search_order_history('three_month')">
						<input type="button" value="4??????" onclick="search_order_history('four_month')">
					</td>
					</tr>
					<tr>
					  <td>
				 	   <select id="s_search_type" name="s_search_type" disabled>
							<option value="all" selected>??????</option>
							<option value="receiverName">?????????</option>
							<option value="ordererName">?????????</option>
							<option value="orderId">????????????</option>
						</select>
						<input id="t_search_word" type="text" size="30" disabled/>  
						<input id="btn_search" type="button"  value="??????" onclick="fn_detail_search()" disabled/>
					  </td>
					</tr>
					<tr>
					  <td>
						?????? ?????? &nbsp;&nbsp;
						<select name="beginYear" disabled>
						 <c:forEach var="i" begin="0" end="5">
						      <c:choose>
						        <c:when test="${beginYear == beginYear-i}">
						          <option value="${beginYear-i}" selected>${beginYear-i}</option>
						        </c:when>
						        <c:otherwise>
						          <option value="${beginYear-i}">${beginYear-i}</option>
						        </c:otherwise>
						      </c:choose>
						    </c:forEach>
						</select>??? 
						<select name="beginMonth" disabled >
							 <c:forEach var="i" begin="1" end="12">
						      <c:choose>
						        <c:when test="${beginMonth == i}">
						          <option value="${i }" selected>${i}</option>
						        </c:when>
						        <c:otherwise>
						          <c:choose>
						            <c:when test="${i <10}">
						              <option value="${i}">0${i}</option>
						            </c:when>
						            <c:otherwise>
						              <option value="${i}">${i}</option>
						            </c:otherwise>
						          </c:choose>
						        </c:otherwise>
						      </c:choose>
						    </c:forEach>					
						</select>???
						 <select name="beginDay" disabled >
						  <c:forEach var="i" begin="1" end="31">
						      <c:choose>
						        <c:when test="${beginDay==i }">
						          <option value="${i}" selected>${i}</option>
						        </c:when>
						        <c:otherwise>
						          <c:choose>
						            <c:when test="${i <10}">
						              <option value="${i}">0${i}</option>
						            </c:when>
						            <c:otherwise>
						              <option value="${i}">${i}</option>
						            </c:otherwise>
						          </c:choose>
						        </c:otherwise>
						      </c:choose>
						    </c:forEach>	
						</select>???  &nbsp; ~ &nbsp;
						
						<select name="endYear" disabled >
						 <c:forEach var="i" begin="0" end="5">
						      <c:choose>
						        <c:when test="${endYear==endYear-i }">
						          <option value="${2021-i}" selected>${2021-i }</option>
						        </c:when>
						        <c:otherwise>
						          <option value="${2021-i}">${2021-i}</option>
						        </c:otherwise>
						      </c:choose>
						    </c:forEach>
						</select>??? 
						<select name="endMonth" disabled >
							 <c:forEach var="i" begin="1" end="12">
						      <c:choose>
						        <c:when test="${endMonth==i}">
						          <option value="${i}"selected>${i}</option>
						        </c:when>
						        <c:otherwise>
						          <c:choose>
						            <c:when test="${i <10}">
						              <option value="${i}">0${i}</option>
						            </c:when>
						            <c:otherwise>
						             <option value="${i}">${i}</option>
						            </c:otherwise>
						          </c:choose>
						        </c:otherwise>
						      </c:choose>
						    </c:forEach>					
						</select>???
						 <select name="endDay" disabled >
						  <c:forEach var="i" begin="1" end="31">
						      <c:choose>
						        <c:when test="${endDay==i}">
						          <option value="${i}" selected>${i}</option>
						        </c:when>
						        <c:otherwise>
						          <c:choose>
						            <c:when test="${i<10}">
						              <option value="${i}">0${i}</option>
						            </c:when>
						            <c:otherwise>
						            <option value="${i}">${i}</option>
						            </c:otherwise>
						          </c:choose>
						        </c:otherwise>
						      </c:choose>
						    </c:forEach>	
						</select>???
					  </td>
					</tr>
				</tbody>
			</table>
			<div class="clear">
		</div>
	</form>	
	<div class="clear"></div>
	<br>
	<table class="list_view">
		<tbody align=center >
			<tr style="background:blue; color:#fff; height: 50px;"  >
				<td class="fixed" >????????????</td>
				<td>????????????</td>
				<td>????????????/??????</td>
				<td>????????????</td>
				<td>?????????</td>
				<td>?????????</td>
				<td>????????????</td>
				<td>????????????</td>
			</tr>
	   		<c:choose>
		     <c:when test="${empty myOrderHistList }">			
				<tr>
			       <td colspan=8 class="fixed"><strong>????????? ????????? ????????????.</strong></td>
			     </tr>
			 </c:when>
			 <c:otherwise> 
			     <c:forEach var="item" items="${myOrderHistList }">
		            <tr>       
						<td><strong>${item.orderId }</strong></td>
						<td> 
						    <strong>
						     	<a href="${contextPath}/mypage/myOrderDetail.do?orderId=${item.orderId }">${item.goodsTitle }</a><br>
							 </strong>
						</td>
						<td>
						   <strong>
						      ${item.goodsSalesPrice * item.orderGoodsQty }??? / ${item.orderGoodsQty }???<br>
						   </strong>
						</td>
						<td>
						  <strong>
						    <c:choose>
							    <c:when test="${item.deliveryState == 'deliveryPrepared'}">???????????????</c:when>
							    <c:when test="${item.deliveryState == 'delivering'}">?????????</c:when>
							    <c:when test="${item.deliveryState == 'finishedDelivering'}">????????????</c:when>
							    <c:when test="${item.deliveryState == 'cancelOrder'}">????????????</c:when>
							    <c:when test="${item.deliveryState == 'returningGoods'}">??????</c:when>
						  	</c:choose>
						  </strong>
						</td>
						<td><strong>${item.ordererName }</strong></td>
						<td><strong>${item.receiverName }</strong></td>
						<td><strong><fmt:formatDate value="${item.payOrderTime }" pattern="yyyy-MM-dd"/> </strong> </td>
						<td>
						   <c:choose>
							   <c:when test="${item.deliveryState == 'deliveryPrepared'}">
							       <input type="button" onClick="fn_cancel_order('${item.orderId}')" class="btn btn-outline-primary btn-sm" value="??????"  />
							   </c:when>
							   <c:otherwise>
							      <input type="button" onClick="fn_cancel_order('${item.orderId}')" class="btn btn-outline-primary btn-sm" value="?????????" disabled />
							   </c:otherwise>
						  </c:choose>
					    </td>
					  </tr>
					</c:forEach>
				</c:otherwise>
		  	</c:choose>			   
		</tbody>
	</table>
</body>
</html>