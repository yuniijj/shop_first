package first.notice.board.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.board.service.BoardService;
import first.common.common.CommandMap;

@Controller
public class NoticeBoardController {
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	@RequestMapping(value="/board/openNoticeBoardList.do")
    public ModelAndView openBoardList(Map<String,Object> commandMap) throws Exception{ 
		ModelAndView mv = new ModelAndView(".mainTiles/board/noticeList"); 
				
		return mv; 
	} 	
	
	@RequestMapping(value="/board/selectNoticeBoardList.do")
	public ModelAndView selectBoardList(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		List<Map<String,Object>> list = boardService.selectNoticeBoardList(commandMap.getMap());
		mv.addObject("list", list);
		if(list.size() > 0){
			mv.addObject("TOTAL", list.get(0).get("TOTAL_COUNT"));
		}
		else{
			mv.addObject("TOTAL", 0);
		}
		
		return mv;
	}
	
	/*
	 * @RequestMapping(value = "/sample/testMapArgumentResolver.do") public
	 * ModelAndView testMapArgumentResolver(CommandMap commandMap) throws Exception
	 * {
	 * 
	 * ModelAndView mv = new ModelAndView("");
	 * 
	 * if (commandMap.isEmpty() == false) { Iterator<Entry<String, Object>> iterator
	 * = commandMap.getMap().entrySet().iterator(); Entry<String, Object> entry =
	 * null; while (iterator.hasNext()) { entry = iterator.next();
	 * log.debug("key : " + entry.getKey() + ", value : " + entry.getValue()); } }
	 * return mv; }
	 */

	@RequestMapping(value = "/board/openNoticeBoardWrite.do")
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView(".mainTiles/board/noticeWrite");
		
		return mv;
	}	

	@RequestMapping(value = "/board/insertNoticeBoard.do")
	public ModelAndView insertBoard(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/board/openNoticeBoardList.do");
		
		boardService.insertBoard(commandMap.getMap(), request);
		
		return mv;
	}

	@RequestMapping(value = "/board/openNoticeBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView(".mainTiles/board/noticeDetail");
		
		Map<String, Object> map = boardService.selectBoardDetail(commandMap.getMap());
		
		mv.addObject("map", map.get("map"));
		mv.addObject("list", map.get("list"));

		mv.addObject("commentList", map.get("commentList"));
		
		return mv; 
		
		} 
	
	@RequestMapping(value = "/board/openNohitNoticeBoardDetail.do")
	public ModelAndView openNohitBoardDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView(".mainTiles/board/noticeDetail");
		
		Map<String, Object> map = boardService.selectNohitBoardDetail(commandMap.getMap());
		
		mv.addObject("map", map.get("map"));
		mv.addObject("list", map.get("list"));

		mv.addObject("commentList", map.get("commentList"));	
			
		return mv; 
		
		} 		
	
	@RequestMapping(value="/board/openNoticeBoardUpdate.do")
	public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView(".mainTiles/board/noticeUpdate");
		
		Map<String,Object> map = boardService.selectNohitBoardDetail(commandMap.getMap());
		
		mv.addObject("map", map.get("map")); 
		mv.addObject("list", map.get("list"));
		
		return mv;
	}

	@RequestMapping(value="/board/updateNoticeBoard.do")
	public ModelAndView updateBoard(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/board/openNoticeBoardList.do");
		
		boardService.updateBoard(commandMap.getMap(), request);
		
		mv.addObject("BOARD_KIND", commandMap.get("BOARD_KIND"));
		mv.addObject("BOARD_IDX", commandMap.get("BOARD_IDX"));
			
		return mv;
	}		
		
	@RequestMapping(value = "/board/deleteNoticeBoard.do")
	public ModelAndView deleteBoard(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/board/openNoticeBoardList.do");
		boardService.deleteBoard(commandMap.getMap());
		return mv;
	}
	
	/* 댓글컨트롤러 */	
	@ResponseBody
	@RequestMapping(value = "/board/openCommentNoticeBoardList.do", method = RequestMethod.GET)
	public ModelAndView openCommentBoardList(@RequestParam("n") int BOARD_IDX, @RequestParam("m") int BOARD_KIND, CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		commandMap.getMap().put("BOARD_KIND", BOARD_KIND);
		commandMap.getMap().put("BOARD_IDX", BOARD_IDX);
		
		List<Map<String,Object>> list = boardService.selectCommentBoardList(commandMap.getMap());
		mv.addObject("list", list);
		
		return mv; 
	} 	
	
	@RequestMapping(value="/board/selectCommentNoticeBoardList.do")
	public ModelAndView selectCommentBoardList(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		List<Map<String,Object>> list = boardService.selectCommentBoardList(commandMap.getMap());
		
		if(list.size() > 0){
			mv.addObject("TOTAL", list.get(0).get("TOTAL_COUNT"));
		}
		else{
			mv.addObject("TOTAL", 0);
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/board/insertCommentNoticeBoard.do")
	public ModelAndView insertCommentBoard(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/board/openNohitNoticeBoardDetail.do");
		
		boardService.insertCommentBoard(commandMap.getMap());
		
		mv.addObject("BOARD_KIND", commandMap.get("BOARD_KIND"));
		mv.addObject("BOARD_IDX", commandMap.get("BOARD_IDX"));
		
		return mv;
	}
	
	@RequestMapping(value="/board/updateCommentNoticeBoard.do")
	public ModelAndView updateCommentBoard(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/board/openNohitNoticeBoardDetail.do");
		
		commandMap.put("COMMENT_IDX", commandMap.get("COMMENT_IDX"));
    	commandMap.put("MEMBER_ID", commandMap.get("MEMBER_ID"));
		
		boardService.updateCommentBoard(commandMap.getMap());

		mv.addObject("BOARD_KIND", commandMap.get("BOARD_KIND"));
		mv.addObject("BOARD_IDX", commandMap.get("BOARD_IDX"));
	
		return mv;
	}		
		
	@RequestMapping(value = "/board/commentNoticeBoardDelete.do")
	public ModelAndView deleteCommentBoard(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/board/openNohitNoticeBoardDetail.do");
		
		commandMap.put("COMMENT_IDX", commandMap.get("COMMENT_IDX"));
    	commandMap.put("MEMBER_ID", commandMap.get("MEMBER_ID"));
		
		boardService.deleteCommentBoard(commandMap.getMap());
		
		mv.addObject("BOARD_KIND", commandMap.get("BOARD_KIND"));
		mv.addObject("BOARD_IDX", commandMap.get("BOARD_IDX"));
		
		return mv;
	}
	
}

