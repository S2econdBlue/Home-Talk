package com.ssafy.vue.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ssafy.vue.dto.Board;
import com.ssafy.vue.dto.BoardFileDto;
import com.ssafy.vue.service.BoardService;

import io.swagger.annotations.ApiOperation;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/board")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private BoardService boardService;

	@ApiOperation(value = "모든 게시글의 정보를 반환한다.", response = List.class)
	@GetMapping
	public ResponseEntity<List<Board>> retrieveBoard() throws Exception {
//    	List<Board> returnBoardList = boardService.retrieveBoard();
//    	for(int i =0; i < returnBoardList.size();i++) {
//    		returnBoardList.get(i).toString()
//    	}
//		logger.debug("retrieveBoard - 호출 {}" , boardService.retrieveBoard().toArray().toString());
		return new ResponseEntity<List<Board>>(boardService.retrieveBoard(), HttpStatus.OK);
	}

	@ApiOperation(value = "글번호에 해당하는 게시글의 정보를 반환한다.", response = Board.class)
	@GetMapping("{articleno}")
	public ResponseEntity<Board> detailBoard(@PathVariable int articleno) {
		logger.debug("detailBoard - 호출");
		Board board = boardService.detailBoard(articleno);
		board.setFileList(boardService.selectBoardFileList(articleno));
		return new ResponseEntity<Board>(board, HttpStatus.OK);
	}

	@ApiOperation(value = "게시글마다 이미지를 저장. 그리고 DB입력 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = ResponseEntity.class)
	@PostMapping
	public ResponseEntity<String> insertThreadImage(Board board, MultipartHttpServletRequest multipartHttpServletRequest)
			throws Exception {
//		multipartHttpServletRequest = 업로드할 파일에 대한 정보를 가지고 있음
		System.out.println("multipartHttpServletRequest : " + multipartHttpServletRequest.getFileNames());

//		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
//		String name;
//		while (iterator.hasNext()) {
//			name = iterator.next();
//			logger.debug("file tag name : {}", name);
//			List<MultipartFile> list = multipartHttpServletRequest.getFiles(name);
//
//			for (MultipartFile multipartFile : list) {
//				logger.debug("start file information");
//				logger.debug("file name : " + multipartFile.getOriginalFilename());
//				logger.debug("file size : " + multipartFile.getSize());
//				logger.debug("file content type : " + multipartFile.getContentType());
//				logger.debug("end file information.\n");
//				System.out.println("file name : " + multipartFile.getOriginalFilename());
//				System.out.println("file size : " + multipartFile.getSize());
//				System.out.println("file content type : " + multipartFile.getContentType());
//			}
//		}

		logger.debug("insertThreadImage - 호출 {}", board.toString());
		if (boardService.writeBoard(board, multipartHttpServletRequest)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@ApiOperation(value = "글번호에 해당하는 게시글의 정보를 수정한다. 그리고 DB수정 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PutMapping("{articleno}")
	public ResponseEntity<String> updateBoard(@RequestBody Board board) {
		logger.debug("updateBoard - 호출");
		logger.debug("" + board);

		if (boardService.updateBoard(board)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@ApiOperation(value = "글번호에 해당하는 게시글의 정보를 삭제한다. 그리고 DB삭제 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@DeleteMapping("{articleno}")
	public ResponseEntity<String> deleteBoard(@PathVariable int articleno) {
		logger.debug("deleteBoard - 호출");
		if (boardService.deleteBoard(articleno)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@GetMapping("download/{no}")
	public void downloadBoardFile(@PathVariable int no, HttpServletResponse response) throws IOException {
		System.out.println("downloadBoardFile : no  = " + no);

		BoardFileDto boardFileDto = boardService.selectBoardFileInformation(no);

		if (ObjectUtils.isEmpty(boardFileDto) == false) {
			String fileName = boardFileDto.getOriginal_name();

			byte[] files = FileUtils.readFileToByteArray(new File(boardFileDto.getSave_path()));
			response.setContentType("application/octet-stream");
			response.setContentLength(files.length);
			response.setHeader("Content-Disposition",
					"attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");
			response.getOutputStream().write(files);
			response.getOutputStream().flush();
			response.getOutputStream().close();

		}
	}

	@GetMapping("image/{original_name}")
	public ResponseEntity<byte[]> imgLoad(@PathVariable String original_name, HttpServletRequest request) throws Exception{
//		String absolutePath = request.getSession().getServletContext().getRealPath("/");
		String absolutePath = "C:\\SSAFY\\관통\\final\\HappyHouse_boot";
		String save_path = boardService.selectBoardFileRealPath(original_name);
		System.out.println(absolutePath+save_path);
		InputStream imageStream = new FileInputStream(absolutePath+"\\"+save_path);
		byte[] imageByteArray = IOUtils.toByteArray(imageStream);
		imageStream.close();
		return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
		
	}
}