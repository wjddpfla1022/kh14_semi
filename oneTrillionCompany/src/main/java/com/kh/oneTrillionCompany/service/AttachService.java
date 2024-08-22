package com.kh.oneTrillionCompany.service;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.oneTrillionCompany.configuration.CustomFileuploadProperties;
import com.kh.oneTrillionCompany.dao.AttachDao;
import com.kh.oneTrillionCompany.dto.AttachDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;

import jakarta.annotation.PostConstruct;

@Service
public class AttachService {
	
	@Autowired
	private CustomFileuploadProperties properties;
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(properties.getPath());
		dir.mkdirs();
	}
	
	@Autowired
	private AttachDao attachDao;
	
	public int save(MultipartFile attach) throws IllegalStateException, IOException {
		int attachNo = attachDao.sequence();
		
		File target = new File(dir, String.valueOf(attachNo));
		attach.transferTo(target);
		
		AttachDto attachDto = new AttachDto();
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(attach.getOriginalFilename());
		attachDto.setAttachType(attach.getContentType());
		attachDto.setAttachSize(attach.getSize());
		attachDao.insert(attachDto);
		
		return attachNo;
	}
	
	public void delete(int attachNo) {
		
		AttachDto attachDto = attachDao.selectOne(attachNo);
		if(attachDto == null) {
			throw new TargetNotFoundException("존재하지 않는 파일");
		}
		
		File target = new File(dir, String.valueOf(attachNo));
		target.delete();
		
		attachDao.delete(attachNo);
	}
	public ResponseEntity<ByteArrayResource> find(int attachNo) throws IOException{
		
		// (1) attachmentNo에 대한 데이터가 존재하는지 확인해야 한다.
		AttachDto attachDto = attachDao.selectOne(attachNo);
		if(attachDto == null) {
			throw new TargetNotFoundException("존재하지 않는 파일 번호");
		}
		
		// (2) 정보가 있으므로 실제 파일을 불러온다.
		// - 파일을 한 번에 쉽게 불러주는 라이브러리 사용 (apache commons io)
		File target = new File(dir, String.valueOf(attachNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data); //포장
		
		// (3) 불러온 정보를 사용자에게 전송(헤더 + 바디)
//		return ResponseEntity.ok().body(데이터);
		return ResponseEntity.ok()
					.contentType(MediaType.APPLICATION_OCTET_STREAM)
					.contentLength(attachDto.getAttachSize())
					.header(HttpHeaders.CONTENT_ENCODING	, StandardCharsets.UTF_8.name())
					.header(HttpHeaders.CONTENT_DISPOSITION, 
							ContentDisposition.attachment().filename(attachDto.getAttachName(), 
																									StandardCharsets.UTF_8).build().toString())
				.body(resource);
		}
	
}
