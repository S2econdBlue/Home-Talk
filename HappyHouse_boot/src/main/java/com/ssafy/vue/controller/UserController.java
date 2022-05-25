package com.ssafy.vue.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.vue.dto.UserInfoDto;
import com.ssafy.vue.service.UserService;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/user")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private UserService userService;

//	회원 목록을 가지고 userlist로 이동
	@GetMapping("/userlist")
	public ResponseEntity<List<UserInfoDto>> userinfo() throws SQLException {
		List<UserInfoDto> userList = userService.ListAllUser();
		return new ResponseEntity<List<UserInfoDto>>(userList, HttpStatus.OK);
	}

//	회원 목록을 가지고 userlist로 이동
	@PostMapping("/login")
	public ResponseEntity<UserInfoDto> login(@RequestBody HashMap<String, Object> map) throws SQLException {
		UserInfoDto userInfoDto = new UserInfoDto();
		userInfoDto.setId((String) map.get("userid"));
		userInfoDto.setPw((String) map.get("userpw"));

		UserInfoDto user = userService.GetUser(userInfoDto);
		return new ResponseEntity<UserInfoDto>(user, HttpStatus.OK);
	}

	@PostMapping("/regist")
	public ResponseEntity<String> RegisterMember(@RequestBody HashMap<String, Object> map) throws SQLException {
		UserInfoDto userInfoDto = new UserInfoDto();
		userInfoDto.setId((String) map.get("id"));
		userInfoDto.setPw((String) map.get("pw"));
		userInfoDto.setEmail((String) map.get("email"));
		userInfoDto.setAge((Integer) map.get("age"));
		userInfoDto.setName((String) map.get("name"));
		try {
			int rslt = userService.RegisterMember(userInfoDto);
			if (rslt == 1)
				return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
			else
				return new ResponseEntity<String>(FAIL, HttpStatus.CREATED);
		}catch(Exception e) {
			return new ResponseEntity<String>(FAIL, HttpStatus.CREATED);
		}
	}

//	@GetMapping("/userinfo")
//	public ResponseEntity<UserInfoDto> userinfo(HttpSession session) throws SQLException {
//		return new ResponseEntity<UserInfoDto>(user, HttpStatus.OK);
//	}

	@PostMapping("/UpdateUser")
	public ResponseEntity<String> UpdateUser(UserInfoDto userInfoDto, HttpSession session) throws SQLException {
		logger.debug("userInfoDto : {}", userInfoDto);

		int rslt = userService.UpdateUser(userInfoDto);
		if (rslt == 1) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} else {
			logger.debug("수정 실패, {}", rslt);
			return new ResponseEntity<String>(FAIL, HttpStatus.NOT_ACCEPTABLE);
		}
	}
//
//	@RequestMapping(value = "/FindPw", method = RequestMethod.POST, produces = "application/json; charset=utf8")
//	public void FindPw(@RequestBody HashMap<String, Object> map, HttpSession session, HttpServletResponse response)
//			throws Exception {
//		System.out.println("접속 ok");
//		response.setContentType("application/json;charset=utf-8");
//		// 비밀번호 찾기 과정 1차, 해당 정보가 mapping된 아이디가 있는지 확인
//		System.out.println((String) session.getAttribute("confirmed_id"));
//		if ((String) session.getAttribute("confirmed_id") == null) {
//
//			UserInfoDto userinfoDto = new UserInfoDto();
//			System.out.println();
//			userinfoDto.setId((String) map.get("id"));
//			userinfoDto.setEmail((String) map.get("email"));
//			userinfoDto.setAge((Integer) map.get("age"));
//			userinfoDto.setName((String) map.get("name"));
//			userinfoDto.toString();
//
//			int rslt = userService.findpw(userinfoDto);
//			// 동일한 아이디, 이메일, 나이가 있다면
//			if (rslt == 1) {
//				// 비밀번호 찾는 과정에 성공
//				session.setAttribute("confirmed_id", map.get("id"));
//				response.getWriter().write('1');
//			} else {
//				response.getWriter().write('0');
//			}
//		}
//		// 피빌번호 찾기 과정 2차, 처음 변경하려는 아이디의 비밀번호만 변경 가능
//		else {
//			String confirmed_id = (String) session.getAttribute("confirmed_id");
//			session.removeAttribute("confirmed_id");
//			System.out.println(confirmed_id + " " + (String) map.get("id") + " " + (String) map.get("pw"));
//			if (((String) map.get("id")).equals(confirmed_id)) {
//				UserInfoDto userinfoDto = new UserInfoDto();
//				userinfoDto.setId(confirmed_id);
//				userinfoDto.setPw((String) map.get("pw"));
//				int rslt = userService.UpdateUser(userinfoDto);
//
//				response.getWriter().write('1');
//			} else {
//				response.getWriter().write('2');
//			}
//
//		}
//	}

//	@RequestMapping(value = "/UpdateUsers", method = RequestMethod.POST, produces = "application/json; charset=utf8")
//	public void UpdateUsers(@RequestBody HashMap<String, Object> map, HttpServletResponse response) throws Exception {
//		response.setContentType("application/json;charset=utf-8");
//		System.out.println("접속 ok");
//		UserInfoDto userInfoDto = new UserInfoDto();
//
//		userInfoDto.setId((String) map.get("id"));
//		userInfoDto.setPw((String) map.get("pw"));
//		userInfoDto.setEmail((String) map.get("email"));
//		userInfoDto.setName((String) map.get("name"));
//		userInfoDto.setAge((Integer) map.get("age"));
//		userInfoDto.setGrade((Integer) map.get("grade"));
//		userInfoDto.toString();
//
//		logger.debug("userInfoDto : {}", userInfoDto);
//		int rslt = userService.UpdateUser(userInfoDto);
//
//		if (rslt == 1) {
//			response.getWriter().write("1");
//		} else {
//			response.getWriter().write("0");
//		}
//	}

	// 비동기로 데이터 전송
//	@PostMapping("/getuser")
//	public String GetUser(String id) throws SQLException {
//		userService.GetUser(id);
//		return "Main";
//	}

	// 비동기로 데이터 전송
	@PostMapping("/getlist")
	public String getlist(String id, HttpSession session) throws SQLException {
		// 추후 기능구현
		return "";
	}

	// 회원 자발적 탈퇴+
	@DeleteMapping("/secession/{id}")
	public String secession(@PathVariable("id") String id, HttpServletRequest request) throws SQLException {
		// 추후 기능구현
		return "";
	}

	// 관리자에 의한 삭제
	@DeleteMapping("/delete/{id}")
	public void DeleteUser(@PathVariable("id") String id, HttpServletResponse response)
			throws SQLException, IOException {
//		추후 작성
	}

	@GetMapping("/logout")
	public String Logout(HttpServletRequest request) {
		// 추후 기능구현
		return "Main";
	}
}
