package com.ssafy.vue.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.vue.dto.ChatHistoryDto;
import com.ssafy.vue.dto.ChatRoomDto;
import com.ssafy.vue.mapper.ChatMapper;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	ChatMapper chatMapper;

	@Override
	public int GenerateRoom(ChatRoomDto chatRoomDto) {
		return chatMapper.GenerateRoom(chatRoomDto);
	}

	@Override
	public int ChangeAlertState(ChatRoomDto chatRoomDto) {
		return chatMapper.ChangeAlertState(chatRoomDto);
	}

	@Override
	public List<ChatRoomDto> LoadChatRoomList(ChatRoomDto chatRoomDto) {
		return chatMapper.LoadChatRoomList(chatRoomDto);
	}

	@Override
	public int SelectOneRoom(ChatRoomDto chatRoomDto) {
		return chatMapper.SelectOneRoom(chatRoomDto);
	}

	@Override
	public int DeleteRoom(int no) {
		return chatMapper.DeleteRoom(no);
	}

	@Override
	public List<ChatHistoryDto> GetRoomChatHistory(int room_no) {
		return chatMapper.GetRoomChatHistory(room_no);
	}
}
