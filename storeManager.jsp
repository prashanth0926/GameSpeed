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
    <nav><ul><li class="right"><a class="" href="logout.jsp"><img src="images/logout.png" width="50px" 

height="50px" ait="logout" /></a></li></ul></nav>
	<div id="body">
	
<%
mconnect mydb = mconnect.createInstance();
DBCollection mycl = mydb.getCollection("products");

String productName = request.getParameter("productName");

if (request.getParameter("add") != null) {
	
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	String imageName = request.getParameter("imageName");

	String imageLocation = "images/"+imageName;
	
	BasicDBObject query = new BasicDBObject("productName",productName);
	DBObject doc1 = mycl.findOne(query);
	
	if (doc1 == null) {	
	BasicDBObject doc = new BasicDBObject("productName",productName).
						append("productPrice",productPrice).
						append("imageLocation",imageLocation).
						append("newUpload","Yes");
						
	mycl.insert(doc);
   com.ajax.ComposerData.CD(productName, "NewProduct", "/newProducts.jsp");
%>
	<p class='invalid'>Product added successfully</p>
<%
	} else {
%>
		<p class='invalid'>Product already exists</p>
	<%}
} else if (request.getParameter("update") != null) {
	String set = request.getParameter("uset");
	if(set.equals("productName")) {
		String productName1 = request.getParameter("productName1");
		
		BasicDBObject update = new BasicDBObject("productName",productName);
		BasicDBObject updatevalue = new BasicDBObject("$set",new BasicDBObject("productName",productName1));
		mycl.update(update, updatevalue);
		%>
		<p class='invalid'>Product name updated successfully</p>
	<%
	} else if(set.equals("productPrice")) {
		int productPrice = Integer.parseInt(request.getParameter("productPrice"));
		
		BasicDBObject update = new BasicDBObject("productName",productName);
		BasicDBObject updatevalue = new BasicDBObject("$set",new BasicDBObject("productPrice",productPrice));
		mycl.update(update, updatevalue);
		%>
		<p class='invalid'>Product price updated successfully</p>
	<%
	} else if(set.equals("imageLocation")) {
		String imageName = request.getParameter("imageName");
		String imageLocation = "images/"+imageName;
		BasicDBObject update = new BasicDBObject("productName",productName);
		BasicDBObject updatevalue = new BasicDBObject("$set",new BasicDBObject("imageLocation",imageLocation));
		mycl.update(update, updatevalue);
		%>
		<p class='invalid'>Product image updated successfully</p>
	<%
	} 
} else if (request.getParameter("remove") != null) {
	BasicDBObject remove = new BasicDBObject("productName",productName);
	mycl.remove(remove);
	%>
	<p class='invalid'>Product removed</p>
<%
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
	<section id="rc">
	<section id="rct">
	<article>
	<h2><b>Store Manager</b></h2>

	<form action="storeManager.jsp">
	<table class='query-table'>
	<tr><td colspan='2' class='tle'><b>Add Product</b></td></tr>
	<tr><td>Product Name: </td><td><input type="text" name="productName" required /></td></tr>
	<tr><td>Product Price: </td><td><input type="number" name="productPrice" required/></td></tr>
	<tr><td>Image: </td><td><input type="file" name="imageName" action='image/*' /></td></tr>
	<tr><td class='nb'></td><td class='nb'><input class='formbtn' type="submit" name="add" value="ADD PRODUCT"/></td></tr>
	</table></form>
	
	<form action="storeManager.jsp">
	<table class='query-table'>
	<tr><td colspan='2' class='tle'><b>Update Product</b></td></tr>
	<tr><td>Product Name: </td><td><select name='productName'><%=prdcts%></select></td></tr>
	<tr><td><input type='radio' name='uset' value='productName' /> Product Name: </td><td><input type="text" name="productName1" /></td></tr>
	<tr><td><input type='radio' name='uset' value='productPrice' checked /> Product Price: </td><td><input type="number" name="productPrice" value='0' min='0' /></td></tr>
	<tr><td><input type='radio' name='uset' value='imageLocation' /> Image: </td><td><input type="file" name="imageName" action='image/*' /></td></tr>
	<tr><td class='nb'></td><td class='nb'><input class='formbtn' type="submit" name="update" value="UPDATE PRODUCT"/></td></tr>
	</table></form>
	
	<form action="storeManager.jsp">
	<table class='query-table'>
	<tr><td colspan='2' class='tle'><b>Remove Product</b></td></tr>
	<tr><td>Product Name: </td><td><select name='productName'><%=prdcts%></select></td></tr>
	<tr><td class='nb'></td><td class='nb'><input class='formbtn' type="submit" name="remove" value="REMOVE PRODUCT"/></td></tr>
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