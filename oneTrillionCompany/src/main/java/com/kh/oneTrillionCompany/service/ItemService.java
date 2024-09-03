package com.kh.oneTrillionCompany.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.ItemDto;

@Service
public class ItemService {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	 public int selectItemCntByNameColor(int itemNo) {
	        String itemName = findItemName(itemNo); // itemName을 가져오는 메서드
	        String itemColor = findItemColor(itemNo);
	        String sql = "SELECT item_cnt FROM item WHERE item_name = ? AND item_color = ? limit 1";
	        Object[] data = { itemName, itemColor };
	        List<Integer> list= jdbcTemplate.queryForList(sql, int.class, data);
	        
	        return 0;
	    }
	 	
	 	private String findItemColor(int itemNo) {
	 		String itemName = findItemName(itemNo);
	 		String sql = "select item_color from item where item_name = ?";
	 		Object[] data = {itemName};
	 		
	 		return jdbcTemplate.queryForObject(sql, String.class, data);
	 	}
	 
	    private String findItemName(int itemNo) {
	        // itemNo를 통해 itemName을 조회하는 로직을 구현합니다.
	        // 예를 들어:
	        String sql = "SELECT item_name FROM item WHERE item_no = ?";
	        Object[] data = {itemNo};
	        return jdbcTemplate.queryForObject(sql, String.class, data);
	    }
}
