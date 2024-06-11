<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
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
        .notice-list {
            width: 100%;
            border-collapse: collapse;
        }
        .notice-list th, .notice-list td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .notice-list th {
            background-color: #f2f2f2;
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
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="container">
    <div class="content">
        <div class="content-header">
            <h1>공지사항</h1>
        </div>
        <div class="search-box">
            <input type="text" placeholder="검색어를 입력하세요" />
            <button>검색</button>
        </div>
        <table class="notice-list">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>제목</th>
                    <th>등록일</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><b class="noti_b">공지</b></td>
                    <td>
                        <a href="viewa47b.html?no=545" class="subject">
                            [공고 제2024-102호] 2024 인천아트플랫폼 정기대관(6월~12월) 결과 공고
                        </a>
                    </td>
                    <td>2024-05-28</td>
                </tr>
                <tr>
                    <td><b class="noti_b">공지</b></td>
                    <td>
                        <a href="view1c4c.html?no=544" class="subject">
                            [공고 제2024-86호] 2024 인천아트플랫폼 보안인력 운영 용역 소액 수의 견적 제출 안내 공고
                        </a>
                    </td>
                    <td>2024-05-21</td>
                </tr>
                <!-- 추가적인 공지사항 항목들 -->
            </tbody>
        </table>
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
