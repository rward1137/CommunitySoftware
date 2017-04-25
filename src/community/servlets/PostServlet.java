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
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

@WebServlet("/PostServlet")
public class PostServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// Database objects
	private Connection connect;
	private Statement stmt;
	private PreparedStatement prep;
	private ResultSet result;
	
	// Post info
	private String username, subject, content;
	private int userID = 1;
	private Timestamp timestamp;
	
	/**
	 * HttpServlet#doPost
	 * Uses user data fields to create a new row in 
	 * the Posts table
	 */
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws IOException, ServletException {
		
		// Get data
		subject = request.getParameter("subject");
		content = request.getParameter("content");

		// If there's no content field
		if (content.equals("")) {
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/bulletinboard.jsp");
			PrintWriter out = response.getWriter();
			out.println("<font color=white>You must enter something in the message area</font>");
			rd.include(request, response); // Redirect back to page
		}
		// If it's good
		else {
			// Get username
			Cookie[] cookie = request.getCookies();
			if (cookie == null) { response.sendRedirect("bam.html"); }
			username = cookie[0].getValue();
			
			try {	// Database connection
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				connect = DriverManager.getConnection("jdbc:sqlserver://waketechcommunitywatchsqlvm000001.database.windows.net;databaseName=WAKETECHCOMMUNITYWATCHDB000001;user=communitywatchadmin;password=WakeTech2018;");
				stmt = connect.createStatement();
				
				// Get userID
				result = stmt.executeQuery("select ID from Users where username = \'" + username + "\'");
				while (result.next()) { userID = Integer.parseInt(result.getString("ID")); }
				
				// Date
				timestamp = new Timestamp(Calendar.getInstance().getTimeInMillis());
				
				// Database Update
				prep = connect.prepareStatement("EXEC sp_NewPost ?, ?, ?, ?");
				prep.setString(1, subject);
				prep.setString(2, content);
				prep.setTimestamp(3, timestamp);
				prep.setInt(4, userID);
				prep.executeUpdate();
				
			}
			catch (SQLException s) { s.printStackTrace(); } 
			catch (ClassNotFoundException e) { e.printStackTrace(); }
			
			response.sendRedirect("bulletinboard.jsp"); // Redirect back to page
		}
	}
}

/*
sp_NewPost
@Subject    VARCHAR(MAX),
@Content    VARCHAR(MAX),
@Created    Date,
@UserID    INT    
*/

