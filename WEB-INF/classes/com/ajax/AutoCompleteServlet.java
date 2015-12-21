package com.ajax;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Iterator;

public class AutoCompleteServlet extends HttpServlet {

    private ServletContext context;
    private ComposerData compData = new ComposerData();
    private HashMap composers = compData.getComposers();

    @Override
    public void init(ServletConfig config) throws ServletException {
        this.context = config.getServletContext();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

	try{

        String action = request.getParameter("action");
        String targetId = request.getParameter("id");
        StringBuffer sb = new StringBuffer();
        
        HttpSession session=request.getSession(true);

        if (targetId != null) {
            targetId = targetId.trim().toLowerCase();
        } else {
            session.setAttribute("search", "SEARCH");
            context.getRequestDispatcher("/home.jsp").forward(request, response);
        }

	boolean namesAdded = false;
        if (action.equals("complete")) {

            if (!targetId.equals("")) {

                Iterator it = composers.keySet().iterator();

                while (it.hasNext()) {
                    String id = (String) it.next();
                    Composer composer = (Composer) composers.get(id);

                   if ( composer.getProductName().toLowerCase().contains(targetId)) {

                        sb.append("<composer>");
                        sb.append("<id>" + composer.getId() + "</id>");
                        sb.append("<productName>" + composer.getProductName() + "</productName>");
                        sb.append("</composer>");
                        namesAdded = true;
		
                    }
                }
            }

            if (namesAdded) {
                response.setContentType("text/xml");
                response.setHeader("Cache-Control", "no-cache");
                response.getWriter().write("<composers>" + sb.toString() + "</composers>");
            } else {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            }
        }

        if (action.equals("lookup")) {

            if ((targetId != null) && composers.containsKey(targetId.trim())) {
                request.setAttribute("composer", composers.get(targetId));
                
	        Composer composer1 = (Composer) composers.get(targetId);
		String url = (composer1.getUrl());
                context.getRequestDispatcher(url).forward(request, response);
		/*switch (pName){
		case "XBOX One": context.getRequestDispatcher("/microsoft.html").forward(request, response);
			break;
		case "XBOX 360": context.getRequestDispatcher("/microsoft.html").forward(request, response);
			break;
		case "PS 3": context.getRequestDispatcher("/sony.html").forward(request, response);
			break;
		case "PS 4": context.getRequestDispatcher("/sony.html").forward(request, response);
			break;
		case "Wii": context.getRequestDispatcher("/nintendo.html").forward(request, response);
			break;
		case "Wii U": context.getRequestDispatcher("/nintendo.html").forward(request, response);
			break;
		case "FIFA 16": context.getRequestDispatcher("/ea.html").forward(request, response);
			break;
		case "COD AW": context.getRequestDispatcher("/activision.html").forward(request, response);
			break;
		case "GTA V": context.getRequestDispatcher("/ttint.html").forward(request, response);
			break;
		case "SK": context.getRequestDispatcher("/accessories.html").forward(request, response);
			break;
		case "Sony": context.getRequestDispatcher("/sony.html").forward(request, response);
			break;
		case "Microsoft": context.getRequestDispatcher("/microsoft.html").forward(request, response);
			break;
		case "Nintendo": context.getRequestDispatcher("/nintendo.html").forward(request, response);
			break;
		case "EA": context.getRequestDispatcher("/ea.html").forward(request, response);
			break;
		case "Activision": context.getRequestDispatcher("/activision.html").forward(request, response);
			break;
		case "Take-Two Interactive": context.getRequestDispatcher("/ttint.html").forward(request, response);
			break;
		case "SkullCandy": context.getRequestDispatcher("/accessories.html").forward(request, response);
			break;
		case "Accessories": context.getRequestDispatcher("/accessories.html").forward(request, response);
			break;
		case "Play Station": context.getRequestDispatcher("/sony.html").forward(request, response);
			break;
		default: context.getRequestDispatcher("/home.html").forward(request, response);
			break;

            }*/
	

            }
        }

	}catch(Exception e){
	System.out.println("Exception: "+e);
	}
    }
}
