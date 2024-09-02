package com.kh.oneTrillionCompany;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class OneTrillionCompanyApplication {

	public static void main(String[] args) {
		SpringApplication.run(OneTrillionCompanyApplication.class, args);
	}

}
