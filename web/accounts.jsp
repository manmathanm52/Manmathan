<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="spam.DbConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Privacy policy - Privacy policy Page | Design Company - Free Website Template from Templatemonster.com</title>
  <meta charset="utf-8">
  <link rel="stylesheet" href="css/reset.css" type="text/css" media="all">
  <link rel="stylesheet" href="css/style.css" type="text/css" media="all">
  <script type="text/javascript" src="js/jquery-1.4.2.min.js" ></script>
  <script type="text/javascript" src="js/cufon-yui.js"></script>
  <script type="text/javascript" src="js/Humanst521_BT_400.font.js"></script>
  <script type="text/javascript" src="js/Humanst521_Lt_BT_400.font.js"></script>
  <script type="text/javascript" src="js/cufon-replace.js"></script>
	<script type="text/javascript" src="js/roundabout.js"></script>
  <script type="text/javascript" src="js/roundabout_shapes.js"></script>
  <script type="text/javascript" src="js/gallery_init.js"></script>
  <!--[if lt IE 7]>
  	<link rel="stylesheet" href="css/ie/ie6.css" type="text/css" media="all">
  <![endif]-->
  <!--[if lt IE 9]>
  	<script type="text/javascript" src="js/html5.js"></script>
    <script type="text/javascript" src="js/IE9.js"></script>
  <![endif]-->
  <style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
  </style>
</head>

<body>
  <!-- header -->
  <header>
    <div class="container">
    	<h4><a href="index.jsp">  </a></h4><h1><a href="index.jsp"> </a></h1>
      <nav>
        <ul>
        <li><a href="Admin.jsp">Home</a></li>
          <li><a href="spammers.jsp">Control</a></li>
 <li><a href="index.jsp">Signout</a></li>
        </ul>
      </nav>
    </div>
	</header>
  <!-- #gallery -->
  
  <!-- /#gallery -->
  <div class="main-box">
    <div class="container">
      <div class="inside">
        <form action="account" method="post">
<%
String chk=(String)request.getAttribute("chk");
String mes="";
if(chk!=null)
{
    mes=(String)request.getAttribute("mes");
}   
Connection con=null;
    Statement st=null;
    ResultSet rs=null;  
con=DbConnection.getConnection();
st=con.createStatement();     
%>
        <center>
       <br />
         <h2>USER ACCOUNTS</h2>
		 <table width="871" height="157" border="1" style="background-color:#E5E5E5">
  <tr>
    <td width="815" height="141">

        <table width="855" height="106" border="1" >
           <tbody>
                <tr>
                  <td width="204" height="27" bgcolor="#55AA00" class="aligncenter"><span class="style1">MAIL ID</span></td>
                    <td width="206" bgcolor="#55AA00" class="aligncenter"><span class="style1">USER NAME</span></td>
                    <td width="368" bgcolor="#55AA00" class="aligncenter"><span class="style1">GENDER</span></td>
					<td width="368" bgcolor="#55AA00" class="aligncenter"><span class="style1">DOB</span></td>
					<td width="368" bgcolor="#55AA00" class="aligncenter"><span class="style1">ADDRESS</span></td>
					<td width="368" bgcolor="#55AA00" class="aligncenter"><span class="style1">PINCODE</span></td>
					<td width="368" bgcolor="#55AA00" class="aligncenter"><span class="style1">CONTACT</span></td>
					<td width="368" bgcolor="#55AA00" class="aligncenter"><span class="style1">STATUS</span></td>
					<td width="368" bgcolor="#55AA00" class="aligncenter"><span class="style1">SELECT</span></td>
                </tr>
         
     
           
<%String t1="",t2="",t3="",t4="",t5="",t6="",t7="",t8="";
   rs=st.executeQuery("select * from signup");
while(rs.next())
{
    t1=rs.getString(1);
    t2=rs.getString(2);
    t3=rs.getString(3);
    t4=rs.getString(4);
    t5=rs.getString(5);
    t6=rs.getString(6);
    t7=rs.getString(7);
    t8=rs.getString(9);
%>
<tr style="border:thin; border-bottom-color:#990000;">
                    <td  class="aligncenter"  ><%=t7%></td>
                    <td class="aligncenter" ><%=t1%></td>
                    <td class="aligncenter" ><%=t2%></td>
					<td class="aligncenter" ><%=t3%></td>
					<td class="aligncenter" ><%=t4%></td>
					<td class="aligncenter" ><%=t5%></td>
					<td class="aligncenter" ><%=t6%></td>
					<td class="aligncenter" ><%=t8%></td>
					<td class="aligncenter" ><input type="radio" name="r1" value="<%=t7%>" /></td>
</tr>
 
<%    
}                   
%>   
             </tbody>
</table>
</td>
  </tr>
</table>
<br />
             <input type="submit" name="b1" value="Activate" style="height:35px; width:85px; background-color:#6DB44B; border-bottom-style:ridge; " />
        <h3><%=mes%></h3>
      
                
    </center>
        </form>
      </div>
    </div>
  </div>
  <!-- footer -->
  <footer>
    <div class="container">
    	<div class="wrapper">
        <div class="fleft">Copyright - Type in your name here</div>
        <div class="fright"><!--<a rel="nofollow" href="http://www.templatemonster.com/" target="_blank">Website template</a> designed by TemplateMonster.com&nbsp; &nbsp; |&nbsp; &nbsp; <a href="http://templates.com/product/3d-models/" target="_blank">3D Models</a> provided by Templates.com--></div>
      </div>
    </div>
  </footer>
  <script type="text/javascript"> Cufon.now(); </script>
</body>
</html>
