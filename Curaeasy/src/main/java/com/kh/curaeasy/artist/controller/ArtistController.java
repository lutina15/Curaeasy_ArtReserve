package com.kh.curaeasy.artist.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.kh.curaeasy.artist.model.service.ArtistService;
import com.kh.curaeasy.artist.model.vo.Artist;
import com.kh.curaeasy.member.model.vo.Member;
import com.kh.curaeasy.review.model.vo.Review;

@Controller
public class ArtistController {
	
	 @Autowired private ArtistService artistService;
	
	@RequestMapping("introduce.do")
	public String artistInfo(Model model) {
		
		// 입주작가 페이지에 표시할 작가 리스트를 가져오기
		ArrayList<Artist> list = artistService.selectArtistList();
		model.addAttribute("list", list);
		model.addAttribute("jsonList", new Gson().toJson(list));
		
		return "artist/artistIntroduceView";
	}
	
	@RequestMapping(value = "enrollForm.at", produces = "text/html; charset=UTF-8")
	public String EnrollFormArtist( HttpSession session) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		int selectArtistNo = artistService.selectArtistNo(memberNo);
		
		if(selectArtistNo>0) {
			session.setAttribute("alertMsg", "이미 작가시거나 작가 신청 대기중 입니다.");
			return "member/myPage";
		}else {
			return "artist/enrollFormArtist";
		}
		
		
		
	}
	@ResponseBody
	@GetMapping(value="NickNameCheck.at", produces = "text/html; charset=UTF-8")
	public String idCheck(String checkNickName) {
		int count = artistService.NickNameCheck(checkNickName);
		return (count>0)? "NNNNN" : "NNNNY";
	}
	
	@PostMapping(value = "insertArtist.at",  produces = "text/html; charset=UTF-8")
	public String insertArtist(MultipartFile upfile,Artist at, Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
//		System.out.println(upfile);
		String changImgName = savePath(upfile, session);		
		at.setArtistImage(changImgName);
		at.setMemberNo(((Member)session.getAttribute("loginUser")).getMemberNo());
		int result = artistService.insertArtist(at);
		
		
		if (result > 0) { // 성공
			// 일회성 알람문구를 담아 메인 페이지로 url 재요청
			model.addAttribute("eventMsg", "작가 신청에 성공 하였습니다.");
			return "/common/eventPage";
		} else { // 실패
			
			// 에러문구 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "작가 신청에 실패하셨습니다");
			// /WEB-INF/views/common/errorPage.jsp
			return "/common/errorPage";

		}
	}
	public String savePath(MultipartFile upfile, HttpSession session) {
		// 예) "bono.jpg" --> "2024052116143012345.jpg"
		// 1.원본 파일명 뽑아오기
		System.out.println(upfile);
		String originName = upfile.getOriginalFilename(); // "bono.jpg"
		
		// 2. 시간형식으로 문자열로 뽑아내기
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		// "20240521161430" (년월일시분초)
		
		// 3. 뒤에 붙을 5자리 랜덤수 얻어내기
		int ranNum = (int)(Math.random()*90000+10000);
		
		// 4. 원본파일명으로부터 확장자명 뽑기
		String ext =originName.substring(originName.lastIndexOf(".")); // ".jpg"
		
		// 5. 2~4 까지 모두 이어 붙이기
		String changName = currentTime + ranNum +ext;
		// 6. 업로드하고자 하는 물리적인 서버의 경로 알아내기
		// (webapp/resources/uploadFiles/~~)
		String savePath = session.getServletContext()
								 .getRealPath("/resources/artistProfileImgs/");
		// 7. 경로와 수정파일명 합체 후 파일을 업로드해주기
		// > MultipartFile 객체가 제공하는
		// transforTo 메소드를 이용함
		try {
			upfile.transferTo(new File(savePath+changName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return changName;
	}
	@RequestMapping(value = "updateForm.at", produces = "text/html; charset=UTF-8")
	public String UpdateFormArtist( Model model,  HttpSession session) {
		
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		Artist list = artistService.ArtistDate(memberNo);
		
		if(list == null) {
			model.addAttribute("errorMsg", "올바르지 않은 접근입니다");
			// /WEB-INF/views/common/errorPage.jsp
			return "/common/errorPage";
		}else {
			model.addAttribute("list", list);
			return "artist/updateArtist";
		}
		
		
		
	}
	@PostMapping(value = "updateArtist.at",  produces = "text/html; charset=UTF-8")
	public String updateArtist(MultipartFile reUpfile,Artist at, Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
	
		
		
		int memberNo= ((Member)session.getAttribute("loginUser")).getMemberNo();
		at.setMemberNo(memberNo);
		String originalFile = at.getArtistImage();
		
		if(reUpfile.getSize() == 0) {
			
			Artist list =artistService.ArtistDate(memberNo);
			at.setArtistImage(list.getArtistImage());
		}else {
			String realPath= "/resources/artistProfileImgs"+originalFile;
			new File(realPath).delete();
			
			String changImgName = savePath(reUpfile, session);	
			at.setArtistImage(changImgName);
	
		}
		int result = artistService.updateArtist(at);
		if (result > 0) { // 성공
			// 일회성 알람문구를 담아 메인 페이지로 url 재요청
			model.addAttribute("eventMsg", "작가 정보 변경에 성공 하였습니다.");
			return "/common/eventPage";
		} else { // 실패
			
			// 에러문구 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "작가 정보 변경에 실패하셨습니다");
			// /WEB-INF/views/common/errorPage.jsp
			return "/common/errorPage";

		}
		
		
		
	}
}




