package datatables.test.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import datatables.test.bean.User;
import datatables.test.mapper.UserMapper;

@Service
public class UserService implements IUserService{
	@Resource
	private UserMapper usermapper;
	public int selectCount() {
		return usermapper.selectCount();
	}
	
	public List<User> selectPage(int page,int pagesize){
		return usermapper.selectAll(page,pagesize);
	}
	
	public void removeById(Integer id){
		usermapper.deleteById(id);
	}
	
	public void updateById(User user){
		usermapper.updateById(user);
	}
}
