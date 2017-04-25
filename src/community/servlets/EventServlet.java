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
import java.util.Calendar;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

@WebServlet("/EventServlet")
public class EventServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// Database objects
	private Connection connect;
	private Statement stmt;
	private PreparedStatement prep;
	private ResultSet result;

	// Event info 
	private int markerID = 1, eventCatID = 0,  priorityLevel = 0, anonymous;
	private float latitude, longitude;
	private String username, userID, description, address, anonString;
	private int usernum;
	private Timestamp timestamp;
	
	/**
	 * HttpServlet#doPost
	 * If necessary the form fields are present
	 * This method connects to the database and runs the
	 * NewEventWithNewMarkerCreate procedure with user-supplied data
	 */
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws IOException, ServletException { 
		
		if	// Field checks 
		(  request.getParameter("address").equals("") 
		|| request.getParameter("cat-select").equals("")
		|| request.getParameter("priority-select").equals("")
		|| request.getParameter("description").equals("") )
		{
			// Bad form redirect
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			PrintWriter out = response.getWriter();
			out.println("<font color=white>No fields in the Event form may be left blank</font>");
			rd.include(request, response);
		}
		
		else // All correct
		{
			// Get data
			address = request.getParameter("address");
			eventCatID = Integer.parseInt(request.getParameter("cat-select"));
			priorityLevel = Integer.parseInt(request.getParameter("priority-select"));
			description = request.getParameter("description");
			anonString = request.getParameter("anon");
			latitude = Float.parseFloat(request.getParameter("latitude"));
			longitude = Float.parseFloat(request.getParameter("longitude"));
			if (anonString == null) { anonymous = 0; }
			else { anonymous = 1; }
			Cookie[] cookie = request.getCookies();
			if (cookie != null) username = cookie[0].getValue();
			
			
			try {	// Database connection
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				connect = DriverManager.getConnection("jdbc:sqlserver://waketechcommunitywatchsqlvm000001.database.windows.net;databaseName=WAKETECHCOMMUNITYWATCHDB000001;user=communitywatchadmin;password=WakeTech2018;");
				stmt = connect.createStatement();
				
				// Find userID
				result = stmt.executeQuery("select ID from Users where username = \'" + username + "\'");
				while (result.next()) { userID = result.getString("ID"); }
				usernum = Integer.parseInt(userID);

				// SQL Timestamp
				timestamp = new Timestamp(Calendar.getInstance().getTimeInMillis());
				
				// Database Update
				prep = connect.prepareStatement("EXEC sp_NewEventWithNewMarkerCreate ?, ?, ?, ?, ?, ?, ?, ?, ?, ?");
				prep.setInt(1, markerID);
				prep.setInt(2, eventCatID);
				prep.setString(3, address);
				prep.setFloat(4, latitude);
				prep.setFloat(5, longitude);
				prep.setTimestamp(6, timestamp);
				prep.setInt(7, usernum);
				prep.setString(8, description);
				prep.setInt(9, anonymous);
				prep.setInt(10, priorityLevel);
				prep.executeUpdate();
				prep.close();	
			}
			catch (SQLException s) { s.printStackTrace(); } 
			catch (ClassNotFoundException e) { e.printStackTrace(); }
			
			response.sendRedirect("index.jsp"); // Redirect back to homepage
		}
	}
}


/*
sp_NewEventWithNewMarkerCreate
1 @MarkerID int,
2 @EventCategoryNameID    SmallInt,
3 @Address    VARCHAR(MAX),
4 @Latitude    Float,
5 @Longitude    Float,                         
6 @EventDate    DATETime,
7 @UserID    int,
8 @Details    VARCHAR(MAX),
9 @AnonymousLogged    bit,
10 @PriorityLevelID    SMALLINT
*/
