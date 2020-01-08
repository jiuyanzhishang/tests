package datatables.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import datatables.test.bean.User;

public interface UserMapper {
	int selectCount();

	List<User> selectAll(
			@Param("offset") int page, 
			@Param("count") int pagesize);
	
	void deleteById(
			Integer id);
	
	void updateById(User user);
}
