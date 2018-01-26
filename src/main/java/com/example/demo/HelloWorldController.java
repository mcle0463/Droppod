package com.example.demo;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api")
@RestController
public class HelloWorldController {

	@RequestMapping(path="/hello/{name}",
			method=RequestMethod.GET,
			produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> hello(@PathVariable String name){
		return new ResponseEntity("Hello "+name+"!",HttpStatus.OK);
	}
	
//	@RequestMapping(value="/post",
//			method=RequestMethod.POST)
//	public ResponseEntity<Object> post(HttpServletRequest request){
//		String uName = request.getHeader("username");
//		String uPass = request.getHeader("password");
//		return new ResponseEntity(HttpStatus.OK);
//	}
}
