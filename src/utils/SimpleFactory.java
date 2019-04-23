package utils;

/**
 * 
 * @author Lexwoe
 * 
 * DESCRIPTION
 * Function for querying database 
 *
 */

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class SimpleFactory <O>{
	
	private String tableName;
	
	public SimpleFactory(String tableName){
		this.tableName = tableName;
	}
	
	public SimpleFactory(){
		
	}
	
	/**
	 * 
	 * @param fieldName 
	 * @param keyword
	 * @return for redirect to web page
	 */
	public List<O> query(String fieldName, String keyword){
		String queryTerm = "from "+this.tableName+" where "+fieldName+" = '"+keyword+"'";
		//Session s= new Configuration().configure().buildSessionFactory().openSession();
		SessionFactory sf = HibernateUtils.getSessionFactory();
		Session s =sf.getCurrentSession();
		s.beginTransaction();
		@SuppressWarnings("unchecked")
		List<O> qrslt = s.createQuery(queryTerm).list();
		s.getTransaction().commit();
		//s.close();
		return qrslt;
	}
	
	public List<O> query(){
		//Session s= new Configuration().configure().buildSessionFactory().openSession();
		SessionFactory sf = HibernateUtils.getSessionFactory();
		Session s =sf.getCurrentSession();
		s.beginTransaction();
		@SuppressWarnings("unchecked")
		List<O> qrslt = s.createQuery("from "+this.tableName).list();
		s.getTransaction().commit();
		//s.close();
		return qrslt;
	}
	
	public List<O> query(String queryTerm){
		//Session s= new Configuration().configure().buildSessionFactory().openSession();
		SessionFactory sf = HibernateUtils.getSessionFactory();
		Session s =sf.getCurrentSession();
		s.beginTransaction();
		@SuppressWarnings("unchecked")
		List<O> qrslt = s.createQuery(queryTerm).list();
		s.getTransaction().commit();
		//s.close();
		return qrslt;
	}
	
	public List<O> query4page(String queryTerm,int page,int number){
		//Session s= new Configuration().configure().buildSessionFactory().openSession();
		SessionFactory sf = HibernateUtils.getSessionFactory();
		Session s =sf.getCurrentSession();
		s.beginTransaction();
		Query query = s.createQuery(queryTerm);
		query.setFirstResult(page);
		query.setMaxResults(number);
		@SuppressWarnings("unchecked")
		List<O> qrslt = query.list();
		s.getTransaction().commit();
		//s.close();
		return qrslt;
	}
	
	public boolean save(O obj){
		//Session s= new Configuration().configure().buildSessionFactory().openSession();
		SessionFactory sf = HibernateUtils.getSessionFactory();
		Session s =sf.getCurrentSession();
		s.beginTransaction();
		s.saveOrUpdate(obj);
		s.getTransaction().commit();
		//s.close();
		return true;
	}
	
	public boolean remove(O obj){
		//Session s= new Configuration().configure().buildSessionFactory().openSession();
		SessionFactory sf = HibernateUtils.getSessionFactory();
		Session s =sf.getCurrentSession();
		s.beginTransaction();
		s.delete(obj);
		s.getTransaction().commit();
		//s.close();
		return true;
	}
	
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	
}
