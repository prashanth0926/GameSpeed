<%@ page language="java" 
import="com.mongodb.MongoClient"
import="com.mongodb.Mongo"
import="com.mongodb.DB"
import="com.mongodb.DBCollection"
import="com.mongodb.BasicDBObject"
import="com.mongodb.DBObject"
import="com.mongodb.DBCursor"
import="java.net.UnknownHostException"
import="java.util.*"
import="java.text.*"
import="java.io.*"
%>

<%@ page import="beans.*" %>

<html>
<head>
<title>GameSpeed</title>
<link rel="icon" type="image/gif" href="images/title_icon.png" />
</head>
<%
String emailId = (String)session.getAttribute("userId");

String name = request.getParameter("fullName");
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String cardno = request.getParameter("cardno");

out.println("<BODY align='center'>");
out.println("<div id="+"section"+">");
out.println("<H1> ORDER HAS BEEN PLACED </H1>");
Random rand = new Random();
int n = rand.nextInt(1000) + 1;
String oid = Integer.toString(n); 
out.println("Order Confirmation number: "+n+"<br>");
	
DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
Date dt = new Date();
Calendar c = Calendar.getInstance(); 
c.setTime(dt);
c.add(Calendar.DATE, 14);
dt = c.getTime();
String ds = df.format(dt);
out.println("\nOrder will be delivered by :"+dt+"<br>");
out.println("<br><a href="+"home.jsp"+"><input type='submit' value='Back to GameSpeed'</a><br>");  
out.println("</div>");
out.println("</body>");

mconnect mydb = mconnect.createInstance();
DBCollection mycl = mydb.getCollection("customerOrders");
DBCollection mycl1 = mydb.getCollection("cart");

DBCursor cursor = mycl1.find(new BasicDBObject("userId", emailId));
int uprice = 0;
int quantity = 1;
int totalPrice = 0;
String productName = " ";
while (cursor.hasNext()) {
	BasicDBObject obj = (BasicDBObject) cursor.next();
	productName = obj.getString("productName");
	uprice = obj.getInt("productPrice");
	quantity = obj.getInt("quantity");
	totalPrice = totalPrice + (uprice*quantity);
	
	BasicDBObject doc = new BasicDBObject("userId", emailId).
			append("productName", productName).
			append("productPrice", uprice).
			append("quantity", quantity).
			append("orderId", oid);
		mycl.insert(doc);
}

BasicDBObject doc1 = new BasicDBObject("userId", emailId).
append("fullName", name).
append("address", address).
append("phone", phone).
append("cardNumber", cardno).
append("orderId", oid).
append("deliveryDate", ds).
append("totalPrice", totalPrice);

mycl.insert(doc1);

mycl1.remove(new BasicDBObject("userId",emailId));

%>
</html>