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
	<li class="right"><a class="" href="logout.jsp"><img src="images/logout.png" width="50px" height="50px" ait="logout" /></a></li>
	<li class="right"><a class="" href="addToCart.jsp"><img src="images/cart.png" width="75px" height="50px" ait="cart" /></a></li>
	<li class="right"><a class="myorders" href="myOrders.jsp">My Orders</a></li>
	<li class="search">
                        	<form name="autofillform" action="autocomplete" autocomplete="off" class="searchform" >
				<table><tr>
                                <td><p><input class="s" id="complete-field" onkeyup="doCompletion()" type="text" size="15" name="s" placeholder="search product" /></p></td>
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

	<section id="content">


	<img class="header-image" src="images/microsoft.png" width = "100%" height = "-25" alt="Index Page Image" />
	    
	<table>
			<tr>
				<th>
					<img src = "images/xbox_one.jpg" width = "200px" height = "200px" alt = "XBOX One">
				</th>
				<td>
					<p> XBOX One </p>
					<p> Price: $300 </p>
				</td>
				<td>
					<form class = "submit-button" method = "get" action = "addToCart.jsp">
						<input type = "hidden" name = "productName" value = "XBOX One">
						<input class = "submit-button" type = "submit" name = "XBOX One" value = "Add to Cart">
					</form>
					<form class = "submit-button" method = "get" action = "submitReview.jsp">
						<input type = "hidden" name = "productName" value = "XBOX One">
						<input class = "submit-button" type = "submit" name = "XBOX One" value = "Write Review">
					</form>
					<form class = "submit-button" method = "get" action = "viewReviews.jsp">
						<input type = "hidden" name = "productName" value = "XBOX One">
						<input class = "submit-button" type = "submit" name = "XBOX_One" value = "View Reviews">
					</form>
				</td>
			</tr>
			
			<tr>
				<th>
					<img src = "images/xbox_360.jpg" width = "200" height = "200" alt = "XBOX 360">
				</th>
				<td>
					<p> XBOX 360 </p>
					<p> Price: $500 </p>
				</td>
				<td>
					<form class = "submit-button" method = "get" action = "addToCart.jsp">
						<input type = "hidden" name = "productName" value = "XBOX 360">
						<input class = "submit-button" type = "submit" name = "XBOX 360" value = "Add to Cart">
					</form>
					<form class = "submit-button" method = "get" action = "submitReview.jsp">
						<input type = "hidden" name = "productName" value = "XBOX 360">
						<input class = "submit-button" type = "submit" name = "XBOX 360" value = "Write Review">
					</form>
					<form class = "submit-button" method = "get" action = "viewReviews.jsp">
						<input type = "hidden" name = "productName" value = "XBOX 360">
						<input class = "submit-button" type = "submit" name = "XBOX_360" value = "View Reviews">
					</form>
				</td>
			</tr>	
		
			</table>
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
        <h5><a href="#">Reviews</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#">Returns</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#">Support</a></h5>
        <div class="clear"></div>
        </div>
		
        <div class="footer-bottom">
            <p>&copy GAMESPEED 2015 ALL RIGHTS RESERVED</p>
        </div>
		
    </footer>
</div>

</body>
    
    <script type="text/javascript" src="javascript.js"></script>

</html>