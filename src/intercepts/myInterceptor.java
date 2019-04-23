package intercepts;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.opensymphony.xwork2.ognl.OgnlValueStack;
import com.opensymphony.xwork2.util.ValueStack;



public class myInterceptor implements Interceptor {
	private static final long serialVersionUID = 1L;
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init() {
		// TODO Auto-generated method stub
		
	}
	public String intercept(ActionInvocation invocation) throws Exception {
		System.out.println("============"+invocation.getInvocationContext().getName());  
        System.out.println("============"+invocation.getInvocationContext().getLocale());  
        System.out.println("============"+invocation.getInvocationContext().getParameters());
		ActionContext act = invocation.getInvocationContext();
		Map<String, Object> params = invocation.getInvocationContext().getParameters();
		//String idName="";
		ArrayList<String> parameters=new ArrayList<String>();
		for(String key : params.keySet()) {  //map的keySet() key对应map中的String
            	Object obj = params.get(key);  
                if(obj instanceof String[]) {  
                	String[] array = (String[])obj;  
                	System.out.print("Param: " + key + "values: ");  
                	for(String value : array) {  
                		System.out.print(value);
                		//idName=value;
                		parameters.add(value);
                }  
                System.out.print("\n");  
            }  
        } 
		System.out.println(parameters);
		//System.out.println(idName);
		if(parameters.size()==0){
			return invocation.invoke();
		}
		
		if(parameters.get(2).contains("AM")&&!parameters.get(2).equals("AM")){
			act.put("tableName", "array_matrix");
		    act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "id");
			act.put("v", parameters.get(2));
		}else if(parameters.get(2).equals("AM")){
			act.put("tableName", "array_matrix");
		    act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "oneDesc");
			act.put("v", parameters.get(1));
		}
			
		
		if(parameters.get(2).contains("GM")&&!parameters.get(2).equals("GM")){
			act.put("tableName", "general_matrix");
			act.put("cols", "oneDesc,inputUser");
			act.put("number", 2);
			act.put("searchColName", "id");
			act.put("v", parameters.get(2));
		}else if(parameters.get(2).equals("GM")){
			act.put("tableName", "general_matrix");
		    act.put("cols", "oneDesc,inputUser");
			act.put("number", 2);
			act.put("searchColName", "oneDesc");
			act.put("v", parameters.get(1));
		}
		if(parameters.get(2).contains("NT")&&!parameters.get(2).equals("NT")){
			act.put("tableName", "network_table");
			act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "id");
			act.put("v", parameters.get(2));
		}else if(parameters.get(2).equals("NT")){
			act.put("tableName", "network_table");
		    act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "oneDesc");
			act.put("v", parameters.get(1));
		}
		if(parameters.get(2).contains("IT")&&!parameters.get(2).equals("IT")){
			act.put("tableName", "interaction_table");
			act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "id");
			act.put("v", parameters.get(2));
		}else if(parameters.get(2).equals("IT")){
			act.put("tableName", "interaction_table");
		    act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "oneDesc");
			act.put("v", parameters.get(1));
		}
		if(parameters.get(2).contains("RT")&&!parameters.get(2).equals("RT")){
			act.put("tableName", "region_table");
			act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "id");
			act.put("v", parameters.get(2));
		}else if(parameters.get(2).equals("RT")){
			act.put("tableName", "region_table");
		    act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "oneDesc");
			act.put("v", parameters.get(1));
		}
		if(parameters.get(2).contains("SM")&&!parameters.get(2).equals("SM")){
			act.put("tableName", "seq_matrix");
			act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "id");
			act.put("v", parameters.get(2));
		}else if(parameters.get(2).equals("SM")){
			act.put("tableName", "seq_matrix");
		    act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "oneDesc");
			act.put("v", parameters.get(1));
		}
		if(parameters.get(2).contains("ST")&&!parameters.get(2).equals("ST")){
			act.put("tableName", "super_table");
			act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "id");
			act.put("v", parameters.get(2));
		}else if(parameters.get(2).equals("ST")){
			act.put("tableName", "super_table");
		    act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "oneDesc");
			act.put("v", parameters.get(1));
		}
		if(parameters.get(2).contains("VT")&&!parameters.get(2).equals("VT")){
			act.put("tableName", "vector_table");
			act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "id");
			act.put("v", parameters.get(2));
		}else if(parameters.get(2).equals("VT")){
			act.put("tableName", "vector_table");
		    act.put("cols", "oneDesc,inputUser,libraryType");
			act.put("number", 3);
			act.put("searchColName", "oneDesc");
			act.put("v", parameters.get(1));
		}
	   
		return invocation.invoke();
	}
		
}
