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

	private Connection connect;
	private Statement stmt;
	private ResultSet result;
	private String username;
	private String password;
	private boolean validUser;
	
	private BasicPasswordEncryptor passencrypt;
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		validUser = false;
		username = request.getParameter("username"); 
		password = request.getParameter("password");
		passencrypt = new BasicPasswordEncryptor();

		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			connect = DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
			stmt = connect.createStatement();
			result = stmt.executeQuery("select UserPassword from Users where UserName = \'" + username + "\'");
			
			while (result.next()) {
				String datapwd = result.getString("UserPassword");
				if (passencrypt.checkPassword(password, datapwd)) validUser = true;
			}
			
			if (validUser) {
				HttpSession session = request.getSession();
				session.setAttribute("user", username);
				//setting session to expire in 30 minutes
				session.setMaxInactiveInterval(30*60);
				Cookie loginCookie = new Cookie("user", username);
				//setting cookie to expire in 30 minutes
				loginCookie.setMaxAge(30*60);
				response.addCookie(loginCookie);
				response.sendRedirect("index.jsp");
			}
			else {
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
				PrintWriter out= response.getWriter();
				out.println("<font color=pink>login credentials are wack</font>");
				rd.include(request, response);
			}
		}
		catch (SQLException s) { s.printStackTrace(); }
		catch (ClassNotFoundException c) { c.printStackTrace(); }
	}
}
