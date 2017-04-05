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
	
	// old ones
	private String location;
	private String eventType;

	
	// for NewEventWithNewMarker
	private int markerID = 1;
	private int markerNameID;
	private String markerName;
	private String address;
	private float latitude;
	private float longitude;
	private int markerTypeID;
	private String date;
	private String time;
	private String username;
	private String userID;
	private String description;
	private String anonString;
	private int anonymous;
	private int priorityLevel;
	
	/*
	sp_NewEventWithNewMarker
?	1 @MarkerID int,
*	2 @MarkerNamesID    SmallInt,
*	3 @Address    VARCHAR(MAX),
*	4 @Lattitude    Float,
*	5 @Longitude    Float,
*	6 @MarkerTypeID    SmallInt,                            
*	7 @EventDate    DATE,
*	8 @EventTime    Time,
*	9 @UserID    nvarchar(128),
*	10 @Details    VARCHAR(MAX),
*	11 @AnonymousLogged    bit,
*	12 @PriorityLevelID    SMALLINT
	*/
	
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws IOException, ServletException { 
		
		address = request.getParameter("address");
		latitude = Float.parseFloat(request.getParameter("latitude"));
		longitude = Float.parseFloat(request.getParameter("longitude"));
		markerNameID = Integer.parseInt(request.getParameter("cat-select"));
		priorityLevel = Integer.parseInt(request.getParameter("priority-select"));
		description = request.getParameter("description");
		anonString = request.getParameter("anon");
		if (anonString == null) { anonymous = 0; }
		else { anonymous = 1; }
		
		Cookie[] cookie = request.getCookies();
		if (cookie == null) { response.sendRedirect("bam.html"); }
		username = cookie[0].getValue();
		
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			connect = DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
			stmt = connect.createStatement();
			
			// Assign UserID based on username from cookie
			result = stmt.executeQuery("select ID from Users where username = \'" + username + "\'");
			while (result.next()) { userID = result.getString("ID"); }
			
			// Get marker name for marker type selection
			result = stmt.executeQuery("select MarkerName from MarkerNames where ID = " + markerNameID);
			while (result.next()) { markerName = result.getString("MarkerName"); }
			
			// Get marker type number
			result = stmt.executeQuery("select ID from MarkerTypes where MarkerTypeName = \'" + markerName + "\'");
			while (result.next()) { markerTypeID = Integer.parseInt(result.getString("ID")); }
		
			// Date
			Date todate = new Date(System.currentTimeMillis());
			
			// Time
			LocalTime time = LocalTime.now();
			int hr = time.getHour();
			int min = time.getMinute();
			int sec = time.getSecond();
			String timeString = "" + hr + ":" + min + ":" + sec;
			
			// Database Update
			prep = connect.prepareStatement("EXEC NewEventWithNewMarkerCreate ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?");
			prep.setInt(1, markerID); // Dummy field initialized to 1
			prep.setInt(2, markerNameID);
			prep.setString(3, address);
			prep.setFloat(4, latitude);
			prep.setFloat(5, longitude);
			prep.setInt(6, markerTypeID);
			prep.setDate(7, todate);
			prep.setString(8, timeString);
			prep.setString(9, userID);
			prep.setString(10, description);
			prep.setInt(11, anonymous);
			prep.setInt(12, priorityLevel);
			prep.executeUpdate();
			/*
			sp_NewEventWithNewMarker
		?	1 @MarkerID int,
		*	2 @MarkerNamesID    SmallInt,
		*	3 @Address    VARCHAR(MAX),
		*	4 @Lattitude    Float,
		*	5 @Longitude    Float,
		*	6 @MarkerTypeID    SmallInt,                            
		*	7 @EventDate    DATE,
		*	8 @EventTime    Time,
		*	9 @UserID    nvarchar(128),
		*	10 @Details    VARCHAR(MAX),
		*	11 @AnonymousLogged    bit,
		*	12 @PriorityLevelID    SMALLINT
			*/
		
			response.sendRedirect("index.jsp");
		}
		catch (SQLException s) { s.printStackTrace(); } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
