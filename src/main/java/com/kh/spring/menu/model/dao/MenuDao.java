package com.kh.spring.menu.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.spring.menu.model.dto.Menu;
import com.kh.spring.menu.model.dto.Type;

@Mapper //레거시에서 쓰던 dao구현체 생성 태그와 같은 역할
public interface MenuDao {
	
	@Select("select * from menu order by id")
	List<Menu> selectAllMenu();

	@Select("select * from menu where type = #{type}")
	List<Menu> findByType(Type type);

	@Select("select * from menu where type = #{type} and taste = #{taste}")
	List<Menu> findByTypeTaste(Menu menu);

	@Select("select * from menu where id = #{id}")
	Menu findOneById(int id);

}
