package com.kh.oneTrillionCompany.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.mapper.CategoryMapper;

@Repository
public class CategoryDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private CategoryMapper categoryMapper;
	
	//
	
}
