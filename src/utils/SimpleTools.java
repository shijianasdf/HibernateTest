package utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class SimpleTools {

	public String generateTime(String type){
		String time = "";
		SimpleDateFormat sdf = null;
		Calendar calendar = null;
		if(type.equalsIgnoreCase("second"))
			sdf= new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");	//设置日期格式，形如2014-05-07T09:43:15.417+0800
		if(type.equalsIgnoreCase("day"))
			sdf= new SimpleDateFormat("yyyy-MM-dd");	//设置日期格式，形如2014-05-07
		calendar = Calendar.getInstance();
		time = sdf.format(calendar.getTime());
		return time;
	}
	
}
