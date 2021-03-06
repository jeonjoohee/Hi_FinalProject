package kh.spring.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import kh.spring.dao.ChatDAO;
import kh.spring.dto.Chat_MessageDTO;
import kh.spring.dto.Chat_RoomDTO;
import kh.spring.dto.MemberDTO;

@Service
@Component
public class ChatService {

	@Autowired
	private ChatDAO dao;

	public List<MemberDTO> search(String category, String keyword){
		Map<String,String> param = new HashMap<>();
		param.put("keyword", keyword);
		param.put("category",category );
		return dao.search(param);
	}

	public int searchRoom1(String user1,String user2) {
		Map<String,String> param = new HashMap<>();
		param.put("user1", user1);
		param.put("user2", user2);

		return dao.searchRoom1(param);
	}

	public int searchRoom2(String user1,String user2) {
		Map<String,String> param = new HashMap<>();
		param.put("user1", user1);
		param.put("user2", user2);

		return dao.searchRoom2(param);
	}

	public int createRoom(String user1, String user2) {
		Map<String,String> param = new HashMap<>();
		param.put("user1", user1);
		param.put("user2", user2);

		return dao.createRoom(param);
	}

	public int searchRoomNumber(String user1, String user2) {
		Map<String,String> param = new HashMap<>();
		param.put("user1", user1);
		param.put("user2", user2);

		return dao.searchRoomNumber(param);
	}

	public int searchRoomNumber2(String user1, String user2) {
		Map<String,String> param = new HashMap<>();
		param.put("user1", user1);
		param.put("user2", user2);

		return dao.searchRoomNumber2(param);
	}

	// 채팅 상대방 정보 담기
	public MemberDTO receiver(String email) {
		return dao.receiver(email);
	}
	
	public int messageInsert(Chat_MessageDTO dto) {
		return dao.messageInsert(dto);
	}
	
	public List<Chat_MessageDTO> messageList(int room_number){
		return dao.messageList(room_number);
	}
	
	// 나의 채팅방 리스트
	public List<Chat_RoomDTO> chatListInfo(String login_email){
		return dao.chatListInfo(login_email);
	}
	
	// 채팅방번호로 상대방 정보 찾기
	public Chat_RoomDTO findReceiver(int room_number) {
		return dao.findReceiver(room_number);
	}
	
	// 각 채팅방의 마지막 메세지
	public Chat_MessageDTO lastChat(int room_number) {
		return dao.lastChat(room_number);
	}
}
