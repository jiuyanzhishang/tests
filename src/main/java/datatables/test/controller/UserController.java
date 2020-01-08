package datatables.test.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import datatables.test.bean.User;
import datatables.test.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private IUserService userService;
	
	@RequestMapping("/show.do")
	public String show(){
		return "table2";
	}
	
	@RequestMapping(value="/showData.do",produces="application/json;charset=utf-8")
	@ResponseBody
	public String showData(String page,String pagesize,ModelMap data){
		int totalCount = userService.selectCount();
		System.out.println(totalCount);
		if(page==null){
			page="0";
		}if(pagesize==null){
			pagesize="0";
		}
		int pagesize1 = Integer.parseInt(pagesize);
		int page1 = Integer.parseInt(page);
		System.out.println("page:"+page1+"\tpagesize:"+pagesize1);
		page1 = (page1-1)*pagesize1;
		List<User> list= userService.selectPage(page1,pagesize1);
		data.addAttribute("data", list);
		data.addAttribute("totalCount", totalCount);
		Gson gson = new GsonBuilder().create() ;
		String result = gson.toJson(data);
		System.out.println(result);
		return result;
	}
	
		// 单行删除
		@RequestMapping(value="/removeById.do")
		public String removeById(Integer id) {
			userService.removeById(id);
			return "redirect:../user/show.do";
		} 
		
		//更新
		@RequestMapping(value="/update.do",produces="application/json;charset=utf-8")
		@ResponseBody
		public void updateById(User user){
			userService.updateById(user);
		}
		
		
	/*	//更新
				@RequestMapping(value="/update.do",produces="application/json;charset=utf-8")
				@ResponseBody
				public void updateById(
						@RequestParam("id") Integer id,
						@RequestParam("name") String name,
						@RequestParam("age") String age,
						@RequestParam("address") String address,
						@RequestParam("sex") String sex
						){
					int age1 = Integer.parseInt(age);
					User user = new User();
					user.setId(id);
					user.setName(name);
					user.setAddress(address);
					user.setAge(age1);
					user.setSex(sex);
					userService.updateById(user);
					//String response = "1";
				}*/
		
}
