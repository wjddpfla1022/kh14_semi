package com.kh.oneTrillionCompany.advice;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;



//@ControllerAdvice(대상 지정과 관련된 옵션)
@ControllerAdvice(basePackages = {"com.kh.oneTrillionCompany.controller"})
//@ControllerAdvice(annotations =  {Controller.class})
public class EmptyStringAdvice {
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
		
	}

}
