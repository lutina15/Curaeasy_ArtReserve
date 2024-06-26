package com.kh.curaeasy.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.curaeasy.common.model.vo.PageInfo;
import com.kh.curaeasy.common.template.Pagination;
import com.kh.curaeasy.display.model.service.DisplayService;
import com.kh.curaeasy.member.model.vo.Member;
import com.kh.curaeasy.reserve.model.vo.Reserve;
import com.kh.curaeasy.review.model.service.ReviewService;
import com.kh.curaeasy.review.model.vo.Reply;
import com.kh.curaeasy.review.model.vo.Review;

@Controller
public class ReviewController {
	@Autowired private ReviewService reviewService;
	@Autowired private DisplayService displayService;
	
	private Map<String, String> ReviewListData = Collections.synchronizedMap(new HashMap<>());
	@GetMapping(value = "review.do", produces = "text/html; charset=UTF-8")
	public String reviewList(@RequestParam(value ="cpage",defaultValue = "1") int currentPage, Model model, HttpSession session, 
			@RequestParam(value ="category",defaultValue = "")  String category, @RequestParam(value ="search",defaultValue = "")  String search ) {
		
		
		int userNo=0;
		
		if( ((Member)session.getAttribute("loginUser")) != null) {
			userNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		}
		int ticket=  reviewService.ticket(userNo);
		
		
		ArrayList<Review> list = null;
		PageInfo pi  = null;
		if(category.equals("")) {
			int listCount = reviewService.selectListAllCount(search);
			// System.out.println(listCount);
			int pageLimit = 10;
			int boardLimit = 5;
			// PageInfo 객체 만들어 내기
			 pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			 list = reviewService.selectAllList(pi,search);
		}else if(category.equals("title")) {
			int listCount = reviewService.selectTitleListCount(search);
			// System.out.println(listCount);
			int pageLimit = 10;
			int boardLimit = 5;
			// PageInfo 객체 만들어 내기
			pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			list = reviewService.selectTitleList(pi,search);
		}else if(category.equals("writer")) {
			int listCount = reviewService.selectWriterListCount(search);
			// System.out.println(listCount);
			int pageLimit = 10;
			int boardLimit = 5;
			// PageInfo 객체 만들어 내기
			pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			list = reviewService.selectWriterList(pi,search);
		}
		
		

		
		model.addAttribute("ticket",ticket);
		model.addAttribute("list",list);
		model.addAttribute("category",category);
		model.addAttribute("search",search);
		model.addAttribute("pi",pi);
		
		return "review/reviewListView";
	}
	
	@GetMapping(value = "myReviewList.re", produces = "text/html; charset=UTF-8")
	public String myReviewList( Model model, HttpSession session) {
		
		int userNo= ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		ArrayList<Review> list = reviewService.myReviewList(userNo);
		
		/*
		 * for (Review review : list) { System.out.println(review); }
		 */
		model.addAttribute("list",list);
		return "review/myReviewList";
	}
	
	@GetMapping(value = "reviewEnrollForm.re", produces = "text/html; charset=UTF-8")
	public String enrollFormReview( Model model, HttpSession session) {
		
		int userNo= ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		ArrayList<String> list = reviewService.myNoReviewList(userNo);
		
		/*
		 * for (String String : list) { System.out.println(String); }
		 */
		model.addAttribute("list",list);
		return "review/enrollFormReview";
	}
	@PostMapping(value = "insertReview.re", produces = "text/html; charset=UTF-8")
	public String insertReview( MultipartFile upfile,Review r, String displayName ,Model model, HttpSession session) {
		
		//System.out.println(upfile);
		String changImgName = savePath(upfile, session);	
		r.setReviewImage(changImgName);
		String setTitle = "["+displayName+"]"+r.getReviewTitle();
		r.setReviewTitle(setTitle);
		int userNo= ((Member)session.getAttribute("loginUser")).getMemberNo();
		r.setMemberNo(""+userNo);
		 r.setReviewContent(r.getReviewContent().replace("\\r\\n", "<br>"));

		ReviewListData.put("userNo", ""+userNo);
		ReviewListData.put("displayName", displayName);
		int list = reviewService.insertReview(r,ReviewListData);
		
		
		if(list == 0) {
			
			model.addAttribute("errorMsg", "후기 작성에 실패 했습니다");
			return "/common/errorPage";
			
		}else {
			session.setAttribute("alertMsg", "후기 작성에 성공 했습니다");
			return "redirect:/review.do";
		}
		
	}
	
	@PostMapping(value = "updateReviewForm.re", produces = "text/html; charset=UTF-8")
	public String updateReviewForm(int rno,Model model, HttpSession session){
		
		int userNo= ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		Review r=new Review();
		r.setReviewNo(rno);
		r.setMemberNo(""+userNo);
		
		Review list =reviewService.updateData(r);
		
	
		
		if(list == null) {
			model.addAttribute("errorMsg", "잘못된 접근입니다");
			return "/common/errorPage";
		}else {
			String Title = list.getReviewTitle();
			String displayName = Title.substring(Title.indexOf("[")+1,(Title.indexOf("]")));
			String reviewTitle = Title.substring(Title.indexOf("]")+1);
			
			model.addAttribute("list",list);
			model.addAttribute("displayName",displayName);
			model.addAttribute("reviewTitle",reviewTitle);
			return "review/updateReviewForm";
		}
		
		
		
	}
	
	@PostMapping(value = "updateReview.re", produces = "text/html; charset=UTF-8")
	public String updateReview( MultipartFile reUpfile,Review r, String displayName ,Model model, HttpSession session) {
		
		int userNo= ((Member)session.getAttribute("loginUser")).getMemberNo();
		r.setMemberNo(""+userNo);
		String originalFile = r.getReviewImage();
		
		String setTitle = "["+displayName+"]"+r.getReviewTitle();
		r.setReviewTitle(setTitle);
		
		
		if(reUpfile.getSize() == 0) {
			
			Review list =reviewService.updateData(r);
			r.setReviewImage(list.getReviewImage());
		}else {
			String realPath= "/resources/reviewProfileImgs"+originalFile;
			new File(realPath).delete();
			
			String changImgName = savePath(reUpfile, session);	
			r.setReviewImage(changImgName);
	
		}
		int result = reviewService.updateReview(r);
		if(result>0) {
			session.setAttribute("alertMsg", "후기 수정에 성공 했습니다");
			return "redirect:/reviewDetail.do?rno="+r.getReviewNo();
		}else {
			model.addAttribute("errorMsg", "후기 수정에 실패 했습니다");
			return "/common/errorPage";
		}

		
	}
	
	public String savePath(MultipartFile upfile, HttpSession session) {

		//System.out.println(upfile);
		String originName = upfile.getOriginalFilename(); // "bono.jpg"
		

		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

		int ranNum = (int)(Math.random()*90000+10000);
		

		String ext = originName.substring(originName.lastIndexOf(".")); // ".jpg"
		

		String changName = currentTime + ranNum +ext;

		String savePath = session.getServletContext()
								 .getRealPath("/resources/reviewProfileImgs/");

		try {
			upfile.transferTo(new File(savePath+changName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return changName;
	}
	@RequestMapping("reviewDetail.do")
	public ModelAndView selectReview(ModelAndView mv, int rno) {
		
		
		
		
		// rno 파라미터가 없는 경우
		if(rno == 0) {
			mv.addObject("errorMsg", "잘못된 접근입니다.")
			  .setViewName("common/errorPage");
			return mv;
		}else {
			/* System.out.println(rno); */
		reviewService.selectCount(rno);
		Review r = reviewService.selectReview(rno);
		 r.setReviewContent(r.getReviewContent().replace("\\r\\n", "<br>"));
		mv.addObject("rno", rno)
		  .addObject("r", r)
		  .setViewName("review/reviewDetailView");
		return mv;
		}
	}
	
	@RequestMapping(value="searchReplyList.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String searchReplyList(int rno) {
		
		ArrayList<Reply> list = reviewService.selectReplyList(rno);
		
		return new Gson().toJson(list);
	}
	
	@RequestMapping(value="insertReply.re", produces = "text/html; charset=utf-8")
	@ResponseBody
	public String insertReply(Reply r) {
		
		int result = reviewService.insertReply(r);
		
		return String.valueOf(result);
	}
	
	@RequestMapping(value="updateReply.re", produces = "text/html; charset=utf-8")
	@ResponseBody
	public String updateReply(Reply r) {
		
		return String.valueOf(reviewService.updateReply(r));
	}
	
	@RequestMapping(value="deleteReply.re", produces="text/html; charset=utf-8")
	@ResponseBody
	public String deleteReply(Reply r) {
	
		return String.valueOf(reviewService.deleteReply(r));
		
	}
	
	@RequestMapping(value="deleteReview.re")
	public String deleteReview(Review r,int rno, HttpSession session, Model model) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		

		
		r.setMemberNo(""+memberNo);
		r.setReviewNo(rno);
		
		Review r2 = reviewService.selectReview(rno);
		String Title =r2.getReviewTitle();
		String displayName = Title.substring(Title.indexOf("[")+1,(Title.indexOf("]")));
		
		
		//System.out.println(rno);
		System.out.println(displayName);
		
		
		// new 구문 쓰면 sqlSession이 생성안되서 null이됩니다. 
		int displayNo = displayService.selectDisplayNo(displayName);
		System.out.println(displayNo);
		
		Reserve re = new Reserve();
		re.setMemberNo(""+memberNo);
		re.setDisplayNo(""+displayNo);
		int result = reviewService.deleteReview(r,re);
		
		
		if(result>0) {
			session.setAttribute("alertMsg", "삭제 성공 했습니다");
			return "redirect:/review.do";
		}else {
			model.addAttribute("errorMsg", "삭제 실패 했습니다");
			return "/common/errorPage";
		}
		

		
		
	}
	
}
