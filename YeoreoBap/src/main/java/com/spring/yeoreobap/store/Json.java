package com.spring.yeoreobap.store;

import org.json.JSONArray;
import org.json.JSONObject;

public class Json {

	public static void main(String[] args) {
		JSONObject json = new JSONObject();
		JSONArray items = json.getJSONArray("items");
		
		for(int i=0; i<10; i++) {
			JSONObject store =items.getJSONObject(i);
			String siteTel = store.getString("siteTel");
			String rdnWhlAddr = store.getString("rdnWhlAddr");
			String bplcNm = store.getString("bplcNm");
			String uptaeNm = store.getString("uptaeNm");
			
			
		}
	}

}
