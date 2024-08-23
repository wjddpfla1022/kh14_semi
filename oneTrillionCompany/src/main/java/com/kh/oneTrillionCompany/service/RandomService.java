package com.kh.oneTrillionCompany.service;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class RandomService {
	
	private Random r= new Random();
	
	public String generateNumber(int size) {
		StringBuffer bf= new StringBuffer();
		for(int i=0; i<size; i++)
			bf.append(r.nextInt(10));
		return bf.toString();
	}
	public String generateString(int size) {
		StringBuffer bf=new StringBuffer();
		for(int i=0; i<size; i++) {
			bf.append((char)r.nextInt(54)+65);
		}
		return bf.toString();
	}
}
