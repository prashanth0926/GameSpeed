
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class format extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	static String heading;
	static String select = " ";
	static String select1 = " ";

	public static void constructPageTop(PrintWriter output){
		
		String myPageTop = "<!DOCTYPE html>" + "<html lang=\"en\">"
					+ "<head>	<meta http-equiv=\"Content-Type\" content=\"text/html\"; charset=\"utf-8\" />"
					+ "<title>GameSpeed</title>"
					+ "<link rel=\"stylesheet\" href=\"styles.css\" type=\"text/css\" />"
					+ "</head>"
					+ "<body>"
					+ "<div id=\"container\">"
					+ "<header>"
					+ "<h1><a href=\"#\">Game<span>Speed</span></a></h1><h2>connecting gamers</h2>"
					+ "</header>"
					+ "<nav>"
					+ "<ul>"
					+ "<li class=\"\"><a href=\"home.html\">Home</a></li>"
					+ "<li><a href=\"#\" class='"+select1+"'>Products</a>"
					+ "<ul class=\"dd1\">"
        			+ "<li><a href=\"#\">Consoles</a>"
					+ "<ul class=\"dd2\">"
					+ "<li><a href=\"microsoft.html\">Microsoft</a></li>"
					+ "<li><a href=\"sony.html\">Sony</a></li>"
					+ "<li><a href=\"nintendo.html\">Nintendo</a></li>"
					+ "</ul></li>"
					+ "<li><a href=\"#\">Games</a>"
					+ "<ul class=\"dd2\">"
					+ "<li><a href=\"ea.html\">Electronic arts</a></li>"
					+ "<li><a href=\"activision.html\">Activision</a></li>"
					+ "<li><a href=\"ttint.html\">Take-two Interactive</a></li>"
					+ "</ul></li>"
        			+ "<li><a href=\"accessories.html\">Accessories</a></li>"
					+ "</ul></li>"
					+ "<li><a class=\"\" href=\"analytics.html\">Data Analytics</a></li>"
					+ "<li class=\"right\"><a class=\"\" href=\"logout\"><img src=\"images/logout.png\" width=\"50px\" height=\"50px\" ait=\"logout\" /></a></li>"
					+ "<li class=\"right\"><a class=\"\" href=\"addtocart\"><img src=\"images/cart.png\" width=\"75px\" height=\"50px\" ait=\"cart\" /></a></li>"
					+ "<li class=\"right\"><a class=\"myorders "+select+"\" href=\"myorders\">My Orders</a></li>"
					+ "<li class=\"search\">"
					+ "<form method=\"get\" class=\"searchform\" action=\"#\" >"
					+ "<table><tr>"
      				+ "<td><p><input class=\"s\" type=\"text\" size=\"25\" value=\"\" name=\"s\" /></p></td>"
					+ "<td><input class=\"img\" type=\"image\" src=\"images/search.png\" height=\"20px\" width=\"20px\" alt=\"search\" /></td>"
       				+ "</tr></table>"
      				+ "</form>"
					+ "</li>"
      				+ "</ul>"
					+ "</nav>"
    				+ "<div id=\"body\">"
					+ "<section id='rc'>"
					+ "<section id='rct'>"
					+ "<article>"
  					+ "<h2 class='tp'>" +heading+ "</h2>";


		
		output.println(myPageTop);		
	
	}
	
	public static void constructPageBottom(PrintWriter output){
		String myPageBottom = "</article></section></section><aside class=\"sidebar\">"
								+ "<ul><li><h4>Consoles</h4><ul><li><a href=\"microsoft.html\">XBOX One</a></li>"
								+ "<li><a href=\"microsoft.html\">XBOX 360</a></li>"
								+ "<li><a href=\"sony.html\">PS 3</a></li>"
								+ "<li><a href=\"sony.html\">PS 4</a></li>"
								+ "<li><a href=\"nintendo.html\">Wii</a></li>"
								+ "<li><a href=\"nintendo.html\">Wii U</a></li></ul>"
								+ "</li><li><h4>Games</h4>"
								+ "<ul><li><a href=\"ea.html\">FIFA 16</a></li>"
								+ "<li><a href=\"activision.html\">Call of Duty-Advanced Warfare</a></li>"
								+ "<li><a href=\"ttint.html\">Grand Theft Auto V</a></li>"
								+ "</ul></li><li><h4>Accessories</h4>"
								+ "<ul><li><a href=\"accessories.html\">Headset</a></li>"
								+ "</ul></li>"
								+ "<li><h4>Trending and Data Analytics</h4><ul><li><a href='analytics.html'>Data Analytics</a></li></ul></li>"
								+ "</ul></aside><div class=\"clear\"></div>"
								+ "</div><footer>"
								+ "<div class=\"footer-content\">"
								+ "<h5><a href=\"#\">Reviews</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"#\">Returns</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"#\">Support</a></h5>"
								+ "<div class=\"clear\"></div>"
								+ "</div>"
								+ "<div class=\"footer-bottom\">"
								+ "<p>&copy GAMESPEED 2015 ALL RIGHTS RESERVED</p>"
								+ "</div></footer></div></body></html>";

		
		output.println(myPageBottom);
	}
}