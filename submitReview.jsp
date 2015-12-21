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
	
	if (request.getParameter("submitReview") != null) {
		
		String productName1 = request.getParameter("productName");
		String productCategory = request.getParameter("productCategory");
		int productPrice = Integer.parseInt(request.getParameter("productPrice"));
		String retailerName = request.getParameter("retailerName");
		int retailerZip = Integer.parseInt(request.getParameter("retailerZip"));
		String retailerCity = request.getParameter("retailerCity");
		String retailerState = request.getParameter("retailerState");
		String sale = request.getParameter("sale");
		String manufacturerName = request.getParameter("manufacturerName");
		String rebate = request.getParameter("rebate");
		String emailID = request.getParameter("emailID");
		int userAge = Integer.parseInt(request.getParameter("userAge"));
		String userGender = request.getParameter("userGender");
		String userOccupation = request.getParameter("userOccupation");
		int reviewRating = Integer.parseInt(request.getParameter("reviewRating"));
		String reviewDate = request.getParameter("reviewDate");
		String reviewText = request.getParameter("reviewText");
		
		
		DBCollection mycl1 = mydb.getCollection("customerReviews");
		int count1 = mycl1.find().count();
		BasicDBObject doc = new BasicDBObject("_id", count1+1).
			append("productName", productName1).
			append("productCategory", productCategory).
			append("productPrice", productPrice).
			append("retailerName", retailerName).
			append("retailerZip", retailerZip).
			append("retailerCity", retailerCity).
			append("retailerState", retailerState).
			append("sale", sale).
			append("manufacturerName", manufacturerName).
			append("rebate", rebate).
			append("emailID", emailID).
			append("userAge", userAge).
			append("userGender", userGender).
			append("userOccupation", userOccupation).
			append("reviewRating", reviewRating).
			append("reviewDate", reviewDate).
			append("reviewText", reviewText);
			
		mycl1.insert(doc);

		request.getRequestDispatcher("home.jsp").forward(request,response);
		//response.sendRedirect("home.jsp");
	} else {
		
	String Emailid = (String)session.getAttribute("userId");
	String select = " ";
	String select1 = " ";
	String select2 = " ";
	String select3 = " ";
	String select4 = " ";
	String select5 = " ";
	String select6 = " ";
	String select7 = " ";
	String select8 = " ";
	String select9 = " ";
	String select10 = " ";
	int uprice = 0;
	String prdctdd = " ";

	DBCollection mycl = mydb.getCollection("products");	
	
	DBCursor cursor = mycl.find();
	
	String Product = " ";
	int Price = 0;
	
	while (cursor.hasNext()) {
		BasicDBObject obj = (BasicDBObject) cursor.next();
		Product = obj.getString("productName");
		Price = obj.getInt("productPrice");
	
		if (request.getParameter(Product) != null){
				select = "selected";
				uprice = Price;

			if (Product.equals("XBOX One")) {
					select1 = "selected";
					select4 = "selected";
			}else if (Product.equals("XBOX 360")) {
					select1 = "selected";
					select4 = "selected";
			}else if (Product.equals("PS 3")) {
					select1 = "selected";
					select5 = "selected";
			}else if (Product.equals("PS 4")) {
					select1 = "selected";
					select5 = "selected";
			}else if (Product.equals("Wii")) {
					select1 = "selected";
					select6 = "selected";
			}else if (Product.equals("Wii U")) {
					select1 = "selected";
					select6 = "selected";
			}else if (Product.equals("FIFA 16")) {
					select2 = "selected";
					select7 = "selected";
			}else if (Product.equals("COD AW")) {
					select2 = "selected";
					select8 = "selected";
			}else if (Product.equals("GTA V")) {
					select2 = "selected";
					select9 = "selected";
			}else if (Product.equals("SK")) {
					select3 = "selected";
					select10 = "selected";
			}else {
				
			}
			}
		else {
		select = " ";
		}
		prdctdd = prdctdd + "<option value='"+Product+"' "+select+">"+Product+"</option>";
		}				

	
	out.println("<h2 class='tp'>Write Review for Product Name: "+productName+"</h2>");
	
	
	String pagecontent = "<form method='get' action='submitReview.jsp'><table class='query-table'><tr><td> Product Model Name: </td><td><select name='productName'>"
			+ prdctdd + "</select></td></tr><tr><td> Product Category: </td><td> <select name='productCategory'>"
			+ "<option value='Console'" +select1+ ">Gaming Console</option><option value='Game'" +select2+ ">Game</option><option value='Accessory'" +select3+ ">Accessory</option><option value='Accessory'>Other</option>"
			+ "</select></td></tr><tr><td> Product Price: </td><td><input type = 'number' name = 'productPrice' value='" +uprice+ "' readonly/> </td>"
			+ "</tr><tr><td> Retailer Name: </td><td><select name='retailerName'><option value='GameSpeed'>Game Speed</option></select></td></tr>"
			+ "<tr><td> Retailer Zip: </td><td><input type = 'number' name = 'retailerZip' size = 6/> </td></tr><tr><td> Retailer City: </td>"
			+ "<td><input type = 'text' name = 'retailerCity' size = 20/> </td></tr><tr><td> Retailer State: </td><td><input type = 'text' name = 'retailerState' size = 20/> </td>"
			+ "</tr><tr><td> Product On Sale: </td><td class='radio'> <input type = 'radio' name = 'sale' value = 'Yes'/> Yes &nbsp <input type = 'radio' name = 'sale' value = 'No'/> No </td>"
			+ "</tr><tr><td> Manufacturer Name: </td><td><select name='manufacturerName'><option value='Microsoft'" +select4+ ">Microsoft</option><option value='Sony'" +select5+ ">Sony</option>"
			+ "<option value='Nintendo'" +select6+ ">Nintendo</option><option value='EA'" +select7+ ">EA</option><option value='Activision'" +select8+ ">Activision</option><option value='Take Two Interactive'" +select9+ ">Take Two Interactive</option><option value='Skullcandy'" +select10+ ">Skullcandy</option><option value='Other'>Other</option></select></td></tr> "
			+ "<tr><td> Manufacturer Rebate: </td><td class='radio'> <input type = 'radio' name = 'rebate' value = 'Yes'/> Yes &nbsp <input type = 'radio' name = 'rebate' value = 'No'/> No </td></tr><tr><td> Email ID: </td><td><input type = 'email' name = 'emailID' value='"+Emailid+"' readonly /> </td></tr><tr><td> Age: </td>"
			+ "<td><input type = 'number' name = 'userAge' size = 3/> </td></tr><tr><td> Gender: </td><td class='radio'><input type = 'radio' name = 'userGender' value = 'Male'/> Male &nbsp"
			+ "<input type = 'radio' name = 'userGender' value = 'Female'/> Female</td></tr><tr><td> Occupation: </td><td>"
			+ "<input type = 'text' name = 'userOccupation' size = 20/> </td></tr><tr><td> Review Rating: </td>"
			+ "<td class='radio'><input type = 'radio' name = 'reviewRating' value = '1'/>1 &nbsp<input type = 'radio' name = 'reviewRating' value = '2'/>2 &nbsp"
			+ "<input type = 'radio' name = 'reviewRating' value = '3'/>3 &nbsp<input type = 'radio' name = 'reviewRating' value = '4'/>4 &nbsp<input type = 'radio' name = 'reviewRating' value = '5'/>5"
			+ "</td></tr><tr><td> Review Date: </td><td><input type = 'date' name = 'reviewDate' size = 10/> </td></tr><tr><td> Review Text: </td>"
			+ "<td><textarea name='reviewText' rows='4' cols='50'> </textarea></td></tr><tr><td></td><td><input class='formbtn' type = 'submit' name='submitReview' value = 'SUBMIT REVIEW'/> </td>"
			+ "</tr></table></form>";

			out.println(pagecontent);
			
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