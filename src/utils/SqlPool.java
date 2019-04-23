package utils;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class SqlPool {
	/*
	 * 用SqlPool.getPool().getConnection()，获得一个Connection对象，
	 * 就可以进行数据库操作，最后别忘了对Connection对象调用close()方法，
	 * 注意：这里不会关闭这个Connection，而是将这个Connection放回数据库连接池
	 * */
	
    private static DataSource pool;
    	static {
    		Context env = null;
    		try {
              env = (Context) new InitialContext().lookup("java:comp/env");
              pool = (DataSource)env.lookup("jdbc/SqlPool");//连接池名称，这个和配置文件相对应，自己命名一致即可
              
              if(pool==null) 
                  System.err.println("'DBPool' is an unknown DataSource");
              }catch(NamingException ne) {
                  ne.printStackTrace();
          }
    	}
 
   
    	
    public static DataSource getPool() {
        return pool;
    }
    
    
    public static void closeConnection(Connection conn){
    	try{
    		conn.close();
    	}catch(Exception e){
    		System.out.println("Conenction can't be closed exception at SqlPool!");
    	}
    }
    
    public static Connection getConnection(){
    	try{
    		return pool.getConnection();
    	}catch(Exception e){
    		System.out.println("Can't get Connection from SqlPool");
    		return null;
    	}
    }
  //这个方法同closeConnection，因为线程池是由tomcat管理，因此直接关掉连接，相当于把连接放回线程池
    public static void putBackConnection(Connection conn){
    	try{
    		conn.close();
    	}catch(Exception e){
    		System.out.println("Conenction can't be closed exception at SqlPool!");
    	}
    }
    
}


