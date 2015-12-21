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
    <nav><ul><li class="right"><a class="" href="logout.jsp"><img src="images/logout.png" width="50px" 

height="50px" ait="logout" /></a></li></ul></nav>
	<div id="body">
	
	<section id='rc'>
	<section id='rct'>
    	<article>
	<h2><b>Sales Man</b></h2>

<%	
	mconnect mydb = mconnect.createInstance();
DBCollection mycl = mydb.getCollection("customerOrders");

DBCursor cursor = mycl.find();

BasicDBObject sort = new BasicDBObject("userId",1).append("orderId",1).append("productPrice",-1);
cursor.sort(sort);

if(cursor.count() == 0){
	out.println("<h4>No Orders have been placed</h4>");
}else{
		String productName = " ";
		String orderid = " ";
		String orderid1 = " "; 
		String userId = " ";
		String userId1 = " ";
		String productPrice = " ";
		String Quantity = " ";
		String total = " ";
		String dd = " ";

	while (cursor.hasNext()) {
		BasicDBObject obj = (BasicDBObject) cursor.next();

		productName = obj.getString("productName");		
		orderid = obj.getString("orderId");
		userId = obj.getString("userId");
		productPrice = obj.getString("productPrice");
		Quantity = obj.getString("quantity");
		total = obj.getString("totalPrice");
		dd = obj.getString("deliveryDate");

		if(!userId1.equals(userId)) {
		%><b><hr class='mo'></b><%
		userId1 = userId;
		out.println("<h2 class='tp'>Orders for Email ID: "+userId+"</h2>");
		}
		
		if(!orderid1.equals(orderid)) {
		%><hr style="border: 1px dashed black;"><%
		orderid1 = orderid;
		out.println("<h3 class='mo'> Order ID: "+orderid+"</h3>");
		}
	
		if (productName == null) {
		
		DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		Date dt = new Date();
		Calendar c = Calendar.getInstance(); 
		Calendar ctd = Calendar.getInstance();
		ctd.setTime(dt);
		c.setTime(dt);
		c.add(Calendar.DATE, 5);
		dt = c.getTime();
		String ds = df.format(dt);
		
	Calendar cf = Calendar.getInstance(); 
	
	Date ddt = df.parse(dd);
	Date td = df.parse(ds);
	c.setTime(td);
	cf.setTime(ddt);

	if(ctd.before(cf)) {
	out.println("<h3> Expected delivery date: "+dd+"</h3>");
	if(c.before(cf)) {
		out.println("<h3> Delivery Status: Not yet shipped <progress class='prcol' value='25' max='100'></progress></h3>");
		}
		else {
		out.println("<h3> Delivery Status: Shipped <progress class='prcol' value='75' max='100'></progress></h3>");
		}
	} else {
	out.println("<h3> Delivery date: "+dd+"</h3>");
	out.println("<h3> Delivery Status: Delivered <progress class='prcol' value='100' max='100'></progress></h3>");
	}

		out.println("<h3> Total Amount: $"+total+"</h3>");

		}else {
		
		out.println("<table class='my-table'>");
		out.println("<tr>");
		out.println("<td> Product Name: </td>");
		out.println("<td>" +productName+ "</td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td> Product Price: </td>");
		out.println("<td> $"+productPrice+"</td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td> Product Quantity: </td>");
		out.println("<td>" +Quantity+ "</td>");
		out.println("</tr>");
		out.println("</table><br>");

	}
	}
	}
%>
<b><hr class='mo'></b>
<form action='salesMan.jsp'>
<input type='hidden' name='orders' value='Orders' />
<input class='formbtn mo' type='submit' name='back' value='BACK' />
</form>
		
	</article>
	</section>
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