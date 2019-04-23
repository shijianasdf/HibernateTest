package actions;

import java.util.ArrayList;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import beans.student;
import utils.SimpleFactory;

@SuppressWarnings("serial")
public class MyAction extends ActionSupport {
   private String rid;
   public String test(){
	   ArrayList<student> as = (ArrayList<student>)new SimpleFactory<student>("student").query("from student where id = '"+this.rid+"'");
	   ActionContext.getContext().put("rs", as);
	   return SUCCESS;
   }
public String getRid() {
	return rid;
}
public void setRid(String rid) {
	this.rid = rid;
}
   
}
