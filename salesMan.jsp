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
	
	
	
<%
mconnect mydb = mconnect.createInstance();
DBCollection mycl = mydb.getCollection("products");
DBCollection mycl1 = mydb.getCollection("customerId");
DBCollection mycl2 = mydb.getCollection("customerOrders");

boolean accounts = false;
boolean orders = false;

if(request.getParameter("accounts") != null || request.getParameter("createAccount") != null){
	accounts = true;
} else if(request.getParameter("orders") != null || request.getParameter("addOrder") != null || request.getParameter("updateOrder") != null || request.getParameter("deleteOrder") != null){
	orders = true;
}

if(accounts) {
	if(request.getParameter("createAccount") != null){
		String userID = request.getParameter("emailId");
		String pwd = request.getParameter("pwd");
		
		BasicDBObject query = new BasicDBObject("_id",userID);
			
		DBObject doc1 = mycl1.findOne(query);
		
		if (!userID.trim().equals("") && !pwd.trim().equals("") && doc1 == null) {	
		BasicDBObject doc = new BasicDBObject("_id",userID).append("password",pwd);
		mycl1.insert(doc);
		out.println("<p class='invalid'>Account created successfully</p>");
		}else if(doc1 != null){
			%>
			<p class='invalid'>Email already exists</p>
		<%}else {
			%>
			<p class='invalid'>Please enter all the fields</p>
		<%}

	}
	%>
	
	<section id='rc'>
	<section id='rct'>
    <article>
	<h2><b>Sales Man</b></h2>

	<form method="post" action="salesMan.jsp">
	<table class='my-table mo'>
	<tr><td class='nb'>EMAIL ADDRESS:</td><td class='nb'><input type="email" size="25" name="emailId" value=""/></td></tr>
	<tr><td class='nb'>PASSWORD:</td><td class='nb'><input type="password" size="25" name="pwd" value=""/></td></tr>
	<tr><td class='nb'></td><td class='nb'><input class = "formbtn3" type = "submit" name = "createAccount" value = "CREATE CUSTOMER ACCOUNT"></td></tr>
	</table></form>
<%	
} else if(orders) {
	
	if(request.getParameter("addOrder") != null){
		String productName = request.getParameter("productName");
		int quantity = Integer.parseInt(request.getParameter("productQuantity"));
		String userId = request.getParameter("emailId");
		String fullName = request.getParameter("fullName");
		String phone = request.getParameter("phone");
		String cardno = request.getParameter("cardno");
		String address = request.getParameter("address");
		
		BasicDBObject query = new BasicDBObject("productName",productName);
		DBCursor cursor1 = mycl.find(query);
		int uprice = 0;
		while(cursor1.hasNext()){
			BasicDBObject obj1 = (BasicDBObject) cursor1.next();
			uprice = obj1.getInt("productPrice");
		}
		int totalPrice = uprice*quantity;
		
		out.println("<H3> ORDER HAS BEEN PLACED </H3>");
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
		
		BasicDBObject doc1 = new BasicDBObject("userId", userId).
				append("productName", productName).
				append("productPrice", uprice).
				append("quantity", quantity).
				append("orderId", oid);
			mycl2.insert(doc1);

	BasicDBObject doc2 = new BasicDBObject("userId", userId).
	append("fullName", fullName).
	append("address", address).
	append("phone", phone).
	append("cardNumber", cardno).
	append("orderId", oid).
	append("deliveryDate", ds).
	append("totalPrice", totalPrice);
	mycl2.insert(doc2);
	
	} else if(request.getParameter("updateOrder") != null){
		String orderId = request.getParameter("orderId");
		String set = request.getParameter("uset");
		String userId = " ";
		int totalPrice = 0;
		int uprice = 0;
		int quantity = 0;
		DBCursor cursor3 = mycl2.find(new BasicDBObject("orderId",orderId));
		if(cursor3.count() != 0){
		if(set.equals("addProduct")) {
			String productName = request.getParameter("productName");
			int quantity1 = Integer.parseInt(request.getParameter("productQuantity"));
			
			BasicDBObject query1 = new BasicDBObject("orderId",orderId).append("productName",productName);
			DBCursor cursor2 = mycl2.find(query1);
			if(cursor2.count() == 0){
				DBCursor cursor4 = mycl.find(new BasicDBObject("productName",productName));
				while(cursor4.hasNext()){
					BasicDBObject obj4 = (BasicDBObject) cursor4.next();
					uprice = obj4.getInt("productPrice");
				}
				while(cursor3.hasNext()){
					BasicDBObject obj3 = (BasicDBObject) cursor3.next();
					if(obj3.getString("productName") == null) {
					totalPrice = obj3.getInt("totalPrice");
					}
					userId = obj3.getString("userId");
				}
				totalPrice = totalPrice + (uprice*quantity1);
				
				BasicDBObject doc3 = new BasicDBObject("userId", userId).
						append("productName", productName).
						append("productPrice", uprice).
						append("quantity", quantity1).
						append("orderId", orderId);
					mycl2.insert(doc3);
					
					BasicDBObject update = new BasicDBObject("orderId",orderId).append("productName", null);
					BasicDBObject updatevalue = new BasicDBObject("$set",new BasicDBObject("totalPrice",totalPrice));
					mycl2.update(update, updatevalue);
					
				out.println("<p class='invalid'>"+productName+" added in Order ID:"+orderId+"</p>");
			} else{
				out.println("<p class='invalid'>"+productName+" already exists in the Order ID: "+orderId+"</p>");
			}
			
		} else if(set.equals("removeProduct")){
			String productName = request.getParameter("productName1");
			BasicDBObject query2 = new BasicDBObject("orderId",orderId).append("productName",productName);
			DBCursor cursor5 = mycl2.find(query2);
			if(cursor5.count() == 0){
				out.println("<p class='invalid'>"+productName+" does not exist in the Order ID: "+orderId+"</p>");
			} else{
				while(cursor5.hasNext()){
					BasicDBObject obj5 = (BasicDBObject) cursor5.next();
					uprice = obj5.getInt("productPrice");
					quantity = obj5.getInt("quantity");
				}
				while(cursor3.hasNext()){
					BasicDBObject obj3 = (BasicDBObject) cursor3.next();
					if(obj3.getString("productName") == null) {
						totalPrice = obj3.getInt("totalPrice");
						}
					userId = obj3.getString("userId");
				}
				totalPrice = totalPrice - (uprice*quantity);
				
				BasicDBObject remove = new BasicDBObject("orderId",orderId).append("productName",productName);
				mycl2.remove(remove);
				
				BasicDBObject update = new BasicDBObject("orderId",orderId).append("productName", null);
				BasicDBObject updatevalue = new BasicDBObject("$set",new BasicDBObject("totalPrice",totalPrice));
				mycl2.update(update, updatevalue);
				
				out.println("<p class='invalid'>"+productName+" has been removed from Order ID:"+orderId+"</p>");
	
				DBCursor cursor9 = mycl2.find(new BasicDBObject("orderId",orderId));
				String p1 = " ";
				while(cursor9.hasNext()){
					BasicDBObject obj9 = (BasicDBObject) cursor9.next();
					if(obj9.getString("productName") != null) {
					p1 = "remove";
					}
				}
				if(!p1.equals("remove")){
				BasicDBObject remove1 = new BasicDBObject("orderId",orderId);
						mycl2.remove(remove1);
				}
			}
			
		} else if(set.equals("updateQuantity")){
			
			String productName = request.getParameter("productName2");
			int uquantity = Integer.parseInt(request.getParameter("productQuantity1"));
			BasicDBObject query3 = new BasicDBObject("orderId",orderId).append("productName",productName);
			DBCursor cursor6 = mycl2.find(query3);
			if(cursor6.count() == 0){
				out.println("<p class='invalid'>"+productName+" does not exist in the Order ID: "+orderId+"</p>");
			} else{
				while(cursor6.hasNext()){
					BasicDBObject obj6 = (BasicDBObject) cursor6.next();
					uprice = obj6.getInt("productPrice");
					quantity = obj6.getInt("quantity");
				}
				while(cursor3.hasNext()){
					BasicDBObject obj3 = (BasicDBObject) cursor3.next();
					if(obj3.getString("productName") == null) {
						totalPrice = obj3.getInt("totalPrice");
						}
					userId = obj3.getString("userId");
				}
				totalPrice = totalPrice - (uprice*quantity) + (uprice*uquantity);
				
				BasicDBObject update = new BasicDBObject("orderId",orderId).append("productName",productName);
				BasicDBObject updatevalue = new BasicDBObject("$set",new BasicDBObject("quantity",uquantity));
				mycl2.update(update, updatevalue);
				
				BasicDBObject update1 = new BasicDBObject("orderId",orderId).append("productName", null);
				BasicDBObject updatevalue1 = new BasicDBObject("$set",new BasicDBObject("totalPrice",totalPrice));
				mycl2.update(update1, updatevalue1);
				
				out.println("<p class='invalid'>Quantity of "+productName+" has been updated in Order ID:"+orderId+"</p>");
			}
			
		} else if(set.equals("updatePrice")){
			
			String productName = request.getParameter("productName3");
			int uuprice = Integer.parseInt(request.getParameter("productPrice"));
			BasicDBObject query3 = new BasicDBObject("orderId",orderId).append("productName",productName);
			DBCursor cursor6 = mycl2.find(query3);
			if(cursor6.count() == 0){
				out.println("<p class='invalid'>"+productName+" does not exist in the Order ID: "+orderId+"</p>");
			} else{
				while(cursor6.hasNext()){
					BasicDBObject obj6 = (BasicDBObject) cursor6.next();
					uprice = obj6.getInt("productPrice");
					quantity = obj6.getInt("quantity");
				}
				while(cursor3.hasNext()){
					BasicDBObject obj3 = (BasicDBObject) cursor3.next();
					if(obj3.getString("productName") == null) {
						totalPrice = obj3.getInt("totalPrice");
						}
					userId = obj3.getString("userId");
				}
				totalPrice = totalPrice - (uprice*quantity) + (uuprice*quantity);
				
				BasicDBObject update = new BasicDBObject("orderId",orderId).append("productName",productName);
				BasicDBObject updatevalue = new BasicDBObject("$set",new BasicDBObject("productPrice",uuprice));
				mycl2.update(update, updatevalue);
				
				BasicDBObject update1 = new BasicDBObject("orderId",orderId).append("productName", null);
				BasicDBObject updatevalue1 = new BasicDBObject("$set",new BasicDBObject("totalPrice",totalPrice));
				mycl2.update(update1, updatevalue1);
				
				out.println("<p class='invalid'>Price of "+productName+" has been updated in Order ID:"+orderId+"</p>");
			}
			
		}

		} else{
			out.println("<p class='invalid'>There are no Orders with Order ID:"+orderId+"</p>");
		}
		
	} else if(request.getParameter("deleteOrder") != null){
		String orderId = request.getParameter("orderId1");
		DBCursor cursor7 = mycl2.find(new BasicDBObject("orderId",orderId));
		if(cursor7.count() != 0){
			BasicDBObject remove = new BasicDBObject("orderId",orderId);
			mycl2.remove(remove);
			
			out.println("<p class='invalid'>Order ID:"+orderId+" has been deleted</p>");
		} else{
				out.println("<p class='invalid'>There are no Orders with this Order ID</p>");
			}
	}
	
	
	DBCursor cursor = mycl.find();
	String prdcts = " ";
	String prdct = " ";
	while (cursor.hasNext()) {
		BasicDBObject obj = (BasicDBObject) cursor.next();
		prdct = obj.getString("productName");
		prdcts = prdcts + "<option value='"+prdct+"'>"+prdct+"</option>";
	}	
	%>
	
	<section id='rc'>
	<section id='rct'>
    <article>
	<h2><b>Sales Man</b></h2>	

	<form action="salesMan.jsp">
	<table class='query-table mo'>
	<tr><td colspan='2' class='tle'><b>Add Customer Order</b></td></tr>
	<tr><td>Product Name: </td><td><select name='productName'><%=prdcts%></select></td></tr>
	<tr><td>Product Quantity: </td><td><input type="number" name="productQuantity" required/></td></tr>
	<tr><td>Email ID: </td><td><input type="email" name="emailId" required/></td></tr>
	<tr><td>Full Name: </td><td><input type="text" name="fullName" required /></td></tr>
	<tr><td>Address: </td><td><input type="text" name="address" required/></td></tr>
	<tr><td>Phone: </td><td><input type="number" name="phone" required/></td></tr>
	<tr><td>Card Number: </td><td><input type="number" name="cardno" required/></td></tr>
	<tr><td class='nb'></td><td class='nb'><input class='formbtn' type="submit" name="addOrder" value="ADD ORDER"/></td></tr>
	</table></form>
	
	<form action="salesMan.jsp">
	<table class='query-table'>
	<tr><td colspan='5' class='tle'><b>Update Customer Order</b></td></tr>
	<tr><td>Order ID: </td><td colspan='4'><input type="number" name="orderId" required /></td></tr>
	<tr><td><input type='radio' name='uset' value='addProduct' checked /> Add Product</td><td>Product Name: </td><td><select name='productName'><%=prdcts%></select></td><td>Product Quantity: </td><td><input type="number" name="productQuantity" min='1' value='1' /></td></tr>
	<tr><td><input type='radio' name='uset' value='removeProduct' /> Remove Product</td><td>Product Name: </td><td colspan='3'><select name='productName1'><%=prdcts%></select></td></tr>
	<tr><td><input type='radio' name='uset' value='updateQuantity' /> Update Product Quantity</td><td>Product Name: </td><td><select name='productName2'><%=prdcts%></select></td><td>Product Quantity: </td><td><input type="number" name="productQuantity1" min='1' value='1' /></td></tr>
<tr><td><input type='radio' name='uset' value='updatePrice' /> Update Product Price</td><td>Product Name: </td><td><select name='productName3'><%=prdcts%></select></td><td>Product Price: </td><td><input type="number" name="productPrice" min='0' value='0' /></td></tr>	
<tr><td colspan='2' class='nb'></td><td class='nb'><input class='formbtn' type="submit" name="updateOrder" value="UPDATE ORDER"/></td></tr>
	</table></form>
	
	<form action="salesMan.jsp">
	<table class='query-table'>
	<tr><td colspan='2' class='tle'><b>Delete Customer Order</b></td></tr>
	<tr><td>Order ID: </td><td><input type="number" name="orderId1" required /></td></tr>
	<tr><td class='nb'></td><td class='nb'><input class='formbtn' type="submit" name="deleteOrder" value="DELETE ORDER"/></td></tr>
	</table></form>
		
	<a href='allOrders.jsp' class='ml'><input class='formbtn3' type="submit" name="viewAllOrders" value="VIEW ALL CUSTOMER ORDERS"/></a>
	<%
}


	if(!accounts && !orders) {
%>
	<section id='rc'>
	<section id='rct'>
    	<article>
	<h2><b>Sales Man</b></h2>
	
<%
	}
%>

	<form action="salesMan.jsp">
	<table class='query-table mo'>
	<tr><td class='nb'><input class='formbtn' type='submit' name='orders' value='CUSTOMER ORDERS' /></td>
	<td class='nb'><input class='formbtn' type='submit' name='accounts' value='CUSTOMER ACCOUNTS' /></td></tr>
	</table></form>
		
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