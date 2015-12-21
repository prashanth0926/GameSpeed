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

<html>
<head>
<title>GameSpeed</title>
<link rel="icon" type="image/gif" href="images/title_icon.png" />
</head>
<%
String emailId = (String)session.getAttribute("userId");

mconnect mydb = mconnect.createInstance();
DBCollection mycl = mydb.getCollection("cart");

DBCursor cursor = mycl.find(new BasicDBObject("userId", emailId));
int uprice = 0;
int quantity = 1;
int totalPrice = 0;
while (cursor.hasNext()) {
	BasicDBObject obj = (BasicDBObject) cursor.next();
	uprice = obj.getInt("productPrice");
	quantity = obj.getInt("quantity");
	totalPrice = totalPrice + (uprice*quantity);
}
out.println(" <body align='center'>");
out.println("<fieldset>");
out.println("<h3>ORDER TOTAL IS: $"+totalPrice+"</h3>");
out.println("</fieldset>");
out.println(" <form method=\"post\" action=\"placeOrder.jsp\">");
out.println("<fieldset>");
out.println("<legend>Personal information:</legend>");
out.println("<table align='center'>");
out.println("<tr>");
out.println("<td> Full name: </td>");
out.println("<td> <input type=\"text\" name=\"fullName\" required='required'> </td>");
out.println("</tr>");							
out.println("<tr>");
out.println("<td> Address: </td>");
out.println("<td> <input type=\"text\" name=\"address\" required='required'> </td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td> Phone: </td>");
out.println("<td> <input type=\"number\" name=\"phone\" required='required'> </td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td> Card No: </td>");
out.println("<td> <input type=\"number\" name=\"cardno\" required='required'> </td>");
out.println("</tr>");
out.println("</table>");
out.println("</fieldset><br>");
//out.println("<input type=\"hidden\" name=\"TotalAmt\" value='total' /> </td>");
out.println("<input class='formbtn' type=\"submit\" value=\"PLACE ORDER\"> </form>");
out.println("<a href='addToCart.jsp'><input class='formbtn' type=\"submit\" value=\"EDIT-CART\"/ > </a>");		
out.println("</body>");
%>
</html>