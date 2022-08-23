package com.kh.spring.menu.model.service;

import java.util.List;
import java.util.Map;

import com.kh.spring.menu.model.dto.Menu;
import com.kh.spring.menu.model.dto.Type;

public interface MenuService {

	List<Menu> selectAllMenu();

	List<Menu> findByType(Type type);

	List<Menu> findByTypeTaste(Menu menu);

	Menu findOneById(int id);

}
