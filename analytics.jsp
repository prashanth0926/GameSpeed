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
        <li><a href="#">Products</a>
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
	<li><a class="selected" href="analytics.jsp">Data Analytics</a></li>
	<li class="right"><a class="" href="logout.jsp"><img src="images/logout.png" width="50px" height="50px" ait="logout" /></a></li>
	<li class="right"><a class="" href="addToCart.jsp"><img src="images/cart.png" width="75px" height="50px" ait="cart" /></a></li>
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

	<section id="review-content">

                <article>
                
                <%
                mconnect mydb = mconnect.createInstance();
                DBCollection mycl = mydb.getCollection("products");	
                DBCursor cursor = mycl.find();
                String Product = " ";
                String prdctdd = " ";
                   
                while (cursor.hasNext()) {
		BasicDBObject obj = (BasicDBObject) cursor.next();
		Product = obj.getString("productName");
        prdctdd = prdctdd + "<option value='"+Product+"'>"+Product+"</option>";
                   }
                %>

                    <h3> Trending and Data Analytics </h3>

			<form method="get" class="searchform" action="find">

                           <table class = "query-table">
							<tr>
								<td colspan = "3" class="tle"> <b> Simple Search </b> </td>
							</tr>
                            
							<tr>
						
								<td> <input type="checkbox" name="queryCheckBox" value="productName" checked> Product Name: </td>
                                <td>
                                    <select name="productName">
					<option value="ALL_PRODUCTS">All Products</option>
                    <%=prdctdd %>
					</select>
                                </td>
								<td> </td>
                            </tr>

				<tr>
								<td> <input type="checkbox" name="queryCheckBox" value="productCategory"> Product Category: </td>
                                <td>
					<select name="productCategory">
	<option value="Console">Gaming Console</option>
	<option value="Game">Game</option>
	<option value="Accessory">Accessory</option>
	</select>
                </td>
								<td> </td>
                            </tr>

                            <tr>
				<td> <input type="checkbox" name="queryCheckBox" value="productPrice"> Product Price: </td>
                                <td>
                                    <input type="number" name="productPrice" value = "0" size=5 /> </td>
								<td>
									<select name="comparePrice">
									<option value="EQUALS_TO" selected>Equals</option>
                                        				<option value="GREATER_THAN"> Greater than</option>
                                       					<option value="LESS_THAN"> Less than</option>
                                        				</select>

								</td>
                            </tr>

			<tr>
				<td> <input type="checkbox" name="queryCheckBox" value="retailerName"> Retailer Name: </td>
                                <td>
                                   <select name="retailerName">
	<option value="GameSpeed">Game Speed</option>
	<option value="BestBuy">Best Buy</option>
	<option value="Walmart">Walmart</option>
	</select>
				</td>
								<td> </td>
                            </tr>

                            <tr>
								<td> <input type="checkbox" name="queryCheckBox" value="retailerZip"> Retailer Zip code: </td>
                                <td>
                                    <input type="number" name="retailerZip" value="0" size=10/> </td>
								<td> </td>
                            </tr>

                            <tr>
								<td> <input type="checkbox" name="queryCheckBox" value="retailerCity"> Retailer City: </td>
                                <td>
                                    <input type="text" name="retailerCity" value = "ALL" /> </td>
								<td> </td>
                            </tr>

			<tr>
								<td> <input type="checkbox" name="queryCheckBox" value="retailerState"> Retailer State: </td>
                                <td>
                                    <input type="text" name="retailerState" value = "ALL" /> </td>
								<td> </td>
                            </tr>

			<tr>
								<td> <input type="checkbox" name="queryCheckBox" value="sale"> Product On Sale: </td>
                                <td>
                                    <input type="radio" name="sale" value="Yes" selected />Yes &nbsp <input type="radio" name="sale" value="No" selected />No</td>
								<td> </td>
                            </tr>

				<tr>
				<td> <input type="checkbox" name="queryCheckBox" value="manufacturerName"> Manufacturer Name: </td>
                                <td>
                                   <select name="manufacturerName">
	<option value="Microsoft">Microsoft</option>
	<option value="Sony">Sony</option>
	<option value="Nintendo">Nintendo</option>
	</select>
				</td>
								<td> </td>
                            </tr>

			<tr>
								<td> <input type="checkbox" name="queryCheckBox" value="rebate"> Manufacturer Rebate: </td>
                                <td>
                                    <input type = "radio" name = "rebate" value = "Yes"/> Yes &nbsp <input type = "radio" name = "rebate" value = "No"/> No </td>
								<td> </td>
                            </tr>

			<tr>
								<td> <input type="checkbox" name="queryCheckBox" value="emailID"> Email ID: </td>
                                <td>
                                    <input type = "text" name = "emailID" value="ALL" /> </td>
								<td> </td>
                            </tr>

			<tr>
				<td> <input type="checkbox" name="queryCheckBox" value="userAge"> Age: </td>
                                <td>
                                    <input type="number" name="userAge" value = "1" /> </td>
								<td>
									<select name="compareAge">
									<option value="EQUALS_TO">Equals</option>
                                        				<option value="GREATER_THAN" selected> Greater than</option>
                                       					<option value="LESS_THAN"> Less than</option>
                                        				</select>

								</td>
                            </tr>

			<tr>
								<td> <input type="checkbox" name="queryCheckBox" value="userGender"> Gender: </td>
                                <td>
                                    <input type = "radio" name = "userGender" value = "Male"/> Male &nbsp <input type = "radio" name = "userGender" value = "Female"/> Female </td>
								<td> </td>
                            </tr>

			<tr>
								<td> <input type="checkbox" name="queryCheckBox" value="userOccupation"> Occupation: </td>
                                <td>
                                    <input type = "text" name = "userOccupation" value="ALL" /> </td>
								<td> </td>
                            </tr>

                            <tr>
								<td> <input type="checkbox" name="queryCheckBox" value="reviewRating"> Review Rating: </td>
                                <td>
                                    <select name="reviewRating">
                                        <option value="1" selected>1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                </td>
								<td>
									<select name="compareRating">
                                    					<option value="EQUALS_TO" checked> Equals </option>
                                        				<option value="GREATER_THAN"> Greater Than </option>
									<option value="LESS_THAN"> Less than</option>
									</select>
								</td>
                            </tr>

			<tr>
				<td> <input type="checkbox" name="queryCheckBox" value="reviewDate"> Review Date: </td>
                                <td>
                                    <input type="date" name="reviewDate" /> </td>
								<td>
									<select name="compareDate">
									<option value="EQUALS_TO">Equals</option>
                                        				<option value="GREATER_THAN" selected> Greater than</option>
                                       					<option value="LESS_THAN"> Less than</option>
                                        				</select>

								</td>
                            </tr>
	
			<tr>
								<td> <input type="checkbox" name="queryCheckBox" value="reviewText"> Review Text: </td>
                                <td>
                                    <input type="text" name="reviewText" value = "ALL" /> </td>
								<td> </td>
                            </tr>

							<tr>
								<td>
									Return:
								</td>
								<td colspan = "3"> 
									<select name="returnValue">
										<option value="ALL" selected>ALL</option>
                                        <option value="TOP_5">Top 5 </option>
                                        <option value="TOP_10">Top 10 </option>
										<option value="LATEST_5">Latest 5 </option>
										<option value="LATEST_10">Latest 10 </option>
									</select>
                                </td>
							</tr>						
							<tr>
								<td colspan = "3" class="tle"> <b> Grouping </b> </td>
							</tr>
							<tr>
								<td>
                                <input type="checkbox" name="extraSettings" value="GROUP_BY"> Group By
								</td>
								<td>
								<select name="groupByDropdown">
                                        <option value="GROUP_BY_CITY" selected>City</option>
                                        <option value="GROUP_BY_PRODUCT">Product Name</option>
					<option value="GROUP_BY_CATEGORY">Product Category</option>
                                        <option value="GROUP_BY_PRICE">Product Price</option>
					<option value="GROUP_BY_RETAILER">Retailer Name</option>
                                        <option value="GROUP_BY_STATE">State</option>
					<option value="GROUP_BY_ZIP">Zip Code</option>
				        <option value="GROUP_BY_SALE">Product On Sale</option>
					<option value="GROUP_BY_MANUFACTURER">Manufacturer Name</option>
					<option value="GROUP_BY_REBATE">Manufacturer Rebate</option>
					<option value="GROUP_BY_EMAILID">Email ID</option>
				        <option value="GROUP_BY_AGE">Age</option>
					<option value="GROUP_BY_GENDER">Gender</option>
					<option value="GROUP_BY_OCCUPATION">Occupation</option>
				        <option value="GROUP_BY_RATING">Rating</option>
					<option value="GROUP_BY_DATE">Date</option>
					</select>
                                </td>
				<td>
                                <input type="checkbox" name="extraSettings" value="COUNT_ONLY" /> Count Only
								</td>
                            </tr>
	
			<tr>
								<td>
                                <input type="checkbox" name="extraSettings" value="REVIEW_RATING"> Review Rating
								</td>
				 <td>
                                    <select name="reviewRating1">
                                        <option value="1" selected>1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5" selected>5</option>
                                </td>
								<td>
									<select name="compareRating1">
                                    					<option value="EQUALS_TO" checked> Equals </option>
                                        				<option value="GREATER_THAN"> Greater Than </option>
									<option value="LESS_THAN"> Less than</option>
									</select>
								</td>
                            </tr>

			<tr>
								<td colspan = "3">
                                <input type="checkbox" name="extraSettings" value="MAX_PRICE" /> Maximum Product Price
								</td>
			</tr>

			<tr>
								<td colspan = "3">
                                <input type="checkbox" name="extraSettings" value="TOP5_LIKED" /> Top Five Liked Products
								</td>
			</tr>

			                 <tr>
                                <td class="nb"> <input type="submit" name="find" value="Find Data" class="formbtn" /> </td>
	
				<td class="nb">				
                                <input type="submit" name="trending" value="TRENDING" class="formbtn" />
								</td>
                                
                             </tr>

			<tr>
								<td colspan = "3" class="tle"> <b> Advanced Search </b> </td>
							</tr>
							<tr>
								<td>
                                <input type="checkbox" name="extraSettings1" value="ADVANCED" /> Advanced Grouping
								</td>
								<td>
						<select name="groupByDropdown1">
                                        <option value="MEDIAN" selected>Median of Product Price per city</option>
                                        <option value="TOP5_EXPENSIVE">Top 5 most Expensive Products per city</option>
					<option value="TOP5_DISLIKED">Top 5 most disliked Products per city</option>
                                        <option value="RATING5_ZIP">Products with Rating 5 per ZipCode</option>
					<option value="AGE_CITY">Age greater than 50 per city</option>
                                        <option value="TOP5_LIKE">Top 5 most liked Products per city</option>
					</select>
								</td>
			</tr>

			<tr><td> <input type="checkbox" name="extraSettings1" value="TEXT"> Review Text: </td>
                                <td>
                                    <input type="text" name="reviewText" value = "ALL" /> </td></tr>
				
			<tr>
				<td class="nb">				
                                <input type="submit" name="advancedsearch" value="ADVANCED SEARCH" class="formbtn" />
								</td>
			</tr>

		</table></form>                    

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
			<li><a href="sony.html">PS 4</a></li>
                    	<li><a href="nintendo.jsp">Wii</a></li>
			<li><a href="nintendo.jsp">Wii U</a></li>
                    </ul>
                </li>
                
                <li>
                    <h4>Games</h4>
                    <ul>
                        <li><a href="ea.html">FIFA 16</a></li>
                        <li><a href="activision.html">Call of Duty-Advanced Warfare</a></li>
			<li><a href="ttint.html">Grand Theft Auto V</a></li>
                    </ul>
                </li>
                                
                <li>
                    <h4>Accessories</h4>
                    <ul>
                        <li><a href="accessories.jsp">Headset</a></li>
                    </ul>
                </li>   
		<li>
                    <h4>Trending and Data Analytics</h4>
                    <ul>
                        <li><a href="analytics.jsp">Data Analytics</a></li>
                    </ul>
                </li>             
         
            </ul>
		
    </aside>


    
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

    <script type="text/javascript" src="javascript.js"></script>
    
</body>

</html>