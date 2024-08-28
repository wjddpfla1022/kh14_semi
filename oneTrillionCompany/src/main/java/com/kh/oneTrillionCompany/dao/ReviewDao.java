package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.ReviewDto;
import com.kh.oneTrillionCompany.mapper.ReviewMapper;

@Repository
public class ReviewDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	
//	//등록
//	public void insert(ReviewDto reviewDto) {
//		String sql = "insert into review(review_no , review_item_no , review_writer , review_content , review_score)"
//							+ "values(review_seq.nextval , ? , ? ,? ,?)";
//		Object[] data = {reviewDto.getReviewItemNo() , reviewDto.getReviewWriter() , 
//								reviewDto.getReviewContent() , reviewDto.getReviewScore()};
//		jdbcTemplate.update(sql, data);
//	}
	//리뷰 삭제
	public boolean delete(int reviewNo) {
		String sql = "delete review where review_no = ? ";
		Object[] data = {reviewNo};
		return jdbcTemplate.update(sql , data) > 0 ;
	}
	//리뷰 수정
	public boolean update(ReviewDto reviewDto) {
		String sql = "update review review_content=? , review_score=? where review_no = ?";
		Object[] data = {reviewDto.getReviewContent() , reviewDto.getReviewScore() , reviewDto.getReviewNo()};
		return jdbcTemplate.update(sql , data) > 0 ;
	}
	
	//시퀀스 생성
	public int sequence() {
		String sql = "select review_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	

	//등록
	public void insert(ReviewDto reviewDto) {
		String sql = "insert into review(review_no , review_item_no , review_writer , review_content , review_score)"
							+ "values(?, ?, ?, ?, ?)";
		Object[] data = {reviewDto.getReviewNo(), reviewDto.getReviewItemNo(), reviewDto.getReviewWriter(), 
								reviewDto.getReviewContent(), reviewDto.getReviewScore()};
		jdbcTemplate.update(sql, data);
	}
	//상세
	public ReviewDto selectOne(int reviewNo) {
		String sql = "selsect * from review where reivew_no=?";
		Object[]data = {reviewNo};
		List<ReviewDto> list = jdbcTemplate.query(sql, reviewMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//리뷰 검색
	public List<ReviewDto> selectList(String column, String keyword){
		String sql = "select * from review where instr("+column+", ?) > 0 order by review_no asc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, reviewMapper, data);
	}
	
	//특정 회원의 리뷰 목록 조회
	public List<ReviewDto> selectListByWriter(String reviewWriter){
		String sql = "select * from review where review_writer = ? order by review_no desc";
		Object[] data= {reviewWriter};
		return jdbcTemplate.query(sql, reviewMapper, data);
	}
	
	
	
	

}



	
	