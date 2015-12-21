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
	
	String person = request.getParameter("person");
	
	String userID = request.getParameter("emailId");
	String pwd = request.getParameter("pwd");
	String rpwd = request.getParameter("rpwd");

	mconnect mydb = mconnect.createInstance();
	DBCollection mycl = mydb.getCollection(person);
	
	BasicDBObject query = new BasicDBObject();
	query.put("_id",userID);
		
	DBObject doc1 = mycl.findOne(query);
	
	if (!userID.trim().equals("") && !pwd.trim().equals("") && pwd.equals(rpwd) && doc1 == null) {	
	BasicDBObject doc = new BasicDBObject("_id",userID).append("password",pwd);
	mycl.insert(doc);
	request.getRequestDispatcher("index.jsp").forward(request,response);
	//response.sendRedirect("index.jsp");
	} else if(!pwd.equals(rpwd)){
%>
		<p class='invalid'>Password does not match</p>
	<%}else if(doc1 != null){
		%>
		<p class='invalid'>Email already exists</p>
	<%}else {
		%>
		<p class='invalid'>Please enter all the fields</p>
	<%}
}
%>		

	<section id="login">
	<form method="post" action="signup.jsp">		
	<h4>SIGN UP AS:&nbsp
	<select name="person">
	     <option value="storeManagerId">Strore Manager</option>
     	     <option value="customerId" selected>Customer</option>
             <option value="salesManId">Salesman</option>
        </select></h4>
	<table>
	<tr><td><h5>EMAIL ADDRESS:</h5></td><td><p><input type="email" size="25" name="emailId" value=""/></p></td></tr>
	<tr><td><h5>PASSWORD:</h5></td><td><p><input type="password" size="25" name="pwd" value=""/></p></td></tr>
	<tr><td><h5>RE-ENTER PASSWORD:</h5></td><td><p><input type="password" size="25" name="rpwd" /></p></td></tr>
	<tr><td><h5></h5></td><td><input class = "submit-button" type = "submit" name = "signup" value = "SIGN UP"></td></tr>
	</table></form>
	<p><a href = "index.jsp">Already have an account? LOGIN</a></p>
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