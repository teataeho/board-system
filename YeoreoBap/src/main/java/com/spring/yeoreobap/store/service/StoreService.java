package com.spring.yeoreobap.store.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.yeoreobap.command.StoreVO;
import com.spring.yeoreobap.store.mapper.IStoreMapper;

@Service
public class StoreService implements IStoreService {

	@Autowired
	private IStoreMapper mapper;	
	
	@Override
	public List<StoreVO> getList(String uptaeNm, String addr) {
		return mapper.getList(uptaeNm ,addr);
	}
	
	@Override
	public void readOpenStoresFromJson() {
        List<StoreVO> storeList = new ArrayList<>();
        List<StoreVO> filteredList = new ArrayList<StoreVO>();

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(new File("C:/workspace/seoul_rest.json"));
            JsonNode dataNode = rootNode.get("DATA");

            if(dataNode.isArray()) {
                for(JsonNode node : dataNode) {
                    StoreVO store = objectMapper.convertValue(node, StoreVO.class);
                    storeList.add(store);
                }
                filteredList = storeList.stream()
                                    .filter(store -> store.getDtlstatenm().equals("영업"))
                                    .collect(Collectors.toList());
            }



        } catch (IOException e) {
            e.printStackTrace();
        }

        for(StoreVO vo : filteredList) {
        	mapper.inputData(vo);
        }

    }

}