package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.MemberDto;
import com.kh.oneTrillionCompany.mapper.MemberBlockMapper;
import com.kh.oneTrillionCompany.mapper.MemberMapper;
import com.kh.oneTrillionCompany.mapper.StatusVOMapper;
import com.kh.oneTrillionCompany.vo.MemberBlockVO;
import com.kh.oneTrillionCompany.vo.PageVO;
import com.kh.oneTrillionCompany.vo.StatusVO;

@Repository
public class MemberDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private MemberBlockMapper memberBlockMapper;
	
	@Autowired
	private StatusVOMapper statusVOMapper;
	
	//회원 가입
	public void insert(MemberDto memberDto) {
		String sql = "insert into member("
				+ "member_id, member_pw, member_name, member_nickname, member_birth, "//은수형 저주한다
				+ " member_email, member_point, "
				+ " member_post, member_address1, member_address2, "
				+ "member_height, member_weight, member_contact"
				+ ") "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				memberDto.getMemberId(), memberDto.getMemberPw(),
				memberDto.getMemberName(), memberDto.getMemberNickname(),
				memberDto.getMemberBirth(), memberDto.getMemberEmail(), 
				memberDto.getMemberPoint(), memberDto.getMemberPost(), 
				memberDto.getMemberAddress1(), memberDto.getMemberAddress2(),
				memberDto.getMemberHeight(), memberDto.getMemberWeight(), 
				memberDto.getMemberContact()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//회원 상세 정보
	public MemberDto selectOne(String memberId) { 
		String sql = "select * from member where member_id = ?";
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
				+ "member_nickname = ?, member_birth = ?, "
				+ "member_email = ?, member_post = ?, "
				+ "member_address1 = ?, member_address2 = ?, member_contact = ? "
				+ "where member_id=?";
		Object[] data = {
				memberDto.getMemberNickname(), memberDto.getMemberBirth(),//은수형 저주한다
				memberDto.getMemberEmail(), 
				memberDto.getMemberPost(), memberDto.getMemberAddress1(), 
				memberDto.getMemberAddress2(), memberDto.getMemberContact(),
				memberDto.getMemberId()
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
	
				/* ★★★★★★★★관리자 전용★★★★★★★★ */
	
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
				+ "member_nickname = ?, member_rank = ?,member_point = ? "
				+ "where member_id = ?";
		Object[] data = {
				memberDto.getMemberNickname(), memberDto.getMemberRank(), 
				memberDto.getMemberPoint(), memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	public boolean canIUseThisMemberNickname(String memberNickname) {
		String sql="select * from member where member_nickname=?";
		Object[] data= {memberNickname};
		List<MemberDto> list=jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty();
	}
	public List<MemberBlockVO> selectListWithBlock(String column, String keyword) {
		String sql = "select "
							+ "M.*, B.block_no, B.block_time, B.block_memo, "
							+ "B.block_member_id, nvl(B.block_type, '해제') block_type "
						+ "from member M "
							+ "left outer join block_latest B "
							+ "on M.member_id=B.block_member_id "
							+ "where instr(#1, ?) > 0 "
							+ "order by #1 asc, M.member_id asc";
		sql = sql.replace("#1", column);
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, memberBlockMapper, data);
	}
	
	//페이징 관련 메소드
	public List<MemberBlockVO> selectListWithBlockByPaging(PageVO pageVO) {
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
									+ "select "
										+ "M.*, B.block_no, B.block_time, B.block_memo, "
										+ "B.block_member_id, nvl(B.block_type, '해제') block_type "
									+ "from member M "
										+ "left outer join block_latest B "
										+ "on M.member_id=B.block_member_id "
										+ "where instr(#1, ?) > 0 "
										+ "order by #1 asc, M.member_id asc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		sql = sql.replace("#1", pageVO.getColumn());
		Object[] data = {
			pageVO.getKeyword(), pageVO.getBeginRow(),
			pageVO.getEndRow()
		};
		return jdbcTemplate.query(sql, memberBlockMapper, data);
	}
	public int countByPaging(PageVO pageVO) {
		String sql = "select count(*) from member where instr(#1, ?) > 0";
		sql = sql.replace("#1", pageVO.getColumn());
		Object[] data = {pageVO.getKeyword()};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	public List<StatusVO> statusByMemberLevel() {
		String sql = "select member_Level title, count(*) cnt from member "
				+ "group by member_level order by title desc";
		return jdbcTemplate.query(sql, statusVOMapper);
	}
	


}
