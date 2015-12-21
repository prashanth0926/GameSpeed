<%@ page language="java" 
import="com.mongodb.MongoClient"
import="com.mongodb.Mongo"
import="com.mongodb.DB"
import="com.mongodb.DBCollection"
import="com.mongodb.BasicDBObject"
import="com.mongodb.DBObject"
import="com.mongodb.DBCursor"
import="java.net.UnknownHostException"
%>

<%@ page import="beans.*" %>

<!DOCTYPE html>
<html>
<head>
<title>GameSpeed</title>
<link rel="icon" type="image/gif" href="images/title_icon.png" />
<link rel="stylesheet" href="styles.css" type="text/css" />
</head>
<body>
<div id="container">
    <header>
    	<h1><a href="#">Game<span>Speed</span></a></h1>
	<h2>connecting gamers</h2>
    </header>
	<div id="body">
	
<%
if (request.getParameter("signup") != null) {
	%>
	<p class='invalid'>Account created successfully</p>
<%
} 

if (request.getParameter("login") != null) {
	
	String person = request.getParameter("person");
	
	String userID = request.getParameter("emailId");
	String pwd = request.getParameter("pwd");

	mconnect mydb = mconnect.createInstance();
	DBCollection mycl = mydb.getCollection(person);
		
	BasicDBObject query = new BasicDBObject("_id",userID).append("password",pwd);
	
	DBObject doc = mycl.findOne(query);
	
	if(doc == null){
%>
		<p class='invalid'>Invalid Credentials</p>
	<%} else {
		synchronized (session) {
		session.setAttribute("userId",userID);
		}
		int i=0;
		
		String[] productName = {"XBOX One","XBOX 360","PS 3","PS 4","Wii","Wii U","FIFA 16","COD AW","GTA V","SK"};
		int[] productPrice = {300,500,450,550,200,250,75,125,65,50};
		String[] imageLocation = {"images/xbox_one.jpg","images/xbox_360.jpg","images/ps3.jpg","images/ps4.jpg","images/wii.jpg","images/wii_u.jpg","images/fifa16.jpg","images/cod_aw.jpg","images/gta5.jpg","images/sk.jpg"};
		
		DBCollection mycl1 = mydb.getCollection("products");
		
		int count = mycl1.find().count();
		
		if(count == 0) {
		for(i=0;i<10;i++) {
				BasicDBObject doc1 = new BasicDBObject("productName",productName[i]).
							append("productPrice",productPrice[i]).
							append("imageLocation",imageLocation[i]).
							append("newUpload","No");
				mycl1.insert(doc1);
		}
		}
		if (person.equals("customerId")){
		request.getRequestDispatcher("home.jsp").forward(request,response);		
		//response.sendRedirect("home.jsp");
		} else if (person.equals("salesManId")){
		request.getRequestDispatcher("salesMan.jsp").forward(request,response);
		} else if (person.equals("storeManagerId")){
		request.getRequestDispatcher("storeManager.jsp").forward(request,response);	
		}
	}
}
%>		

	<section id="login">
	<form method="post" action="index.jsp">		
	<h4>LOGIN AS:&nbsp
	<select name="person">
   	     <option value="storeManagerId"> Store Manager </option>
     	     <option value="customerId" selected>Customer</option>
             <option value="salesManId">Salesman</option>
        </select></h4>
	<table>
	<tr>
	<td><h5>EMAIL ADDRESS: </h5></td>
	<td><h5>PASSWORD: </h5></td>
	</tr>
	<tr>
	<td>
        <p><input type="email" size="25" name="emailId" /></p>
        </td>
	<td>
        <p><input type="password" size="25" name="pwd" /></p>
        </td>
	<td><input class = "submit-button" type = "submit" name = "login" value = "LOGIN"></td>
	</tr>
	</table></form>
	<p><a href = "signup.jsp">New to GameSpeed? Click here to SignUp</a></p>
	</section>
      
	<div class="clear"></div>
	</div>
    
	<footer>
	
        <div class="footer-content">
        <h5><a href="#">Reviews</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#">Returns</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#">Support</a></h5>
        <div class="clear"></div>
        </div>
		
        <div class="footer-bottom">
            <p>&copy GAMESPEED 2015 ALL RIGHTS RESERVED</p>
        </div>
		
    </footer>
</div>

</body>
</html>