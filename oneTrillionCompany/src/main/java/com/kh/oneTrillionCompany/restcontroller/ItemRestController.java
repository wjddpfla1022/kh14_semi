package com.kh.oneTrillionCompany.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.oneTrillionCompany.dao.ItemDao;

@CrossOrigin(origins= { "http://127.0.0.1:5500" })
@RestController
@RequestMapping("/rest/item")
public class ItemRestController {
	
	@Autowired
	private ItemDao itemDao;
	
}
