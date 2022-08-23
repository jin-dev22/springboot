package com.kh.spring.menu.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Menu {
	private int id;
	private String restaurant;
	private String name;
	private int price;
	private Type type;
	private Taste taste;
}
