package com.ssafy.vue.handler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

public class ChatWebSocketHandler extends TextWebSocketHandler {
	private static final Logger logger = LoggerFactory.getLogger(ChatWebSocketHandler.class);

	private final Map<String, WebSocketSession> webSocketSessions = new HashMap<>();
	private final Map<WebSocketSession, String> webSocketIds = new HashMap<>();

	// 처음 연결 시도될 때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		logger.debug("afterConnectionEstablished session : {}", session);
	}

	// 클라이언트로부터 메세지를 송신했을 때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("message.getPayload() : {}", message.getPayload());

		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, String> jsonMap = objectMapper.readValue(message.toString(),
				new TypeReference<Map<String, String>>() {
				});

		// 메세지에 저장된 송신자 데이터를 map에 put
//		if(webSocketSessions.get(message.getPayload().))
		webSocketSessions.put(jsonMap.get("id"), session);
		webSocketIds.put(session, jsonMap.get("id"));

		for (Entry<String, WebSocketSession> k : webSocketSessions.entrySet()) {
			WebSocketSession crntSession = k.getValue();

			// 일단 모두에게 메세지를 전송
			crntSession.sendMessage(message);
		}
//		for (WebSocketSession webSocketSession : webSocketSessions) {
//			logger.info("webSocketSession : {}", webSocketSession);
//			webSocketSession.sendMessage(message);
//		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		logger.debug("afterConnectionClosed session : {}", session);
		logger.debug("afterConnectionClosed status : {}", status);
		String id = webSocketIds.get(session);
		webSocketSessions.remove(id);
		webSocketIds.remove(session);
	}
}
