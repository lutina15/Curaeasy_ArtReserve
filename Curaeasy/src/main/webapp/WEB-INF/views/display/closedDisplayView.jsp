<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&family=Grandiflora+One&display=swap" rel="stylesheet">
    <title>마감된 전시</title>
    
    <style>
        /*폰트
        .content{
            font-family: "Grandiflora One", cursive;
            font-weight: 400;
            font-style: normal;
        }
        */

        .container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
        }
        .header, .footer {
            background-color: #f8f8f8;
            padding: 20px;
            text-align: center;
        }
        .content {
            padding: 20px;
        }
        .tab-menu {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #ddd;
        }
        .tab-menu a {
            margin: 0 15px;
            text-decoration: none;
            color: #333;
            padding: 10px 20px;
            border-bottom: 2px solid transparent;
        }
        .tab-menu a.active {
            border-bottom: 2px solid #333;
            font-weight: bold;
        }
        .content-header {
            margin-bottom: 20px;
        }
        .content-header h1 {
            font-size: 2em;
            margin: 0 0 10px 0;
        }
        .search-box {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }
        .search-box input[type="text"] {
            padding: 10px;
            width: 200px;
            border: 1px solid #ccc;
            margin-right: 5px;
        }
        .search-box button {
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #333;
            color: #fff;
            cursor: pointer;
        }
        .exhibition-list {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        .exhibition-item {
            width: 30%;
            text-align: center;
            margin-bottom: 20px;
        }
        .exhibition-item img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 20px;
            border-style : ridge;
            box-shadow: 0 0 10px gray;
            opacity: 0.4;
        }
        .exhibition-item h2 {
            font-size: 1.5em;
            margin: 10px 0;
        }
        .exhibition-item p {
            font-size: 1em;
            line-height: 1.5;
            margin-bottom: 10px;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
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
        .search-box>input { border-radius: 20px;}
        .search-box>button { border-radius: 20px;}

    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="container">
    <div class="content">
        <div class="tab-menu">
            <a href="onDisplay.do">현재전시</a>
            <a href="upcomingDisplay.do">예정전시</a>
            <a href="offDisplay.do" class="active">지난전시</a>
        </div>
        <div class="content-header">
            <h1>마감된 전시</h1>
        </div>
        <div class="search-box">
            <input type="text" placeholder="검색어를 입력하세요" />
            <button>검색</button>
        </div>
        <div class="exhibition-list">
            <div class="exhibition-item">
                <img src="resources/images/display1.jpg" alt="전시 이미지 1">
                <h2>[마감 전시] 김민수 <br>展 PAST MEMORIES</h2>
                <p>2023-12-01(Fri) ~ 2023-12-15(Fri)</p>
            </div>
            <div class="exhibition-item">
                <img src="resources/images/display2.jpg" alt="전시 이미지 2">
                <h2>[마감 전시] 이현수 <br>展 FORGOTTEN TIME</h2>
                <p>2024-01-05(Thu) ~ 2024-01-20(Fri)</p>
            </div>
            <div class="exhibition-item">
                <img src="resources/images/img4.jpg" alt="전시 이미지 3">
                <h2>[마감 전시] 박지영 <br>展 SILENT ECHOES</h2>
                <p>2024-03-10(Sun) ~ 2024-03-25(Mon)</p>
            </div>
        </div>
        <div class="pagination">
            <a href="#" class="prev">«</a>
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#" class="next">»</a>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />

</body>
</html>
