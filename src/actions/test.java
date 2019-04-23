package actions;

import java.util.ArrayList;

import beans.student;
import convertor.GsonTools;
import utils.SimpleFactory;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ArrayList<student> as = (ArrayList<student>)new SimpleFactory<student>("student").query("select id, name, sex, score, university from student where id = 'student000001'");
		System.out.println(GsonTools.createJsonString(as)); //[["student000001","longzhilin","man",100,"hafo"]]
		ArrayList<student> as3 = (ArrayList<student>)new SimpleFactory<student>("student").query("select name, sex from student where id = 'student000001'");
		System.out.println(GsonTools.createJsonString(as3)); //[["longzhilin","man"]]
		ArrayList<student> as1 = (ArrayList<student>)new SimpleFactory<student>("student").query("from student where id = 'student000001'");
		System.out.println(GsonTools.createJsonString(as1)); //[{"id":"student000001","sex":"man","name":"longzhilin","score":100,"university":"hafo"}]
		ArrayList<student> as2 = (ArrayList<student>)new SimpleFactory<student>("student").query("select new beans.student(name,score)from student where id = 'student000001'");
		System.out.println(GsonTools.createJsonString(as2)); //[{"name":"longzhilin","score":100}]
		//ArrayList<student> as4 = (ArrayList<student>)new SimpleFactory<student>("student").query("select new beans.student(name,score)from test.student where id = 'student000001'");
		//System.out.println(GsonTools.createJsonString(as4)); //[{"name":"longzhilin","score":100}]
		ArrayList<student> as4 = (ArrayList<student>)new SimpleFactory<student>("student").query("select count(*) from student");
		System.out.println(GsonTools.createJsonString(as4)); //[{"name":"longzhilin","score":100}]
	}

}
