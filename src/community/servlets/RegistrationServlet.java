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
import java.sql.Date;
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
	
	// Database objects
	private Connection connect;
	private Statement stmt;
	private ResultSet result;
	private PreparedStatement prep;
	
	// Registration info
	private String fname, lname, username, password1, password2, passworde, email, address;
	private String communityID;
	private boolean existingCommunityId, existingUsername, existingEmail;
	private int comID = 0;
	private Date today;
	private final int GUIDLENGTH = 36;
	
	// 3rd party encryption
	private PasswordEncryptor passencrypt;
	
	/**
	 * HttpServlet#doPost
	 * Attempts to use user-entered data to create a new row in 
	 * the Users table
	 */
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws IOException, ServletException {
		
		
		if	// All fields must be present
		(  request.getParameter("first").equals("")
		|| request.getParameter("last").equals("")
		|| request.getParameter("username").equals("")
		|| request.getParameter("password1").equals("")
		|| request.getParameter("password2").equals("")
		|| request.getParameter("email").equals("")
		|| request.getParameter("address").equals("")
		|| request.getParameter("communityID").equals("")
				)
		{	// IF NOT
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
			PrintWriter out = response.getWriter();
			out.println("<font color=white>No fields in the Registration form may be left blank</font>");
			rd.include(request, response); // Redirect back to registration form
		}
		
		// IF SO
		else {
			// Get data
			fname = request.getParameter("first");
			lname = request.getParameter("last");
			username = request.getParameter("username");
			password1 = request.getParameter("password1");
			password2 = request.getParameter("password2");
			email = request.getParameter("email");
			address = request.getParameter("address");
			communityID = request.getParameter("communityID");
			
			// Encrypt password
			passencrypt = new BasicPasswordEncryptor();
			passworde = passencrypt.encryptPassword(password1);
			
			// Failure flags
			existingCommunityId = false;
			existingUsername = false;
			existingEmail = false;
			
			// Passwords must match
			if (!password1.equals(password2)) {
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/registrationfailure.html");
				PrintWriter out= response.getWriter();
				out.println("<font color=white>The password fields did not match</font>");
				rd.include(request, response); // Redirect back to registration form
			}
			
			// If passwords match
			else 
			{
				try {		// Database connection
					Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
					connect = DriverManager.getConnection("jdbc:sqlserver://waketechcommunitywatchsqlvm000001.database.windows.net;databaseName=WAKETECHCOMMUNITYWATCHDB000001;user=communitywatchadmin;password=WakeTech2018;");
					stmt = connect.createStatement();
				
					// Checking information against our records
					// COMMUNITY ID
					if (communityID.length() == GUIDLENGTH) {
						result = stmt.executeQuery("select ID from Organizations where OrgGUID = \'" + communityID + "\'");
						while (result.next()) { 
							comID = Integer.parseInt(result.getString("ID"));
							existingCommunityId = true; 
						}
					}
					// USERNAME
					result = stmt.executeQuery("select UserName from Users where UserName = \'" + username + "\'");
					while (result.next()) { existingUsername = true; }
					// EMAIL
					result = stmt.executeQuery("select Email from Users where Email = \'" + email + "\'");
					while (result.next()) { existingEmail = true; }
				
					
					// Wrong community ID
					if (!existingCommunityId) {
						RequestDispatcher rd = getServletContext().getRequestDispatcher("/registrationfailure.html");
						PrintWriter out= response.getWriter();
						out.println("<font color=white>That Community ID number does not exist in our database</font>");
						rd.include(request, response); // Failure redirect
					}
					// Existing username
					else if (existingUsername) {
						RequestDispatcher rd = getServletContext().getRequestDispatcher("/registrationfailure.html");
						PrintWriter out= response.getWriter();
						out.println("<font color=white>That username already exists in our database</font>");
						rd.include(request, response); // Failure redirect
					}
					// Existing email
					else if (existingEmail) {
						RequestDispatcher rd = getServletContext().getRequestDispatcher("/registrationfailure.html");
						PrintWriter out= response.getWriter();
						out.println("<font color=white>That email address is already in use in our database</font>");
						rd.include(request, response); // Failure redirect
					}
					
					// If everything's acceptable
					else 
					{
						// Date
						today = new Date(System.currentTimeMillis());
						java.sql.Date todate = new java.sql.Date(today.getTime());
						
						// Database Update
						prep = connect.prepareStatement("exec sp_newuser ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?");
						prep.setString(1, username);
						prep.setString(2, passworde);
						prep.setString(3, fname);
						prep.setString(4, lname);
						prep.setString(5, email);
						prep.setDate(6, todate);
						prep.setDate(7, todate);
						prep.setInt(8, 1);
						prep.setInt(9, 1);
						prep.setInt(10, comID);
						prep.setString(11, address);
						prep.executeUpdate();
						prep.close();
				
						response.sendRedirect("registrationsuccess.html"); // Success Redirect
						
					}
				}
				catch (SQLException s) { s.printStackTrace(); }
				catch (ClassNotFoundException e) { e.printStackTrace(); }
			}
		}
	}
}

/*
sp_NewUser
1 @UserName VARCHAR(MAX),
2 @Password VARCHAR(MAX),
3 @FirstName VARCHAR(MAX),
4 @LastName VARCHAR(MAX),
5 @Email VARCHAR(MAX),
6 @Created    Date,
7 @LastActivity   Date,
8 @UserLevelID SMALLINT,
9 @UserStatusID SMALLINT,
10 @OrganizationID SMALLINT,
11 @Address VARCHAR(MAX) 
*/
