package community.servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.jasypt.util.password.BasicPasswordEncryptor;

@WebServlet("/PasswordServlet")
public class PasswordServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	// Database objects
	Connection connect;
	Statement stmt;
	PreparedStatement prep;
	ResultSet result;
	
	// Password info
	String username, oldpassword, storedpassword, newpassword1, newpassword2, passworde;
	BasicPasswordEncryptor bpe;
	Cookie[] cookie;
	
	/**
	 * HttpServlet#doPost
	 * Checks the old password against the database
	 * If valid, and the new passwords match, the 
	 * password in the database is changed
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		// 3rd party encryption
		bpe = new BasicPasswordEncryptor();
		
		// Get username
		cookie = request.getCookies();
		username = cookie[0].getValue();
		
		// Get passwords 
		oldpassword = request.getParameter("oldpassword");
		newpassword1 = request.getParameter("newpassword1");
		newpassword2 = request.getParameter("newpassword2");
		// Compare
		passworde = bpe.encryptPassword(newpassword1);
		
		// Non-matching
		if (!newpassword1.equals(newpassword2)) {
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/profile.jsp");
			PrintWriter out = response.getWriter();
			out.println("<font color=white>New password fields did not match</font>");
			rd.include(request, response);
		} // Empty field
		else if (newpassword1.equals("")) {
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/profile.jsp");
			PrintWriter out = response.getWriter();
			out.println("<font color=white>New password cannot be blank</font>");
			rd.include(request, response);
		}
		else{ // Correct entries
		
			try {		// Database connection
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				connect = DriverManager.getConnection("jdbc:sqlserver://waketechcommunitywatchsqlvm000001.database.windows.net;databaseName=WAKETECHCOMMUNITYWATCHDB000001;user=communitywatchadmin;password=WakeTech2018;");
				stmt = connect.createStatement();
				
				// Get stored password
				result = stmt.executeQuery("select Password from Users where UserName = \'" + username + "\'");
				while (result.next()) { storedpassword = result.getString("Password"); }
				
				// Redirect based on old password being entered correctly
				// CORRECTLY
				if (bpe.checkPassword(oldpassword, storedpassword)) {
					stmt.executeUpdate("update Users set Password = \'" + passworde
								+ "\' where UserName = \'" + username + "\'");
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/profile.jsp");
					PrintWriter out = response.getWriter();
					out.println("<font color=white>Password Changed</font>");
					rd.include(request, response); // Redirect back to profile page
				}
				// INCORRECTLY
				else {
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/profile.jsp");
					PrintWriter out = response.getWriter();
					out.println("<font color=white>Old password did not match our records; nothing changed.</font>");
					rd.include(request, response); // Redirect to profile page
				}
		}
		catch (ClassNotFoundException c) { c.printStackTrace(); }
		catch (SQLException s) { s.printStackTrace(); }
		catch (IOException i) { i.printStackTrace(); }
		}
	}
}
