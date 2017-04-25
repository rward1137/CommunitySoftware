package community.servlets;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.IOException;
import java.io.PrintWriter;

import org.jasypt.util.password.BasicPasswordEncryptor;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	
	// Database objects
	private Connection connect;
	private Statement stmt;
	private ResultSet result;
	
	// User info
	private String username, password, datapwd;
	private boolean validUser;
	
	// 3rd party encryption
	private BasicPasswordEncryptor passencrypt;
	
	/**
	 * HttpServlet#doPost
	 * Attempts to validate a username/password combination
	 * Redirects to homepage if valid
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		// Flag for later redirect
		validUser = false;
		
		// Get info
		username = request.getParameter("username"); 
		password = request.getParameter("password");
		passencrypt = new BasicPasswordEncryptor();

		try { 	// Database connection
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			connect = DriverManager.getConnection("jdbc:sqlserver://waketechcommunitywatchsqlvm000001.database.windows.net;databaseName=WAKETECHCOMMUNITYWATCHDB000001;user=communitywatchadmin;password=WakeTech2018;");
			stmt = connect.createStatement();
			
			// Check password from database
			result = stmt.executeQuery("select Password from Users where UserName = \'" + username + "\'");
			while (result.next()) {
				datapwd = result.getString("Password");
				// BasicPasswordEncryptor checks it against plaintext password
				if (passencrypt.checkPassword(password, datapwd)) validUser = true;
			}
		}
		catch (SQLException s) { s.printStackTrace(); }
		catch (ClassNotFoundException c) { c.printStackTrace(); }
		
		// Redirect based on credentials
		// VALID
		if (validUser) 
		{
			// Get session, create Cookie object
			HttpSession session = request.getSession();
			session.setAttribute("user", username);
			session.setMaxInactiveInterval(60*60); // Logged out after an hour
			Cookie loginCookie = new Cookie("user", username);
			loginCookie.setMaxAge(60*60); // Expires in an hour
			response.addCookie(loginCookie);
			response.sendRedirect("index.jsp"); // Redirect to homepage
		}
		// INVALID
		else 
		{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
			PrintWriter out= response.getWriter();
			out.println("<font color=white>Either username or password is incorrect</font>");
			rd.include(request, response); // Back to login page
		}
	}
}
