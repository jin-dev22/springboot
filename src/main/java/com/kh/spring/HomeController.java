package com.kh.spring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j //logback 의존 사용
public class HomeController {
	@GetMapping("/")
	public String home() {
		return "forward:/index.jsp";
	}
}
