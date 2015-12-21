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
        <li><a class="selected" href="#">Products</a>
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
	<li class="right"><a class="myorders" href="myOrders.jsp">My Orders</a></li>
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

	<section id="rc">
	
	<section id="rct">
	
	<article>
	
<%

String productName = request.getParameter("productName");
String emailId = (String)session.getAttribute("userId");
	
mconnect mydb = mconnect.createInstance();
DBCollection mycl = mydb.getCollection("cart");
DBCollection mycl1 = mydb.getCollection("products");

out.println("<h2 class='tp'>Shopping Cart</h2>");
	
	if (request.getParameter(productName) != null) {
		int uprice1 = 0;
		String imageLocation1 = " ";
		
		DBCursor cursor = mycl1.find(new BasicDBObject("productName",productName));
		
		while (cursor.hasNext()) {
			BasicDBObject obj = (BasicDBObject) cursor.next();
			uprice1 = obj.getInt("productPrice");
			imageLocation1 = obj.getString("imageLocation");
		}
		
		BasicDBObject query = new BasicDBObject("userId", emailId).append("productName",productName);
		DBObject doc1 = mycl.findOne(query);
		if (doc1 == null){
		int count = mycl.find(new BasicDBObject("userId", emailId)).count();
		BasicDBObject doc = new BasicDBObject("userId", emailId).
			append("productName", productName).
			append("productPrice", uprice1).
			append("imageLocation", imageLocation1).
			append("quantity", 1);
		mycl.insert(doc);
		} else {
			int quant = 1;
			DBCursor cursor2 = mycl.find(query);
			while (cursor2.hasNext()) {
				BasicDBObject obj2 = (BasicDBObject) cursor2.next();
				quant = obj2.getInt("quantity");
			}
			quant = quant+1;
			BasicDBObject update = new BasicDBObject("userId", emailId).append("productName",productName);
			BasicDBObject updatevalue = new BasicDBObject("$set",new BasicDBObject("quantity",quant));
			mycl.update(update, updatevalue);
		}
	} else if (request.getParameter("update") != null) {
		String productName2 = request.getParameter("product");
		int quantity2 = Integer.parseInt(request.getParameter("productQuantity"));
		
		if(quantity2>0){
		BasicDBObject update = new BasicDBObject("userId", emailId).append("productName",productName2);
		BasicDBObject updatevalue = new BasicDBObject("$set",new BasicDBObject("quantity",quantity2));
		mycl.update(update, updatevalue);
		} else {
		BasicDBObject remove = new BasicDBObject("userId", emailId).append("productName",productName2);
		mycl.remove(remove);
		}
	} else if (request.getParameter("removeProduct") != null) {
		String productName3 = request.getParameter("product");
		
		BasicDBObject remove = new BasicDBObject("userId", emailId).append("productName",productName3);
		mycl.remove(remove);
	}
	
		int count1 = mycl.find(new BasicDBObject("userId", emailId)).count();
		if (count1 == 0) {
			out.println("<p>Shopping cart is empty</p>");
		}else {
		DBCursor cursor1 = mycl.find(new BasicDBObject("userId", emailId));
		String productName1 = " ";
		int uprice = 0;
		String imageLocation = " ";
		int quantity = 1;
		int totalPrice = 0;
		int i = 0;
		while (cursor1.hasNext()) {
			i++;
			BasicDBObject obj1 = (BasicDBObject) cursor1.next();
			productName1 = obj1.getString("productName");
			uprice = obj1.getInt("productPrice");
			imageLocation = obj1.getString("imageLocation");
			quantity = obj1.getInt("quantity");
			totalPrice = uprice*quantity;
			
			out.println("<fieldset>");
			out.println("<legend><h2><b>"+i+"</b></h2></legend>");
			//out.println("<nav><ul><li>");
			out.println("<img src = \" "+imageLocation+ " \" width = \"200\" height = \"200\" alt = \"Product Image\">");
			//out.println("</li><li>");
			out.println("<table class='query-table'>");
			out.println("<tr>");
			out.println("<td>Product Name:</td>");
			out.println("<td> <input type=\"text\" name=\"productName\" value= \'"+productName1+"\' readonly> </td>");         
			out.println("</tr>");				
			out.println("<tr>");
			out.println("<td>Product Price: </td>");
			out.println("<td><input type=\"text\" name=\"productPrice\" value= $"+uprice+" readonly> </td>");
			out.println("</tr>");
			//out.println("</table>");
			//out.println("</li><li>");
			//out.println("<table>");
			out.println("<tr>");
			out.println("<form action='addToCart.jsp'>");
			out.println(" <input type=\"hidden\" name=\"product\" size=3 value= '"+productName1+"'> ");
			out.println("<td>Product Quantity:</td>");			
			out.println("<td> <input type=\"number\" name=\"productQuantity\" value= '"+quantity+"'> ");
					
			out.println("<input class=\"formbtn\" type=\"submit\" name=\"update\" value= \"update\"></td></form></tr>");
			out.println("<tr>");
			out.println("<td>Total Cost:</td>");
						
			out.println("<td> <input type=\"text\" name=\"totalcost\" value= $"+totalPrice+" readonly> </td>");
			out.println("</tr>");				
			out.println("<tr>");
			out.println(" <form action=\"addToCart.jsp\">");
			out.println("<input type=\"hidden\" value=\'"+productName1+"\' name= \"product\" >");
			out.println("<td class='nb'> <input class='formbtn' type=\"submit\" name='removeProduct' value= \"Remove Product\" > </td></form>");
			out.println("</tr>");
			out.println("</table>");
			//out.println("</li></ul></nav>");
			out.println("</fieldset>");
			}
			out.println(" <form action=\"checkOut.jsp\">");
			out.println("<br><br><input class='formbtn' type=\"submit\" value=\"CHECKOUT\">");	
			out.println("</form>");
			
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