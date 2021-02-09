package first.board.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import first.board.service.BoardService;
import first.common.common.CommandMap;

@Controller
public class BoardController {
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	@RequestMapping(value="/board/openBoardList.do")
    public ModelAndView openBoardList(Map<String,Object> commandMap) throws Exception{ 
		ModelAndView mv = new ModelAndView("/board/boardList"); 
				
		return mv; 
	} 	
	
	@RequestMapping(value="/board/selectBoardList.do")
	public ModelAndView selectBoardList(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		List<Map<String,Object>> list = boardService.selectBoardList(commandMap.getMap());
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

	@RequestMapping(value = "/board/openBoardWrite.do")
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/board/boardWrite");
		
		return mv;
	}	

	@RequestMapping(value = "/board/insertBoard.do")
	public ModelAndView insertBoard(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/board/openBoardList.do");
		
		boardService.insertBoard(commandMap.getMap(), request);
		
		return mv;
	}

	@RequestMapping(value = "/board/openBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/board/boardDetail");
		
		Map<String, Object> map = boardService.selectBoardDetail(commandMap.getMap());
		
		mv.addObject("map", map.get("map"));
		mv.addObject("list", map.get("list"));
		
		return mv;
	}
	
	@RequestMapping(value="/board/openBoardUpdate.do")
	public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/board/boardUpdate");
		
		Map<String,Object> map = boardService.selectBoardDetail(commandMap.getMap());
		
		mv.addObject("map", map.get("map")); 
		mv.addObject("list", map.get("list"));
		
		return mv;
	}

	@RequestMapping(value="/board/updateBoard.do")
	public ModelAndView updateBoard(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/board/openBoardDetail.do");
		
		boardService.updateBoard(commandMap.getMap(), request);
		
		mv.addObject("BOARD_IDX", commandMap.get("BOARD_IDX"));
	
		return mv;
	}		
		
	@RequestMapping(value = "/board/deleteBoard.do")
	public ModelAndView deleteBoard(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/board/openBoardList.do");
		boardService.deleteBoard(commandMap.getMap());
		return mv;
	}
	
}

