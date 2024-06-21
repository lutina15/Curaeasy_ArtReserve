<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        
        
    
    <meta charset="UTF-8">
    <title>리뷰 상세</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .content-header h1 {
            font-size: 2em;
            margin: 0;
        }
        .review-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .exhibition-item {
            width: 100%;
        }
        .exhibition-item img {
            width: 100%;
            height: auto;
            object-fit: cover;
        }
        .review-content {
            padding-left: 5%;
            width: 70%;
            margin-top: 40px;
        }
        .review-content h2 {
            font-size: 1.8em;
            margin-bottom: 20px;
        }
        .review-content img {
            /* width: 100%; */
            /* height: auto; */
            object-fit: cover;
            margin-bottom: 20px;
        }
        .review-content p {
            font-size: 1em;
            line-height: 1.5;
        }
        .back-to-list {
            text-align: center;
            margin-top: 20px;
        }
        .back-to-list a {
            text-decoration: none;
            color: #fff;
            background-color: #333;
            padding: 10px 20px;
            border-radius: 5px;
        }
        hr {
            border: 0;
            border-top: 2px solid #ccc;
            margin: 20px 0;
        }



        #comment-list h5{
            display:inline;
        }
        
        #comment-list img{
            width: 30px;
            height: 30px;
            float: right;
        }

        #comment-list img:hover{
            cursor: pointer;
        }

        .dropdown-content {
            display: none;
            float: right;
            position: relative;
            background-color: #f1f1f1;
            min-width: 20px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        

        

    </style>

    <!-- jQuery UI CSS -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

    <!-- jQuery UI 라이브러리 js -->
    <script src="https://raw.githubusercontent.com/jquery/jquery-ui/main/ui/i18n/datepicker-ko.js"></script>

    
    </style>

</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="container">
    <div class="content">
        <div class="review-info">
            <div class="exhibition-item">
                <h2>제목</h2>
                <!-- <img src="resources/display/${requestScope.list[0].changeName}" alt="전시 이미지"> -->
                
                <div style="display: inline; float: left;">
                    작성자
                </div>
                <div style="display: inline; float: right;">
                    작성일
                </div>
            </div>
        </div>
        <div class="review-content">
            <img src="resources/display/${ item.changeName }" alt="리뷰사진">
            <p>
                서울 예술의 전당 전시에 비해 전체 관람객의 수는 적었지만 윤이상국제음악콩쿨과 함께 한다는 의미도 있었던 전시였습니다. 통영이 국내에서 손꼽히는 관광지 중의 한 곳이라 여러 지방에서 관람객이 오셔서 전라도에서도 이런 전시를 해달라는 분도 계셨고 1회부터 다 참석하셨다는 분도 계셨습니다.
                
                개인적인 성과라면 윤이상국제음악콩쿨 심사위원 중 한분이고 1990년 인디애나폴리스 국제 바이올린 콩쿨 우승자인 바이올리니스트 파벨 베르만(Pavel Berman, 스위스 루가노 스비체라 이탈리아나 콘서바토리 교수)씨가 전시된 악기 중 하나를 골라 콩쿨 기간동안 사용했는데 마침 금년에 유튜브에 제작영상(Violinmaker – noframe)을 올리기 위해 만들었던 악기가 선택되었습니다.
                
            </p>
        </div>
        <hr>
        <div id="form-commentInfo">
            <div id="comment-count" style="margin-left: 10px;">댓글 <span id="count">0</span></div>
                <c:choose >
                    <c:when test="${empty sessionScope.loginUser}">
                        <div id="comment-textarea" style="margin-top: 10px;">
                            <textarea class="form-control comment-input" name="" placeholder="로그인 후 댓글 작성 가능합니다." rows="3" style="resize: none; width: 90%; display: inline-block; vertical-align: middle;" disabled></textarea>
                            <button class="btn btn-primary" id="submit" style="height: 100%;" disabled>등록</button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div id="comment-textarea" style="margin-top: 10px;">
                            <textarea class="form-control comment-input" name="" placeholder="댓글을 입력해 주세요." rows="3" style="resize: none; width: 90%; display: inline-block; vertical-align: middle;"></textarea>
                            <button class="btn btn-primary" id="submit" style="height: 100%;" onclick="insertReply(this)">등록</button>
                        </div>
                    </c:otherwise>
                </c:choose>
            <div id="comment-list">
                
            </div>
        </div>
        <div class="back-to-list">
            <a href="onDisplay.do">목록으로 가기</a>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />

<script>
    $(function() {
        searchReplyList();
    });

    function clickEdit(e) {
        let $com = $(e).parents("div.comment");
        let content = $com.children("p").text();

        let $textarea = $("#comment-textarea").clone();
        $textarea.children("textarea").removeClass("comment-input").addClass("comment-edit").val(content);
        $textarea.children("button").attr("onclick", "updateReply(this);");


        // $textarea.attr(name) = $com.attr(name);
        $com.empty().append("<hr>").append($textarea);
    }
    
    function insertReply(e){
        
        let content = $(".comment-input").val();
        $(".comment-input").val("");
        let memberNo = "${sessionScope.loginUser.memberNo}";
        let reviewNo = "${requestScope.rno}"
        
        if(content.trim().length == 0){
            alert("내용을 입력해 주세요.");
            return false;
        } else {
            $.ajax({
                url: "insertReply.re",
                method: "POST",
                data: {
                    replyContent: content,
                    memberNo : memberNo,
                    reviewNo : reviewNo
                },
                success: function(result) {
                    searchReplyList();
                },
                error: function() {
                    console.log("댓글 추가 실패");
                }
            });
        }
    }
    
    function updateReply(e){
        let content = $(e).siblings(".comment-edit").val();
        let replyNo = $(e).parent("div").parent("div").attr("name");
        $(e).siblings(".comment-edit").val("");
        let memberNo = "${sessionScope.loginUser.memberNo}";
        let reviewNo = "${requestScope.rno}"

        if(content.trim().length == 0){
            alert("내용을 입력해 주세요.");
            return false;
        } else {
            $.ajax({
                url: "updateReply.re",
                method: "POST",
                data: {
                    replyContent: content,
                    memberNo : memberNo,
                    reviewNo : reviewNo,
                    replyNo : replyNo
                },
                success: function(result) {
                    searchReplyList();
                },
                error: function() {
                    console.log("댓글 수정 실패");
                }
            });
        }

    }

    function deleteReply(e) {
        let content = $(e).siblings(".comment-edit").val();
        let replyNo = $(e).parent("div").parent("div").attr("name");
        $(e).siblings(".comment-edit").val("");
        let memberNo = "${sessionScope.loginUser.memberNo}";
        let reviewNo = "${requestScope.rno}"

        $.ajax({
            url: "deleteReply.re",
            method: "POST",
            data: {
                replyContent: content,
                memberNo : memberNo,
                reviewNo : reviewNo,
                replyNo : replyNo
            },
            success: function(result) {
                searchReplyList();
            },
            error: function() {
                console.log("댓글 수정 실패");
            }
        });
    }
    
    
    function searchReplyList() {
        const rno = "${requestScope.rno}"
        $("#comment-list").empty();

        $.ajax({
            url: "searchReplyList.do",
            method: "GET",
            data:{
                rno : rno
            },
            success: function(result) {

                if(result.size == 0){
                    return;
                }
                $("#count").text(result.length);
                result.forEach(function(element, index) {
                    
                    let $div = $("<div class='comment'></div>").attr("name", element.replyNo).append($("<hr>"));
                    $div.append($(`<input type='hidden' name='\${element.memberNo}'>`))
                    
                    $div.append($(`<h5>\${element.memberNo} &nbsp;&nbsp;<small class="text-muted">\${element.replyEnrollDate}</small></h5>`));
                    if("${sessionScope.loginUser}" != ""){
                        if($div.children("input").attr("name") == "${sessionScope.loginUser.memberId}"){
                            let $img = ($("<img src='https://www.svgrepo.com/show/491050/meatballs-menu.svg'>"))
                            $img.click(function() {

                                let content = $(this).siblings("p").text();
                                let index = $(this).parent("div").attr("name");

                                let $textarea = $("#comment-textarea").clone().addClass("comment-edit");

                                $(`.comment[name=\${index}] textarea`).val(content);

                                $(`.comment[name=\${index}] .dropdown-content`).toggle(0);
                                
                            })

                                $div.append($img)

                            let $dropdown = $("<div class='dropdown-content'></div>")
                            $dropdown.append("<a href='javascript:void(0);' onclick='clickEdit(this)' class='edit'>수정</a>")
                            $dropdown.append("<br>")
                            $dropdown.append("<a href='javascript:void(0);' onclick='deleteReply(this)'>삭제</a>")
    
                            $div.append($dropdown);
                        }
                        

                    }
                    $div.append($(`<p>\${element.replyContent}</p>`));

                    $div.appendTo($("#comment-list"));
                })
            },
            error: function() {
                console.log("리뷰 조회 ajax 실패")
            }
        });
    }
</script>    

</body>
</html>
