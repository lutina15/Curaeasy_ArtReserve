<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예정 전시</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
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
        .content-header {
            margin-bottom: 20px;
        }
        .content-header h1 {
            font-size: 2em;
            margin: 0 0 10px 0;
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
        .no-exhibition {
            text-align: center;
            font-size: 1.5em;
            color: #777;
            padding: 50px 0;
        }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="container">
    <div class="content">
        <div class="tab-menu">
            <a href="onDisplay.do">현재전시</a>
            <a href="upcomingDisplay.do" class="active">예정전시</a>
            <a href="offDisplay.do">과거전시</a>
        </div>
        <div class="content-header">
            <h1>예정 전시</h1>
        </div>
        <div class="search-box">
            <input type="text" placeholder="검색어를 입력하세요" />
            <button>검색</button>
        </div>
        <div class="exhibition-list">
            <div class="exhibition-item">
                <img src="resources/images/display1.jpg" alt="전시 이미지 1">
                <h2>[예정 전시] 김준수 展 FUTURE LANDSCAPES</h2>
                <p>2024-07-01(Mon) ~ 2024-07-10(Wed)</p>
            </div>
            <div class="exhibition-item">
                <img src="resources/images/display1.jpg" alt="전시 이미지 2">
                <h2>[예정 전시] 박민희 展 DREAMSCAPES</h2>
                <p>2024-08-15(Fri) ~ 2024-08-25(Sun)</p>
            </div>
            <div class="exhibition-item">
                <img src="resources/images/display1.jpg" alt="전시 이미지 3">
                <h2>[예정 전시] 이성호 展 THE UNKNOWN</h2>
                <p>2024-09-01(Sun) ~ 2024-09-10(Tue)</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />

</body>
</html>