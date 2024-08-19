package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.MemberDto;
import com.kh.oneTrillionCompany.mapper.BlockMapper;
import com.kh.oneTrillionCompany.mapper.MemberMapper;

@Repository
public class MemberDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private BlockMapper blockMapper;
	
	//회원 가입
	public void insert(MemberDto memberDto) {
		String sql = "insert into member("
				+ "member_id, member_pw, member_name, member_nickname, member_email, "
				+ "member_block, member_rank, member_point, member_join, "
				+ "member_login, member_post, member_address1, member_address2, "
				+ "member_height, member_weight"
				+ ") "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				memberDto.getMemberId(), memberDto.getMemberPw(),
				memberDto.getMemberName(), memberDto.getMemberNickname(), memberDto.getMemberEmail(), 
				memberDto.getMemberBlock(), memberDto.getMemberRank(), 
				memberDto.getMemberPoint(), memberDto.getMemberJoin(),
				memberDto.getMemberLogin(), memberDto.getMemberPost(), 
				memberDto.getMemberAddress1(), memberDto.getMemberAddress2(),
				memberDto.getMemberHeight(), memberDto.getMemberWeight()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//회원 상세 정보
	public MemberDto selectOne(String memberId) {
		String sql = "select * from where member_id = ?";
		Object[] data = {memberId};
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	
	//회원 수정(비밀번호)
	public boolean updateMemberPw(String memberId, String memberPw) {
		String sql = "update member set member_pw = ? where member_id = ?";
		Object[] data = {memberPw, memberId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//개인정보 변경 - 회원용 (닉네임, 주소, 키, 몸무게)
	public boolean updateMember(MemberDto memberDto) {
		String sql = "update member set "
				+ "member_nickname = ?, member_email = ?, member_post = ?, "
				+ "member_address1 = ?, member_address2 = ? "
				+ "where member_id=?";
		Object[] data = {
				memberDto.getMemberNickname(), memberDto.getMemberEmail(), 
				memberDto.getMemberPost(), memberDto.getMemberAddress1(), 
				memberDto.getMemberAddress2(), memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//로그인 시간 갱신
	public boolean updateMemberLogin(String memberId) {
		String sql = "update member set member_login = sysdate "
				+ "where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//회원 탈퇴
	public boolean delete(String memberId) {
		String sql = "delete member where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
//관리자 전용
	
	//회원 목록
	public List<MemberDto> selectList(){
		String sql = "select * from member order by member_id asc";
		return jdbcTemplate.query(sql, memberMapper);
	}
	
	//회원 검색
	public List<MemberDto> selectListByOption(String column, String keyword) {
		String sql = "select * from member where instr(" + column + ", ?) > 0 "
				+ "order by " + column + " asc, member_id asc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, memberMapper, data);
	}
	
	//회원 수정
	public boolean updateMemberByAdmin(MemberDto memberDto) {
		String sql = "update member set "
				+ "member_nickname = ?, member_rank = ?, "
				+ "member_point = ?"
				+ "where member_id = ?";
		Object[] data = {
				memberDto.getMemberNickname(), memberDto.getMemberRank(), 
				memberDto.getMemberPoint(), memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
}
