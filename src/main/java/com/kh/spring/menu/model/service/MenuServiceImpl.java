package com.kh.spring.menu.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.menu.model.dao.MenuDao;
import com.kh.spring.menu.model.dto.Menu;
import com.kh.spring.menu.model.dto.Type;

@Service
public class MenuServiceImpl implements MenuService {
	
	@Autowired
	MenuDao menuDao;
	
	@Override
	public List<Menu> selectAllMenu() {
		return menuDao.selectAllMenu();
	}
	
	@Override
	public List<Menu> findByType(Type type) {
		return menuDao.findByType(type);
	}
	
	@Override
	public List<Menu> findByTypeTaste(Menu menu) {
		return menuDao.findByTypeTaste(menu);
	}
	
	@Override
	public Menu findOneById(int id) {
		return menuDao.findOneById(id);
	}
}
