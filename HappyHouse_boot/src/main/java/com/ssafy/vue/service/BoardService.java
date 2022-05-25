package com.ssafy.vue.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ssafy.vue.dto.Board;
import com.ssafy.vue.dto.BoardFileDto;

public interface BoardService {
	public List<Board> retrieveBoard();

	public Board detailBoard(int articleno);

	public boolean writeBoard(Board board, MultipartHttpServletRequest multipartHttpServletRequest) throws Exception;

	public boolean updateBoard(Board board);

	public boolean deleteBoard(int articleno);

	public List<BoardFileDto> selectBoardFileList(int board_no);

	BoardFileDto selectBoardFileInformation(int no);

	public String selectBoardFileRealPath(String original_name);
}
