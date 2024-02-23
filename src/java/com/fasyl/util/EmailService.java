/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.util;

//import com.fasyl.corpIntBankingadmin.infrastructure.PropertiesManager;
import java.io.File;
import java.io.StringWriter;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;


public class EmailService {
    
    private static final String SMTP_AUTH_USER = "morufoye@gmail.com";
    private static final String SMTP_AUTH_PWD = "samtahir1";
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT= "587";
    
    //String host = "smtp.gmail.com";
    //String port = "587";
    
    
    
    public EmailService() {
         
    }

    public int sendemail(String destination, String user_id, String ref_id, String init_time, String auth_email) throws Exception {
        Properties props = new Properties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", SMTP_PORT);
        System.out.println("trying to send email");
        Authenticator auth = new SMTPAuthenticator();
        Session mailSession = Session.getInstance(props, auth);
        Transport transport = mailSession.getTransport();
        MimeMessage message = new MimeMessage(mailSession);
        message.setSubject("Notification of Pending Job"); 
        
      
        
        VelocityEngine ve = new VelocityEngine();
        ve.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath"); 
        ve.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());      
        ve.init();
        Template t = ve.getTemplate("resources/emailtemplate.html"); 
        VelocityContext context = new VelocityContext();
        
        context.put("userId", user_id);
        context.put("refId", ref_id);
        context.put("initTime",init_time);
        
        StringWriter out = new StringWriter();
        t.merge( context, out );
        
        message.setContent(out.toString(), "text/html");
        message.setFrom(new InternetAddress(SMTP_AUTH_USER));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destination, false));
        message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(auth_email, false));
        
        transport.connect();
        
        
        transport.sendMessage(message,
                message.getRecipients(Message.RecipientType.TO));
        transport.close();
        return 0;
    
    }

     public int sendemailG(String destination, String title, String messageBody, String auth_email) throws Exception {
        Properties props = new Properties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", SMTP_PORT);
        System.out.println("trying to send email");
        Authenticator auth = new SMTPAuthenticator();
        Session mailSession = Session.getInstance(props, auth);
        Transport transport = mailSession.getTransport();
        MimeMessage message = new MimeMessage(mailSession);
        message.setSubject(title); 
        message.setContent(messageBody, "text/html");
        message.setFrom(new InternetAddress(SMTP_AUTH_USER));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destination, false));
        message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(auth_email, false));
        
        transport.connect();
        
        
        transport.sendMessage(message,
                message.getRecipients(Message.RecipientType.TO));
        transport.close();
        return 0;
    
    }
    
    
    public int sendMultipartEmail(String host, String port, String destination, String sender, String title, String messagebody, File...files) throws Exception {
        Properties props = new Properties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", port);

        Authenticator auth = new SMTPAuthenticator();
        Session mailSession = Session.getInstance(props, auth);

        // Define message
        MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(sender));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destination, false));
        // message.addRecipient(Message.RecipientType.CC, ccAddress);
        message.setRecipients(Message.RecipientType.CC, SMTP_AUTH_USER);
        message.setSubject("JavaMail Attachment");

        // Create the message part 
        BodyPart messageBodyPart = new MimeBodyPart();

        // Fill the message
        messageBodyPart.setText("hi");

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);

        // Part two is attachment
        for (File f : files) {
            messageBodyPart = new MimeBodyPart();
            String filename = f.getAbsolutePath();
            DataSource source = new FileDataSource(filename);
            messageBodyPart.setDataHandler(new DataHandler(source));
            messageBodyPart.setFileName(f.getName());
            multipart.addBodyPart(messageBodyPart);
        }

        // Put parts in message
        message.setContent(multipart);

        // Send the message
        Transport.send(message);
        return 0;
    }
    
    
//    //(String destination, String title, String messagebody)    uncomment this for production
//     public int sendemail(String toemail, String tittle, String body)
//  {
//   int result = 1;
//    String Mailserver = null;
//
//    String username = "iba@slcb.com";
//    String password = "int-123IB";
//   
//    Properties props = new Properties();
//
//    props.put("mail.smtp.host", SMTP_HOST);
//    props.put("mail.smtp.starttls.enable", "false");
//    props.put("mail.debug", "true");
//    Session session = null;
//
//    
//      props.put("mail.smtp.auth", "true");
//      session = Session.getInstance(props, new MyPasswordAuthenticator(username, password));
//    
//
//    MimeMessage message = new MimeMessage(session);
//    try
//    {
//      message.setFrom(new InternetAddress("noreply@slcb.com"));
//
//      InternetAddress[] address = InternetAddress.parse(toemail, false);
//
//      message.setRecipients(Message.RecipientType.TO, address);
//      message.setSubject(tittle);
//      System.out.println("body: " + body);
//      message.setContent(body, "text/html");
//      
//      Transport.send(message);
//      result = 0;
//      return result;
//    }
//    catch (AddressException e)
//    {
//      result = 1;
//      e.printStackTrace();
//      return result;
//    }
//    catch (MessagingException e)
//    {
//      result = 1;
//      e.printStackTrace();
//      return result;
//    }
//    catch (Exception ex)
//    {
//      result = 1;
//      ex.printStackTrace();
//      return result; } finally { 
//          return result;
//    }
//    
//  }
    
    

    private class SMTPAuthenticator extends javax.mail.Authenticator {

        public PasswordAuthentication getPasswordAuthentication() {
            String username = SMTP_AUTH_USER;
            String password = SMTP_AUTH_PWD;
            return new PasswordAuthentication(username, password);

        }
    }
    
    
    
    private class MyPasswordAuthenticator extends Authenticator {
    String pw;
    String user;

    public MyPasswordAuthenticator(String username, String password) {
        super();
        this.user = username;
        this.pw   = password;
    }

    public PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(user, pw);
    }
    
}
}
