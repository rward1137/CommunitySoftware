package community.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet("/EventServlet")
public class EventServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private Connection connect;
	private Statement stmt;
	private PreparedStatement prep;
	private ResultSet result;
	
	private String userID;
	private String location;
	private String eventType;
	private String description;
	private String anon;
	private int anonymous;
	
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws IOException, ServletException { 
		
		location = request.getParameter("location");
		eventType = request.getParameter("event-type"); // use for markerID & priority level
		description = request.getParameter("description");
		anon = request.getParameter("anon"); // if null, unchecked
		if (anon == null) { anonymous = 0; }
		else { anonymous = 1; }
		
		
		Cookie[] cookie = request.getCookies();
		
		if (cookie == null) {
			response.sendRedirect("loginfailure.html");
		}
		
		// get username from cookie
		String username = cookie[0].getValue();
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			connect = DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
			stmt = connect.createStatement();
			result = stmt.executeQuery("select ID from Users where username = \'" + username + "\'");
			while (result.next()) {
				userID = result.getString("ID");
			}
			
			Date todate = new Date(System.currentTimeMillis());
			LocalTime time = LocalTime.now();
			int hr = time.getHour();
			int min = time.getMinute();
			int sec = time.getSecond();
			String timeString = "" + hr + ":" + min + ":" + sec;
			
			
			// get database connection & prepare statement below
			// This is crap and needs more logic to create all these fields correctly
			prep = connect.prepareStatement("EXEC sp_NewEvent ?, ?, ?, ?, ?, ?, ?");
			prep.setDate(1, todate);
			prep.setString(2, timeString); // Event Time - use system time, division etc
			prep.setInt(3, 1);
			int userid = Integer.parseInt(userID);
			prep.setInt(4, userid); 
			prep.setString(5, description);
			prep.setInt(6, anonymous);
			prep.setInt(7, 1);
			prep.executeUpdate();
			
			/*  EXEC sp_NewEvent
		 		1 @EventDate = @tempdate,
    			2 @EventTime = @temptime,
    			3 @MarkerID = 1,
    			4 @UserID = 1,
    			5 @Details = 'Something happened here be safe' ,
    			6 @AnonymousLogged = 0 ,
    			7 @PriorityLevelID = 1
			 */
		
			response.sendRedirect("index.jsp");
		}
		catch (SQLException s) { s.printStackTrace(); } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
