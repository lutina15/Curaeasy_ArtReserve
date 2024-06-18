<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>작가신청</title>
    <style>
        .radio{
          width: 17px; 
          display: inline;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:65%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }
    </style>
</head>
<body>
	    <jsp:include page="../common/header.jsp" />
        <!-- 회원가입 -->
        <div class="content">
            <br><br>
            <div class="innerOuter">
                <h3>작가 신청</h3>
                <hr style="border: 2px solid black;">
                
                <form action="insertArtist.at" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="artistNickName">* 활동명 :</label>
                        <input type="text" class="form-control" id="artistNickName" placeholder="한글 30글자 이내" maxlength="30px" name="artistNickName" required> <br>
                        <div id="checkResult1" style="font-size: 0.8em ;display: none;" ></div>
                        <label for="artistOrdinal">* 기수 : </label> <br>
                        <input type="radio" class="form-radio-input " id="artistOrdinal" name="artistOrdinal" value="2024" required checked> 2024년도 <br>
                         <br>
               
                        <label for="artistApplyTitle">* 신청제목 :</label>
                        <input type="text" class="form-control" id="artistApplyTitle" placeholder="한글 100글자 이내" name="artistApplyTitle" maxlength="100px" required> <br>
                        <label for="artistIntroduce">* 자기소개/설명 :</label>
                        <input type="url" class="form-control" id="artistIntroduce" placeholder="포트폴리오 주소 기입" name="artistIntroduce" maxlength="100px" required> <br>
                        <!-- <textarea class="form-control" rows="5" id="artistIntroduce" name="artistIntroduce" placeholder="한글 100글자 이하" maxlength="100px" required></textarea> -->
                        <br>
                        <label for="">* 프로필이미지 :</label><br>
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5aSSsOYE2kGFloVt8UbHgjAwZ6Z7GaCpbDQ&s" width="200px" alt="프로필이미지" id="artistPreviewImage" class="rounded" >
                        <br><br>
                        <input type="file" class="form-control-file border" id="artistImage" name="upfile" onchange="loadImg(this, 1)" required> <br>
                    </div>
                    <div align="center" id="but">
                        <button type="button" class="btn btn-info" onclick="history.back()">뒤로가기</button>
                        <button type="submit" class="btn btn-primary" disabled>작가 신청하기</button>
                    </div>
                </form>
            </div>
        </div>
         <br><br>
    <jsp:include page="../common/footer.jsp" />
    <script>
    
    $(function() {
		let $artistNickNameInput = $(".form-group input[id=artistNickName]");
		$artistNickNameInput.keyup(checkNickName); 

	});
	function checkNickName() {
		const $NickNameInput = $(".form-group input[id=artistNickName]")
		console.log($NickNameInput.val());
			// > 사용자가 실시간으로 입력한 아이디값을 중복체크 시 요청값으로 넘김
			// 우선 , 아이디값이 최소 5글자 이상으로 입력되었을 때에만
			// ajax 를 요청해서 중복체크 하기!!
			// (유료 DB 제품은 실행하는 쿼리문의 갯수가 몇개냐에 따라 요금제가 지정됨)
				let checkNickName =  $NickNameInput.val();
				// console.log(checkNickName);
			if(checkNickName.length != 0 ){
				// 5글자 이상일때
				// ajxa 로 아이디 중복확인 요청보내기
				let regExp =/^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{0,30}$/;
				$.ajax({
					url : "NickNameCheck.at",
					type : "get",
					data : {
						checkNickName : checkNickName
					},
					success : function(result) {
						if(result == "NNNNN" && regExp.test(checkNickName)){
						$("#checkResult1").text("이미 사용중이거나 이미 등록된 작가의 활동명 입니다. 다시 입력해주세요").show().css("color","red");
						$("#but button[type=submit]").attr("disabled",true)
						}else if(result == "NNNNY" && regExp.test(checkNickName)){
						$("#checkResult1").text("사용 가능한 활동명입니다").show().css("color","green");
						$("#but button[type=submit]").attr("disabled",false)
						}else if(result == "NNNNY" && !regExp.test(checkNickName)){
						$("#checkResult1").text("유효한 활동명이 아닙니다. 다시 입력해주세요.").show().css("color","red");
						$("#but button[type=submit]").attr("disabled",true)
						}
						
					},
					error : function() {
						console.log("ajax 통신 실패");
					}
				
					});
				
			}else {
				// 5글자 미만일 때
				$("#checkResult1").hide(); 
				$("#but button[type=submit]").attr("disabled",true)
			}
		}
	
    
    
	$(function(){
		$("#artistPreviewImage").click(function(){
			$("#artistImage").click();
		});
	});
	
	function loadImg(inputFile, num) {
		if(inputFile.files.length == 1){
			let reader = new FileReader();
			reader.readAsDataURL(inputFile.files[0]);
			reader.onload=function(e){
				switch(num){
				case 1 : $("#artistPreviewImage").attr("src",e.target.result); break
			}
		};
		}else{
			switch(num){
				case 1 : $("#artistPreviewImage").attr("src","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5aSSsOYE2kGFloVt8UbHgjAwZ6Z7GaCpbDQ&s"); break
			}
		}
	};
    </script>
</body>
</html>