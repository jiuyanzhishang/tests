package datatables.test.service;

import java.util.List;

import datatables.test.bean.User;

public interface IUserService {
	public int selectCount();
	
	public List<User> selectPage(int page,int pagesize);
	
	public void removeById(Integer id);
	
	public void updateById(User user);
}
