/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package spam;

import dataset.AESDecryption;
import dataset.AesEncryption;
import java.io.InputStream;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import org.apache.commons.io.FilenameUtils;

@MultipartConfig
public class sends extends HttpServlet {

protected void processRequest(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

Connection con=null;
Statement st=null;
ResultSet rs=null, rs1=null, rs2=null, rs4=null;

try {

AesEncryption aes=new AesEncryption();
AESDecryption des=new AESDecryption();

Class.forName("com.mysql.cj.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://mysql-240cfbf7-spamsql.i.aivencloud.com:21585/defaultdb?useSSL=true&allowPublicKeyRetrieval=true","avnadmin",System.getenv("DB_PASSWORD"));
st=con.createStatement();

String t1=request.getParameter("t1");
String t2=request.getParameter("t2");
String t3=request.getParameter("t3");
String t5=request.getParameter("t5");
String h1=request.getParameter("h1");

// FILE FIX
Part filePart = request.getPart("t4");
String fileName = filePart.getSubmittedFileName();
InputStream fis = null;

if(fileName!=null && !fileName.equals("")){
    fis = filePart.getInputStream();
}

String ext1 = "";
if(fileName!=null){
    ext1 = FilenameUtils.getExtension(fileName);
}

// VALIDATION
if(t1==null || t1.equals("")){
request.setAttribute("chk","chk");
request.setAttribute("mes","Recipient Mail Id Required");
request.getRequestDispatcher("Send.jsp").forward(request,response);
return;
}

// FILE TYPE CHECK
if(fileName!=null && !fileName.equals("")){
if(!(ext1.contains("doc") || ext1.contains("pdf"))){
request.setAttribute("chk","chk");
request.setAttribute("mes","Only PDF/DOC allowed");
request.getRequestDispatcher("Send.jsp").forward(request,response);
return;
}
}

String to[]=t1.split(",");

Date date=new Date();
SimpleDateFormat sdf=new SimpleDateFormat("d-M-yyyy");
SimpleDateFormat sdt=new SimpleDateFormat("hh:mm:ss a");

String mdate=sdf.format(date);
String time=sdt.format(date);

int id=0;
rs=st.executeQuery("select max(id) from mails");
if(rs.next()){
id=rs.getInt(1)+1;
}

// SPAM FLAGS
boolean flag5=false;
boolean flag6=false;

// ✅ FIXED SPAMS CHECK
rs1=st.executeQuery("select * from spams");
while(rs1.next()){
String word=rs1.getString(1);
if(t2.toLowerCase().contains(word.toLowerCase()) ||
   t3.toLowerCase().contains(word.toLowerCase())){
    flag5=true;
    break;
}
}

// ✅ FIXED NEGWORDS CHECK
rs2=st.executeQuery("select * from negwords");
while(rs2.next()){
String word=rs2.getString(1);
if(t2.toLowerCase().contains(word.toLowerCase()) ||
   t3.toLowerCase().contains(word.toLowerCase())){
    flag6=true;
    break;
}
}

// CHECK SPAM LIMIT
int i2=0;
rs4=st.executeQuery("select COUNT(typ) from mails WHERE mto='"+h1+"' and typ='spam'");
if(rs4.next()){
i2=rs4.getInt(1);
}

if(i2>=20){
request.setAttribute("chk","chk");
request.setAttribute("mes","Delete old spam mails (limit reached)");
request.getRequestDispatcher("Send.jsp").forward(request,response);
return;
}

// INSERT MAIL
for(int i=0;i<to.length;i++){

PreparedStatement pstmt=con.prepareStatement(
"insert into mails values (?, ?,?,?,?,?,?,?,?,?,?,?)");

pstmt.setInt(1,id++);
pstmt.setString(2,h1);
pstmt.setString(3,to[i]);
pstmt.setString(4,t2);
pstmt.setString(5,t3);
pstmt.setString(6,mdate);
pstmt.setString(7,time);

// TYPE
if(flag5 || flag6){
pstmt.setString(8,"spam");
}else{
pstmt.setString(8,"successful");
}

// FILE STORE
if(fis!=null){
pstmt.setBinaryStream(9,fis);
pstmt.setString(10,fileName);
}else{
pstmt.setBytes(9,new byte[1]); // avoid null error
pstmt.setString(10,"");
}

pstmt.setString(11,ext1);
pstmt.setString(12,t5);

pstmt.executeUpdate();
}

request.setAttribute("chk","chk");
request.setAttribute("mes","Mail Sent Successfully");

request.getRequestDispatcher("Send.jsp").forward(request,response);

}catch(Exception e){
e.printStackTrace();

request.setAttribute("chk","chk");
request.setAttribute("mes","Error: "+e.getMessage());
request.getRequestDispatcher("Send.jsp").forward(request,response);
}
}

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
processRequest(request,response);
}

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
processRequest(request,response);
}
}
