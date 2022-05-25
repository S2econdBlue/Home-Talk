package com.ssafy.vue.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.vue.dto.Board;
import com.ssafy.vue.dto.BoardFileDto;
import com.ssafy.vue.dto.TradeThreadDto;

@Mapper
public interface BoardMapper {
	public List<Board> selectBoard();

	public Board selectBoardByNo(int articleno);

	public int insertBoard(Board board);

	public int updateBoard(Board board);

	public int deleteBoard(int articleno);

	public int insertBoardFileList(List<BoardFileDto> list) throws Exception;

	public List<BoardFileDto> selectBoardFileList(int board_no);

	public BoardFileDto selectBoardFileInformation(@Param("no") int no);

	public String selectBoardFileRealPath(String original_name);

	public int insertTradeThread(TradeThreadDto tradeThreadDto);

	public int insertCommonMaintainItem(List<String> commonMaintainItem);

	public int insertEachFeeItem(List<String> EachFeeItem);

	public TradeThreadDto selectTradeThread(@Param("boardNo") int boardNo);

	public List<String> selectCommonMaintainItem(@Param("boardNo") int boardNo);

	public List<String> selectEachFeeItem(@Param("boardNo") int boardNo);
}