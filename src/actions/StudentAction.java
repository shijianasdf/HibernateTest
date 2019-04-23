package actions;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import localbeans.bufen;
import beans.student;
import convertor.GsonTools;
import utils.HibernateUtils;
import utils.SimpleFactory;

@SuppressWarnings({ "serial", "unused" })
public class StudentAction extends ActionSupport {
     private String name;
     private String sex;
     private int score;
     private String university;
     private int newscore;
     
	public String add(){
    	 student st=new student(this.name,this.sex,this.score,this.university);
    	 SessionFactory sf = HibernateUtils.getSessionFactory();//��ȡSessionFactory
    	 Session s =sf.getCurrentSession();//��ȡSession
    	 s.beginTransaction();//��������
    	 s.save(st);//�������
    	 s.getTransaction().commit();
    	 ActionContext.getContext().put("message", "�ɹ���������");
    	 return SUCCESS;
     }
	public String delete(){
		 SessionFactory sf = HibernateUtils.getSessionFactory();
		 Session s =sf.getCurrentSession();
		 s.beginTransaction();
		 String hql="delete from student where name = :name";//ȡ�����ֶ�
		 Query query = s.createQuery(hql);
		 query.setParameter("name", this.name);
         query.executeUpdate();		
		 s.getTransaction().commit();//�κ��й����ݿ���µĲ�������commit������ݿ��
		 ActionContext.getContext().put("message", "delete successfully");
		 return "deletesuccess";
	}
	public String search(){
		/*SessionFactory sf=HibernateUtils.getSessionFactory();
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		/*String hql="select score,name from student where university = :u order by name desc";//ȡ�����ֶ�
		Query query=s.createQuery(hql);
		query.setParameter("u", this.university);
		@SuppressWarnings("unchecked")
		ArrayList<Object[]> ob= (ArrayList<Object[]>)query.list();//ȡ�����ֶΣ�ÿһ����¼��ɶ�������
		ArrayList<bufen> as=new ArrayList<bufen>();
		for(Object[] O : ob){
			bufen bf=new bufen((Integer)O[0],(String)O[1]);
		    as.add(bf);
		}*/
		@SuppressWarnings("unchecked")
		/*ArrayList<student> as = (ArrayList<student>)s.createQuery("select new beans.student(name,score) from student where university = :u").setParameter("u", this.university).list();
		s.getTransaction().commit();*/
		ArrayList<student> as = (ArrayList<student>)new SimpleFactory<student>("student").query("select new beans.student(name,score) from student where university = '"+this.university+"'");
		
		ActionContext.getContext().put("as", as);
		ActionContext.getContext().put("asjson", GsonTools.createJsonString(as));
		//System.out.println(ob);
		return "searchsuccess";
	}
	public String searchdetail(){
		SessionFactory sf = HibernateUtils.getSessionFactory();
		//Session s1= sf.getCurrentSession();
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		String hql="from student where name = :a";//ȡȫ���ֶ�
		Query query=s.createQuery(hql);
		query.setParameter("a", this.name);
		@SuppressWarnings("unchecked")
		ArrayList<student> resultTable=(ArrayList<student>)query.list();
		s.getTransaction().commit();
		ActionContext.getContext().put("resultTable", resultTable);
		System.out.println(resultTable);
		return "searchdetailsuccess";
	}
	public String update(){
		SessionFactory sf = HibernateUtils.getSessionFactory();
		Session s = sf.getCurrentSession();
		s.beginTransaction();
		Query query = s.createQuery("update student set score = :newscore where score = :score").setParameter("newscore", this.newscore).setParameter("score", this.score);
		query.executeUpdate();
		s.getTransaction().commit();
		ActionContext.getContext().put("message", "update successfully");
		return "updatesuccess";
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getUniversity() {
		return university;
	}
	public void setUniversity(String university) {
		this.university = university;
	}
	public int getNewscore() {
		return newscore;
	}
	public void setNewscore(int newscore) {
		this.newscore = newscore;
	}
     
}
