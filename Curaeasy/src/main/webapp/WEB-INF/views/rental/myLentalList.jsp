<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <title>나의 대관일자</title>


    <style>
        .innerOuter {
            border:0px solid lightgray;
            width:80%;
            
            padding:5% 10%;
            background-color:white;
            display: inline-block;
            float: right;
        }
		button { border-radius: 50px !important;}

        .content {
        width:80%;
            padding: 0px;
            
        }
        .content-header {
            margin-bottom: 20px;     
        }
        .content-header h1 {
            font-size: 2em;
        }
        .search-box {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }
        .search-box>input { border-radius: 20px;}
        .search-box>button { border-radius: 20px;}




        .notice-list {
            width: 100%;
            border-collapse: collapse;
            
        }
        .notice-list th, .notice-list td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        .notice-list th {
            background-color: #f2f2f2;
            border : none; 
            height: 60px;
            border-top: 3px solid; border-bottom: 3px solid; 
            text-align: center;
        }
        .pagination {
            text-align: center;
            margin-top: 35px;
            width: 100%;
            display: flex;
            justify-content: center;
        }
        .pagination a {
            margin: 0 5px;
            text-decoration: none;
            color: #333;
        }
        .pagination a.active {
            font-weight: bold;
        }
        td{
         text-align: center;}

        td:hover { display: block; font-size: 15px; font-weight: 600; cursor: pointer; }
        tr:hover { background-color: #fff; }

    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/mainPageSidbar.jsp" />
<br><br>
<div class="innerOuter">
    <div class="content">
        <div class="content-header">
            <h1>대관 예약 일자</h1>
        </div>
        <div class="search-box">
            <input type="text" placeholder="대관장소를 입력하세요" />
            <button>검색</button>
        </div>
        <table id="noticeList" class="notice-list">
            <thead>
                <tr>
                    <th>대관신청번호</th>
                    <th>대관장소</th>
                    <th>대관 시작일</th>
                    <th>대관 종료일</th>
                    <th>승인여부</th>
                </tr>
            </thead>
            <tbody>                
                <c:forEach var="n" items="${ requestScope.list }">
                		<tr>
                			<td>${ n.rentalNo }</td>
                			<td>
                				<c:choose>
								    <c:when test="${n.galleryNo eq '1'}">
								       	제 1 전시관
								    </c:when>
								    <c:when test="${n.galleryNo eq '2'}">
								       	제 2 전시관
								    </c:when>
								    <c:when test="${n.galleryNo eq '3'}">
								       	제 3 전시관
								    </c:when>
								    <c:when test="${n.galleryNo eq '4'}">
								       	제 4 전시관
								    </c:when>
								    <c:when test="${n.galleryNo eq '5'}">
								       	제 5 전시관
								    </c:when>
								    <c:when test="${n.galleryNo eq '6'}">
								       	제 6 전시관
								    </c:when>
								</c:choose>

                			
                			</td>
                			<td>${ n.rentalStartDate }</td>
                            <td>${ n.rentalEndDate }</td>
                			<td>${ n.rentalResult }</td>
                		</tr>
                </c:forEach>
            </tbody>
        </table>
        
        
        
        
        <!-- 페이징바 -->
        
<!--        <script>
		$(function() {
       		
			$("#noticeList>tbody>tr").click(function() {
       			
       			let nno = $(this).children().eq(0).text();
       			
       			location.href = "noticeDetail.do?nno=" + nno;
       		});
       		
       	});
       </script>
 -->
        
        <div id="pagingArea">
                <ul class="pagination">
                
                	<c:choose>
                	<c:when test="${ requestScope.pi.currentPage eq 1 }">	
                    	<li class="page-item disabled">
                    		<a class="page-link" href="#">⇦</a>
                    	</li>
                    </c:when>
                    <c:otherwise>
                    	<li class="page-item">
                    		<a class="page-link" 
                    		   href="notice.do?cpage=${ requestScope.pi.currentPage - 1 }">
                    			Previous
                    		</a>
                    	</li>
                    </c:otherwise>
                    </c:choose>
                    
                    <c:forEach var="p" begin="${ requestScope.pi.startPage }"
                    		   end="${ requestScope.pi.endPage }"
                    		   step="1">
                    	
                    	<c:choose>	   
                    	<c:when test="${ requestScope.pi.currentPage ne p }">
                    		<li class="page-item">
		                    	<a class="page-link" href="notice.do?cpage=${ p }">
									${ p }
								</a>
		                    </li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item active">
		                    	<a class="page-link">
									${ p }
								</a>
		                    </li>
                    	</c:otherwise>
	                    </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                    <c:when test="${ requestScope.pi.currentPage eq requestScope.pi.maxPage }">
	                    <li class="page-item disabled">
	                    	<a class="page-link" href="#">
	                    		Next
	                    	</a>
	                    </li>
                    </c:when>
                    <c:otherwise>
	                    <li class="page-item">
	                    	<a class="page-link" 
	                    	   href="notice.do?cpage=${ requestScope.pi.currentPage + 1 }">
                               ⇨
	                    	</a>
	                    </li>
	                </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            
            
    </div>
</div>

<jsp:include page="../common/footer.jsp" />

</body>
</html>
