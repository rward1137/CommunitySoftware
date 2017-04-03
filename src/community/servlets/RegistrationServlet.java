package community.servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.jasypt.util.password.BasicPasswordEncryptor;
import org.jasypt.util.password.PasswordEncryptor;

@WebServlet("/RegisterServlet")
public class RegistrationServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private Connection connect;
	private Statement stmt;
	private ResultSet result;
	private PreparedStatement prep;
	
	private String fname, lname, username, password, passworde, email;
//	private String address;
	private int communityID;
	private boolean existingCommunityId, existingUsername, existingEmail;
	
	private PasswordEncryptor passencrypt;
	
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) {
		// get first, last, communityID, username, password, email, address (1 string now)
			// from request.getParameter()
		fname = request.getParameter("first");
		lname = request.getParameter("last");
		username = request.getParameter("username");
		password = request.getParameter("password");
		email = request.getParameter("email");
//		address = request.getParameter("address");
		communityID = Integer.parseInt(request.getParameter("communityID"));
		
		passencrypt = new BasicPasswordEncryptor();
		passworde = passencrypt.encryptPassword(password);
		
		
		
		existingCommunityId = false;
		existingUsername = false;
		existingEmail = false;
		
		// get database connection
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			connect = DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
			stmt = connect.createStatement();
			
			// check info for acceptability
				// ensure communityID is in database
			result = stmt.executeQuery("select ID from Organizations where ID = " + communityID);
			while (result.next()) { 
				int comID = Integer.parseInt(result.getString("id"));
				if (comID == communityID) existingCommunityId = true; 
			}
				// ensure username is not already in database
			result = stmt.executeQuery("select UserName from Users where UserName = \'" + username + "\'");
			while (result.next()) { 
				String usrn = result.getString("username");
				if (usrn.equals(username)) existingUsername = true; 
			}
				// ensure email is not already in database
			result = stmt.executeQuery("select Email from Users where Email = \'" + email + "\'");
			while (result.next()) { 
				String emailadd = result.getString("email");
				if (emailadd.equals(email)) existingEmail = true; 
			}
			
			// if NoCommunityId, existingUsername, or existingEmail, redirect back to registration page
				// with relevant error message
			if (!existingCommunityId) {
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/registrationfailure.html");
				PrintWriter out= response.getWriter();
				out.println("<font color=pink>That Community ID does not exist in our database</font>");
				rd.include(request, response);
			}
			else if (existingUsername) {
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/registrationfailure.html");
				PrintWriter out= response.getWriter();
				out.println("<font color=pink>That username already exists in our database</font>");
				rd.include(request, response);
			}
			else if (existingEmail) {
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/registrationfailure.html");
				PrintWriter out= response.getWriter();
				out.println("<font color=pink>That email address is already in use in our database</font>");
				rd.include(request, response);
			}
			else {
				
				// Prepare User insertion statement
				prep = connect.prepareStatement("EXEC sp_NewUser ?, ?, ?, ?, ?, ?, ?, ?, ?");
				// username
				prep.setString(1, username);
				// userpassword
				prep.setString(2, passworde);
				// firstname
				prep.setString(3, fname);
				// lastname
				prep.setString(4, lname);
				// email
				prep.setString(5, email);
				// userlevelID
				prep.setInt(6, 1);
				// userstatusID
				prep.setInt(7, 1);
				// organizationID
				prep.setInt(8, communityID);
				// addressID
				prep.setInt(9, 1);
				
				// longitude
					// TODO
				// latitude
					// TODO
				
				prep.executeUpdate();
				
				response.sendRedirect("registrationsuccess.html");
			
			}
			// else: insert new user into database w prepared statement
				// redirect to login screen with success message, "please log in now"
		}
		catch (SQLException s) { s.printStackTrace(); }
		catch (IOException i) { i.printStackTrace(); }
		catch (ServletException v) { v.printStackTrace(); } 
		catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
