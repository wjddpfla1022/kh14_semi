package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.CategoryDto;
import com.kh.oneTrillionCompany.mapper.CategoryMapper;

@Repository
public class CategoryDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private CategoryMapper categoryMapper;
	
	public void insert(String categoryName) {
		String sql="insert into category ("
				+ "cate_no, cate_name "
				+ ") values(category_seq.nextval, ?"
				+ ")";
		Object[] data = {categoryName};
		jdbcTemplate.update(sql, data);
	}
	public boolean delete(String categoryNo) {
		String sql="delete category where cate_no=?";
		Object[] data = {categoryNo};
		boolean result = jdbcTemplate.update(sql, data)>0;
		return result;
	}
	public boolean update(CategoryDto categoryDto) {
		String sql="update category set  cate_name=? where cate_no=?";
		Object[] data= {categoryDto.getCateName(),categoryDto.getCateNo()};
		return jdbcTemplate.update(sql, data)>0;
	}
	public CategoryDto selectOne(String categoryNo) {
		String sql = "select cate_no, cate_name from category "
				+ "where cate_no =?";
		Object[] data= {categoryNo};
		List<CategoryDto> list = jdbcTemplate.query(sql, categoryMapper, data);
		return list.isEmpty()?null:list.get(0);
	}
	public List<CategoryDto> selectList(){
		String sql="select category_no, category_name from category "
				+ "order by cate_no desc";
		return jdbcTemplate.query(sql, categoryMapper);
	}
	public List<CategoryDto> selectList(String column, String keyword){
		String sql = "select cate_no, cate_name from category "
				+ "where instr(#!, ?)>0 order by cate_no desc";
		sql=sql.replace("#!", column);
		Object[] data= {keyword};
		return jdbcTemplate.query(sql, categoryMapper, data);
	}
}
