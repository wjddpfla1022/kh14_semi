package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.QnaDto;
import com.kh.oneTrillionCompany.mapper.QnaMapper;

@Repository
public class QnaDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private QnaMapper qnaMapper;
	
	//문의 등록
	public void insert(QnaDto qnaDto) {
		String sql = "insert into qna("
				+ "qna_no, qna_writer, qna_title, "
				+ "qna_content, qna_time"
				+ ") values(?, ?, ?, ?, sysdate)";
		Object[] data = {
				qnaDto.getQnaNo(), qnaDto.getQnaWriter(),
				qnaDto.getQnaTitle(), qnaDto.getQnaContent()};
		jdbcTemplate.update(sql, data);
	}
	
	//문의 삭제
	public boolean delete(int qnaNo) {
		String sql = "delete qna where qna_no=?";
		Object[] data = {qnaNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//문의 목록
	public List<QnaDto> selectList() {
		String sql = "select "
				+ "qna_no, qna_writer, qna_title, qna_content,"
				+ "qna_time "
				+ "from qna order by qna_no desc";
		return jdbcTemplate.query(sql, qnaMapper);
	}
	
	//문의 검색
	public List<QnaDto> selectList(String column, String keyword) {
		String sql = "select * from qna "
				+ "where instr(" + column + ", ?) > 0 "
				+ "order by qna_no asc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, qnaMapper, data);		
	}
	
	//문의 상세 검색
	public QnaDto selectOne(int qnaNo) {
		String sql= "select * from qna where qna_no=?";
		Object[] data = {qnaNo};
		List<QnaDto> list = jdbcTemplate.query(sql, qnaMapper, data);
		return list.isEmpty() ? null : list.get(0);		
	}
	
	//특정 회원의 문의 목록 조회
	public List<QnaDto> selectListByWriter(String qnaWriter){
		String sql = "select * from qna where qna_writer =? order by qna_no desc";
		Object[] data = {qnaWriter};
		return jdbcTemplate.query(sql, qnaMapper, data);
	}
	
	//시퀀스 생성
	public int sequence() {
		String sql = "select qna_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
}
