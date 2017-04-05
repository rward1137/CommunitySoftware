package community.servlets;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.time.LocalTime;

@WebServlet("/PostServlet")
public class PostServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private Connection connect;
	private Statement stmt;
	private PreparedStatement prep;
	private ResultSet result;
	private String username, subject, content;
	private int threadID = 1, userID = 1, statusID = 1;
	
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
		
		// get request.getparam() for subject, content, threadID, username
		subject = request.getParameter("subject");
		content = request.getParameter("content");

		Cookie[] cookie = request.getCookies();
		if (cookie == null) { response.sendRedirect("bam.html"); }
		username = cookie[0].getValue();
		
		try {
			// get database connection
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			connect = DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
			stmt = connect.createStatement();
			
			// use username to look up userID, statusID
			result = stmt.executeQuery("select ID from Users where username = \'" + username + "\'");
			while (result.next()) { userID = Integer.parseInt(result.getString("ID")); }
			
			result = stmt.executeQuery("select UserStatusID from Users where username = \'" + username + "\'");
			while (result.next()) { statusID = Integer.parseInt(result.getString("UserStatusID")); }
			
			// create Date & Time for right now
			Date todate = new Date(System.currentTimeMillis());
			LocalTime time = LocalTime.now();
			int hr = time.getHour();
			int min = time.getMinute();
			int sec = time.getSecond();
			String timeString = "" + hr + ":" + min + ":" + sec;
			
			prep = connect.prepareStatement("EXEC sp_NewPost ?, ?, ?, ?, ?, ?, ?");
			prep.setString(1, subject);
			prep.setString(2, content);
			prep.setDate(3, todate);
			prep.setString(4, timeString);
			prep.setInt(5, threadID);
			prep.setInt(6, userID);
			prep.setInt(7, statusID); // user status
			prep.executeUpdate();
			/*
			  EXEC sp_NewPost
	          1 @PostSubject = 'How to start a neighborhood watch',
	          2 @Content = 'Step 1 Step 2 Step3',
	          3 @PostCreatedDate = @tempdate,
	          4 @PostCreatedTime = @temptime,
	          5 @ThreadID = 1,
	          6 @UserID = 1,
	          7 @StatusID = 1    
	        */
		}
		catch (SQLException s) { s.printStackTrace(); } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{}
		
		
		response.sendRedirect("bulletinboard.jsp");
	}
}
