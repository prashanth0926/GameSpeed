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
	
	mconnect mydb = mconnect.createInstance();
	DBCollection mycl = mydb.getCollection("customerReviews");
	
	BasicDBObject query = new BasicDBObject("productName",productName);
		
	DBCursor cursor = mycl.find(query);
	
	out.println("<h2 class='tp'>Reviews for Product Name: "+productName+"</h2>");
	
	if(cursor.count() == 0){
		out.println("<h3>There are no reviews for this product.</h3>");
	}else{
					
		productName = "";
		String productCategory = "";
		String productPrice = "";
		String retailerName = "";
		String retailerZip = "";
		String retailerCity = "";
		String retailerState = "";
		String sale = "";
		String manufacturerName = "";
		String rebate = "";
		String emailID = "";
		String userAge = "";
		String userGender = "";
		String userOccupation = "";
		String reviewRating = "";
		String reviewDate =  "";
		String reviewText = "";
		
		int i = 1;

		while (cursor.hasNext()) {
			//out.println(cursor.next());
			BasicDBObject obj = (BasicDBObject) cursor.next();

			out.println("<h3> Review# "+i+"</h3>");				
			out.println("<table class='my-table1'>");
			out.println("<tr>");
			out.println("<td> Product Name: </td>");
			productName = obj.getString("productName");
			out.println("<td>" +productName+ "</td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td> Product Category: </td>");
			productCategory = obj.getString("productCategory");
			out.println("<td>" +productCategory+ "</td>");
			out.println("</tr>");
	
			out.println("<tr>");
			out.println("<td> Product Price: </td>");
			productPrice = obj.getString("productPrice").toString();
			out.println("<td>" +productPrice+ "</td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td> Retailer Name: </td>");
			retailerName = obj.getString("retailerName");
			out.println("<td>" +retailerName+ "</td>");
			out.println("</tr>");

			out.println("<tr>");
			out.println("<td> Retailer Zip: </td>");
			retailerZip = obj.getString("retailerZip").toString();
			out.println("<td>" +retailerZip+ "</td>");
			out.println("</tr>");

			out.println("<tr>");
			out.println("<td> Retailer City: </td>");
			retailerCity = obj.getString("retailerCity");
			out.println("<td>" +retailerCity+ "</td>");
			out.println("</tr>");
		
			out.println("<tr>");
			out.println("<td> Retailer State: </td>");
			retailerState = obj.getString("retailerState");
			out.println("<td>" +retailerState+ "</td>");
			out.println("</tr>");		

			out.println("<tr>");
			out.println("<td> Sale: </td>");
			sale = obj.getString("sale");
			out.println("<td>" +sale+ "</td>");
			out.println("</tr>");

			out.println("<tr>");
			out.println("<td> Manufacturer Name: </td>");
			manufacturerName = obj.getString("manufacturerName");
			out.println("<td>" +manufacturerName+ "</td>");
			out.println("</tr>");

			out.println("<tr>");
			out.println("<td> Rebate: </td>");
			rebate = obj.getString("rebate");
			out.println("<td>" +rebate+ "</td>");
			out.println("</tr>");

			out.println("<tr>");
			out.println("<td> Email ID: </td>");
			emailID = obj.getString("emailID");
			out.println("<td>" +emailID+ "</td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td> Age: </td>");
			userAge = obj.getString("userAge").toString();
			out.println("<td>" +userAge+ "</td>");
			out.println("</tr>");

			out.println("<tr>");
			out.println("<td> Gender: </td>");
			userGender = obj.getString("userGender");
			out.println("<td>" +userGender+ "</td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td> Occupation: </td>");
			userOccupation = obj.getString("userOccupation");
			out.println("<td>" +userOccupation+ "</td>");
			out.println("</tr>");

			out.println("<tr>");
			out.println("<td> Review Rating: </td>");
			reviewRating = obj.getString("reviewRating").toString();
			out.println("<td>" +reviewRating+ "</td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td> Review Date: </td>");
			reviewDate = obj.getString("reviewDate");
			out.println("<td>" +reviewDate+ "</td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td> Review Text: </td>");
			reviewText = obj.getString("reviewText");
			out.println("<td>" +reviewText+ "</td>");
			out.println("</tr>");
			out.println("</table>");
			i++;
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