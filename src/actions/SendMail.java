package actions;

import java.util.Calendar;  
import java.util.Properties;  
  
import javax.mail.Authenticator;  
import javax.mail.MessagingException;  
import javax.mail.PasswordAuthentication;  
import javax.mail.Session;  
import javax.mail.Transport;  
import javax.mail.Message.RecipientType;  
import javax.mail.internet.InternetAddress;  
import javax.mail.internet.MimeMessage;  
  
public class SendMail {  
    @SuppressWarnings("static-access")  
    public static void sendMessage(String smtpHost, String from,  
            String fromUserPassword, String to, String subject,  
            String messageText, String messageType) throws MessagingException {  
        // 第一步：配置javax.mail.Session对象  
        System.out.println("为" + smtpHost + "配置mail session对象");   
        Properties props = new Properties();  
        props.put("mail.smtp.host", smtpHost);  
        props.put("mail.smtp.starttls.enable","true");//使用 STARTTLS安全连接  
        //props.put("mail.smtp.port", "465");        //google使用465或587端口  
        props.put("mail.smtp.auth", "true");        // 使用验证  
        props.put("mail.debug", "true");  
        Session mailSession = Session.getInstance(props,new MyAuthenticator(from,fromUserPassword));  
        // 第二步：编写消息  
        System.out.println("编写消息from——to:" + from + "——" + to);  
  
        InternetAddress fromAddress = new InternetAddress(from);  
        InternetAddress toAddress = new InternetAddress(to);  
  
        MimeMessage message = new MimeMessage(mailSession);  
  
        message.setFrom(fromAddress);  
        message.addRecipient(RecipientType.TO, toAddress);  
  
        message.setSentDate(Calendar.getInstance().getTime());  
        message.setSubject(subject);  //邮箱主题  
        message.setContent(messageText, messageType);  //邮箱信息 
        System.out.println("第二步 yes"); 
        // 第三步：发送消息  
        Transport transport = mailSession.getTransport("smtp"); //定义发送协议         
        //transport.connect(server, username, password)
        transport.connect(smtpHost,"jianshi", fromUserPassword);//登录邮箱  
        transport.send(message, message.getRecipients(RecipientType.TO));//发送邮件  
        System.out.println("message yes");  
    }  
  
    public static void main(String[] args) {  
        try {  
        	//smtp.gmail.com  jianshi
        	//smtp.sina.com  shijianasdf
        	//smtp.qq.com  jianjian
        	String host = "smtp.gmail.com";
        	String from = "shijian311@gmail.com";
        	String password = "";
        	String to = "280462610@qq.com";
        	String subject = "nihao";
        	String messageText = "please click <a href='http://www.baidu.com'>http://www.baidu.com</a>";
        	String messageType = "text/html;charset=gbk";//发送HTML邮件，内容样式比较丰富
//            SendMail.sendMessage("smtp.gmail.com", "shijian311@gmail.com",  
//                    "", "shijianasdf@sina.com", "nihao",  
//                    "---------------wrwe-----------",  
//                    "text/html;charset=gb2312");
            SendMail.sendMessage(host,from,password,to,subject,messageText,messageType);  
        } catch (MessagingException e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
        }  
    }  
}  
class MyAuthenticator extends Authenticator{  
    String userName="";  
    String password="";  
    public MyAuthenticator(){  
          
    }  
    public MyAuthenticator(String userName,String password){  
        this.userName=userName;  
        this.password=password;  
    }  
     protected PasswordAuthentication getPasswordAuthentication(){     
        return new PasswordAuthentication(userName, password);     
     }   
}  
