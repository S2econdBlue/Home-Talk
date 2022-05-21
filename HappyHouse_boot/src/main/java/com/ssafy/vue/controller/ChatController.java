package com.ssafy.vue.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssafy.vue.dto.ChatRoomDto;
import com.ssafy.vue.service.ChatService;

import io.swagger.annotations.ApiOperation;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@Controller
@RequestMapping("/chat")
public class ChatController {
	private static final Logger logger = LoggerFactory.getLogger(ObserveController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private ChatService chatService;

	@ApiOperation(value = "상담 버튼 클릭 시 채팅방 개설 및 알람 설정", response = List.class)
	@GetMapping("{RequestAdvice}")
	public ResponseEntity<String> retrieveBoard(@RequestBody ChatRoomDto chatRoomDto) throws Exception {

		// 이미 방이 개설되었는지 확인
		if (chatService.SelectOneRoom(chatRoomDto) == 0) {
			chatService.GenerateRoom(chatRoomDto);
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} else
			return new ResponseEntity<String>(FAIL, HttpStatus.FOUND);
	}
}
