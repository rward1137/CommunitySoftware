package community.servlets;

import java.util.ArrayList;
import java.util.List;
import community.objects.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private List<User> users; // how is this getting populated?

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		users = new ArrayList<User>();
		users.add(new User("elephant", "handyman", "jon", "smythe", "jsmythe@gmail.com", new UserAddress(),
				"A", "Community One"));
		
		String username = request.getParameter("username"); 
		String password = request.getParameter("password");
		
		boolean validUser = false;
		
		for (User u : users) {
			if (u.getUsername().equals(username)){
				if (u.getPassword().equals(password)) {
					validUser = true;
				}
			}
		}
		
		if (validUser) {
			Cookie loginCookie = new Cookie("user", username);
			//setting cookie to expire in 30 minutes
			loginCookie.setMaxAge(30*60);
			response.addCookie(loginCookie);
			response.sendRedirect("index.jsp");
		}
		else {
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.html");
			PrintWriter out= response.getWriter();
			out.println("<font color=red>login credentials are wrong</font>");
			rd.include(request, response);
		}
	}
	
}
