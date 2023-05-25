package com.spring.yeoreobap.store.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.spring.yeoreobap.store.mapper.IStoreMapper;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/config/servlet-config.xml",
									"file:src/main/webapp/WEB-INF/config/db-config.xml"})
@WebAppConfiguration
public class StoreControllerTest {

	@Autowired
	private WebApplicationContext ctx;
	private IStoreMapper mapper;
	
	private MockMvc mockMvc;
	
	@BeforeEach
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	@DisplayName("/store/storeList 요청")
	void testList() throws Exception {
		ModelAndView mv = 
				mockMvc.perform(MockMvcRequestBuilders.get("/store/storeList"))
				.andReturn()
				.getModelAndView();
		System.out.println("Model 내에 저장한 데이터: " + mv.getModelMap());
		System.out.println("응답 처리를 위해 사용할 페이지: " + mv.getViewName());
	}
	
	@Test
	@DisplayName("111111")
	void testContent() throws Exception {
		ModelAndView mv = mockMvc.perform(MockMvcRequestBuilders.get("/store/content")
				.param("sno", "1"))
				.andReturn().getModelAndView();
		System.out.println("model: " + mv.getModelMap());
		assertEquals("store/storeDetail", mv.getViewName());
	}
	
}
