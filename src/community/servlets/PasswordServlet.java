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
	
	String username, oldpassword, storedpassword, newpassword, passworde;
	BasicPasswordEncryptor bpe;
	Connection connect;
	Statement stmt;
	PreparedStatement prep;
	ResultSet result;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		bpe = new BasicPasswordEncryptor();
		Cookie[] cookie = request.getCookies();
		username = cookie[0].getValue();
		
		oldpassword = request.getParameter("oldpassword");
		newpassword = request.getParameter("newpassword");
		passworde = bpe.encryptPassword(newpassword);
		
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			connect = DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
			stmt = connect.createStatement();
			result = stmt.executeQuery("select UserPassword from Users where UserName = \'" + username + "\'");
			while (result.next()) {
				storedpassword = result.getString("UserPassword");
			}
			if (bpe.checkPassword(oldpassword, storedpassword)) {
				stmt.executeUpdate("update users set UserPassword = \'" + passworde
							+ "\' where UserName = \'" + username + "\'");
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/profile.jsp");
				PrintWriter out = response.getWriter();
				out.println("<font color=pink>Password Changed</font>");
				rd.include(request, response);
			}
			else {
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/profile.jsp");
				PrintWriter out = response.getWriter();
				out.println("<font color=pink>That is not the correct old password for this account</font>");
				rd.include(request, response);
			}
			
			
		}
		catch (ClassNotFoundException c) { c.printStackTrace(); }
		catch (SQLException s) { s.printStackTrace(); }
		catch (IOException i) { i.printStackTrace(); }
		
	}

}
