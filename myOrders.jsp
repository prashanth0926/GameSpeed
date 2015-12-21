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
%>

<%@ page import="beans.*" %>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>GameSpeed</title>
	<link rel="icon" type="image/gif" href="images/title_icon.png" />
	<link rel="stylesheet" href="styles.css" type="text/css" />
</head>

<body onload="init()">
<div id="container">
    <header>
    	<h1><a href="#">Game<span>Speed</span></a></h1>
	<h2>connecting gamers</h2>
    </header>
    <nav>
    	<ul>
	<li><a class="" href="home.jsp">Home</a></li>
        <li><a class="" href="#">Products</a>
	    <ul class="dd1">
            <li><a href="#">Consoles</a>
	    <ul class="dd2">
		<li><a href="microsoft.jsp">Microsoft</a></li>
		<li><a href="sony.jsp">Sony</a></li>
		<li><a href="nintendo.jsp">Nintendo</a></li>
	    </ul></li>
            <li><a href="#">Games</a>
	    <ul class="dd2">
		<li><a href="ea.jsp">Electronic arts</a></li>
		<li><a href="activision.jsp">Activision</a></li>
		<li><a href="ttint.jsp">Take-two Interactive</a></li>
	    </ul></li>
            <li><a href="accessories.jsp">Accessories</a></li>
	</ul></li>
	<li><a class="" href="newProducts.jsp">New Products</a></li>
	<li><a class="" href="analytics.jsp">Data Analytics</a></li>
	<li class="right"><a class="" href="logout.jsp"><img src="images/logout.png" width="50px" 

height="50px" ait="logout" /></a></li>
	<li class="right"><a class="" href="addToCart.jsp"><img src="images/cart.png" 

width="75px" height="50px" ait="cart" /></a></li>
	<li class="right"><a class="myorders selected" href="myOrders.jsp">My Orders</a></li>
	<li class="search">
                        	<form name="autofillform" action="autocomplete" autocomplete="off" class="searchform" >
				<table><tr>
                                <td><p><input class="s" id="complete-field" onkeyup="doCompletion()" type="text" size="15" name="s" placeholder="Search product" /></p></td>
				<td><input class="img" type="image" src="images/search.png" height="20px" width="20px" alt="search" /></td>
                               	</tr>
<tr>
              <td id="auto-row" colspan="2">
                <table id="complete-table" class="popupBox"></table>
              </td>
          </tr>
</table>
    </form>
	</li>
	</ul>
    </nav>




    <div id="body">		

	

<%
String emailId = (String)session.getAttribute("userId");

mconnect mydb = mconnect.createInstance();
DBCollection mycl = mydb.getCollection("customerOrders");

if (request.getParameter("cancel") != null) {
	String dd1 = request.getParameter("deliverydate");
	String orderid2 = request.getParameter("orderid");
	
	BasicDBObject query = new BasicDBObject("userId", emailId).
									append("orderId", orderid2);
	
	DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
	Date dt = new Date();
	Calendar c = Calendar.getInstance(); 
	c.setTime(dt);
	c.add(Calendar.DATE, 5);
	dt = c.getTime();
	String ds = df.format(dt);
		
	Calendar cf = Calendar.getInstance(); 
	
	Date ddt = df.parse(dd1);
	Date td = df.parse(ds);
	c.setTime(td);
	cf.setTime(ddt);
	
	if(c.before(cf)) {
		mycl.remove(query);
		out.println("<p class='invalid'> OrderID: "+orderid2+ " has been cancelled </p>");
		}
		else {
		out.println("<p class='invalid'>Order cannot be cancelled as there are less than 5 days left for delivery</p>");
		}
}

DBCursor cursor = mycl.find(new BasicDBObject("userId", emailId));

BasicDBObject sort = new BasicDBObject("orderId",1).append("productPrice",-1);
cursor.sort(sort);

if(cursor.count() == 0){
%>
<section id="rc">
	
	<section id="rct">
	
	<article>
<%
	out.println("<h4>No Orders have been placed</h4>");
}else{
%>
<section id="rc">
	
	<section id="rct">
	
	<article>
<%
	out.println("<h2 class='tp'>Your Orders</h2>");
		String orderid1 = " ";
	while (cursor.hasNext()) {
		//out.println(cursor.next());
		BasicDBObject obj = (BasicDBObject) cursor.next();

		String productName = obj.getString("productName");		
		String orderid = obj.getString("orderId");
		String productPrice = obj.getString("productPrice");
		String Quantity = obj.getString("quantity");
		String total = obj.getString("totalPrice");
		String dd= obj.getString("deliveryDate");
		
		if(!orderid1.equals(orderid)) {
		orderid1 = orderid;
		out.println("<h3 class='mo'> Order ID: "+orderid+"</h3>");
		}

		if(productName != null) {
		
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
		out.println("<h3> Delivery Status: Not yet shipped <progress value='25' max='100'></progress></h3>");
		}
		else {
		out.println("<h3> Delivery Status: Shipped <progress value='75' max='100'></progress></h3>");
		}
	} else {
	out.println("<h3> Delivery date: "+dd+"</h3>");
	out.println("<h3> Delivery Status: Delivered <progress value='100' max='100'></progress></h3>");
	}

		out.println("<h3> Total Amount: $"+total+"</h3>");
		out.println("<form action='myOrders.jsp'><input class='formbtn' type='submit' name='cancel' value='CANCEL ORDER' />");
		out.println("<input type='hidden' name='deliverydate' value='"+dd+"' />");
		out.println("<input type='hidden' name='orderid' value='"+orderid+"' /></form><br><br>");
		}

	}
	
}	

%>

</article>

	</section>
	
	</section>
	
        
    <aside class="sidebar">
	
            <ul>	
               <li>
                    <h4>Consoles</h4>
                    <ul>
                        <li><a href="microsoft.jsp">XBOX One</a></li>
                        <li><a href="microsoft.jsp">XBOX 360</a></li>
                        <li><a href="sony.jsp">PS 3</a></li>
			<li><a href="sony.jsp">PS 4</a></li>
                    	<li><a href="nintendo.jsp">Wii</a></li>
			<li><a href="nintendo.jsp">Wii U</a></li>
                    </ul>
                </li>
                
                <li>
                    <h4>Games</h4>
                    <ul>
                        <li><a href="ea.jsp">FIFA 16</a></li>
                        <li><a href="activision.jsp">Call of Duty-Advanced Warfare</a></li>
			<li><a href="ttint.jsp">Grand Theft Auto V</a></li>
                    </ul>
                </li>
                                
                <li>
                    <h4>Accessories</h4>
                    <ul>
                        <li><a href="accessories.jsp">Headset</a></li>
                    </ul>
                </li>

		<li>
                    <h4>New Products</h4>
                    <ul>
                        <li><a href="newProducts.jsp">New Products</a></li>
                    </ul>
                </li>

            </ul>
		
    </aside>
    
	<div class="clear"></div>
	</div>
    
	<footer>
	
        <div class="footer-content">
        <h5><a href="#">Reviews</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a 

href="#">Returns</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a 

href="#">Support</a></h5>
	 <div class="clear"></div>
        </div>
		
        <div class="footer-bottom">
            <p>&copy2015 GameSpeed by Prashanth Molakala(A20322954)</p>
        </div>
		
    </footer>
</div>

        <script type="text/javascript" src="javascript.js"></script>
        
</body>

</html>