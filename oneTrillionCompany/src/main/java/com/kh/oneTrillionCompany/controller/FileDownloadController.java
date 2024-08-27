package com.kh.oneTrillionCompany.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.oneTrillionCompany.dao.AttachDao;
import com.kh.oneTrillionCompany.service.AttachService;

@RestController
@RequestMapping("/attach")
public class FileDownloadController {

	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private AttachService attachService;
	
	
	
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> download(@RequestParam int attachNo) throws IOException{
		return attachService.find(attachNo);
	}
	
}
