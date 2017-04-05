<!doctype html>
<html><!-- InstanceBegin template="/Templates/postlogin.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta charset="UTF-8">
<!-- InstanceBeginEditable name="doctitle" -->
<title>Welcome to Community Watch</title>
<!-- InstanceEndEditable -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="CSS/style.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->
</head>

<body>
<%
//allow access only if session exists
if(session.getAttribute("user") == null){
	response.sendRedirect("login.jsp");
}
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
	for(Cookie cookie : cookies){
		if(cookie.getName().equals("user")) userName = cookie.getValue();
	}
}
%>

<header>
    <img id="headlogo" src="images/logo.jpg" width="100" alt="community software logo"/> 
    <section id="title">
    Community Watch
    </section>
    
  <section id="headcontact">
    
    	123 Main St<br>
        Anytown, NC 99999<br>
        (987)654-3210<br>
        
      <a href="http://www.twitter.com"><img src="images/icons/twitter.png" width="24" height="24" class="icon-image" alt="Community Watch Twitter page" ></a>
      <a href="http://www.facebook.com"><img src="images/icons/fb.png" width="24" height="24" class="icon-image" alt="Community Watch Facebook page" ></a> 
      <a href="http://www.instagram.com"><img src="images/icons/instagram.png" width="24" height="24" class="icon-image" alt="Community Watch Instagram page"></a>
        
    </section>
</header>

<div id="content">
	
    <nav>
    	<ul>
        	<li><a href="index.jsp">Event Log</a></li>
            <li><a href="bulletinboard.jsp">Forum</a></li>
            <li class="dropdown">
            	<a href="" class="dropbtn">Account</a>
                <div class="dropdown-content">
                	<a href="profile.jsp">Profile</a>
                    <a href="LogoutServlet">Logout</a>
                </div>
                
            </li>
        </ul>
    </nav>
    <!-- InstanceBeginEditable name="main" -->
    <div id="main-content">
    <h5>Welcome to your Community Watch homepage</h5>
    <iframe
      width="525"
      height="330"
      frameborder="0" style="border:0"
      src="https://www.google.com/maps/embed/v1/place?key=AIzaSyCy49rkyTewVvRXpND7VhtXaOojb7PKG4w&q=Wake+Tech+Community+College" allowfullscreen>
	</iframe>
    
    </div>

<%@ page import="community.objects.Event" %> 
<% 
java.sql.Connection connect;
java.sql.Statement stmt;
java.sql.ResultSet result;
java.sql.PreparedStatement prep;
java.util.ArrayList<Event> events = new java.util.ArrayList<>();
Event tempEvent;
int mostRecentEvent = 0;
int anonlogged = 0;
String username;
int userID;

try{
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	connect = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
	stmt = connect.createStatement();
	
	result = stmt.executeQuery("select ID from events");
	while (result.next()) {mostRecentEvent = Integer.parseInt(result.getString("ID")); }
//	System.out.println(mostRecentEvent);
	mostRecentEvent = mostRecentEvent - 4;
//	System.out.println(mostRecentEvent);
	
	result = stmt.executeQuery("select * from events where ID >= " + mostRecentEvent);
	while (result.next()) {
	//	System.out.println(result.getString("Details"));
		tempEvent = new Event();
		tempEvent.setID(Integer.parseInt(result.getString("ID")));
		tempEvent.setDate(result.getString("EventDate"));
		String timestring = result.getString("EventTime");
		tempEvent.setTime(timestring.substring(0, 5));
		tempEvent.setMarker(Integer.parseInt(result.getString("MarkerID")));
		tempEvent.setDetails(result.getString("Details"));
		anonlogged = Integer.parseInt(result.getString("AnonymousLogged"));
		if (anonlogged == 0) {
			tempEvent.setUserID(Integer.parseInt(result.getString("UserID")));
			tempEvent.setUser("PlaceHolding");
		}
		else tempEvent.setUser("Anonymous");
		tempEvent.setPriorityLevel(Integer.parseInt(result.getString("PriorityLevelID")));
		events.add(tempEvent);
	}
	
	for (Event e : events) {
		if (!e.getUser().equals("Anonymous")) {
			int id = e.getUserID();
			result = stmt.executeQuery("select UserName from Users where ID = " + id);
			while (result.next()) {
				e.setUser(result.getString("UserName"));
			}
		}
	}
	
	
}
catch(ClassNotFoundException c){ c.printStackTrace();}
catch(java.sql.SQLException s) { s.printStackTrace(); }

%>
    
    <aside><br>
    	<ul class="nav nav-tabs">
        	<li class="active"><a data-toggle="tab" href="#recent">Recent Events</a></li>
            <li><a data-toggle="tab" href="#new">New Event</a></li>
        </ul>
        <div class="tab-content">
        	<div id="recent" class="tab-pane fade in active">
            	<div id="recent-events">
            		<table width="250">
  					 <tbody>
  					    		<!-- MOST RECENT EVENT -->
                        <tr>
                          <td><%= events.get(4).createdOn() %> </td>
                          <td><%= events.get(4).createdAt() %></td>
                          <td>Location</td>
                          <td><%= events.get(4).getDetails() %> </td>
                          <td>Logged By:<td>
                          <td><%= events.get(4).getUser() %> </td>
                        </tr>
                                  <!-- 2ND MOST RECENT -->
                        <tr>
                          <td><%= events.get(3).createdOn() %> </td>
                          <td><%= events.get(3).createdAt() %></td>
                          <td>Location</td>
                          <td><%= events.get(3).getDetails() %> </td>
                          <td>Logged By:<td>
                          <td><%= events.get(3).getUser() %> </td>
                        </tr>
                                  <!-- 3RD MOST RECENT -->
                        <tr>
                          <td><%= events.get(2).createdOn() %> </td>
                          <td><%= events.get(2).createdAt() %></td>
                          <td>Location</td>
                          <td><%= events.get(2).getDetails() %> </td>
                          <td>Logged By:<td>
                          <td><%= events.get(2).getUser() %> </td>
                        </tr>
                        <tr>
                          <!-- 4TH MOST RECENT -->
                           <td><%= events.get(1).createdOn() %> </td>
                          <td><%= events.get(1).createdAt() %></td>
                          <td>Location</td>
                          <td><%= events.get(1).getDetails() %> </td>
                          <td>Logged By:<td>
                          <td><%= events.get(1).getUser() %> </td>
                        </tr> 
                        <tr>
                          <!-- 5TH MOST RECENT -->
                          <td><%= events.get(0).createdOn() %> </td>
                          <td><%= events.get(0).createdAt() %></td>
                          <td>Location</td>
                          <td><%= events.get(0).getDetails() %> </td>
                          <td>Logged By:<td>
                          <td><%= events.get(0).getUser() %> </td>
                        </tr>
                      </tbody>
                    </table>
				</div>
            </div>
            <div id="new" class="tab-pane fade">
            <form action="EventServlet" method="post" id="log-event">
            <h5>Log New Event</h5>
                <label>Location:</label>
                <input type="text" name="location" placeholder="google places">
                <p id="event-radio">
                  <label>
                    <input type="radio" name="event-type" value="theft" id="theft">
                    Theft</label>
                  <br>
                  <label>
                    <input type="radio" name="event-type" value="vandal" id="vandal">
                    Vandalism</label>
                  <br>
                  <label>
                    <input type="radio" name="event-type" value="breakin" id="breakin">
                    Break-in</label>
                  <br>
                  <label>
                    <input type="radio" name="event-type" value="assault" id="assault">
                    Assault</label>
                  <br>
                  <label>
                    <input type="radio" name="event-type" value="suspicious" id="Suspicious">
                    Suspicious Activity</label>
                  <br>
                </p>
                <label>Event description: </label>
                <textarea cols="28" rows="2" name="description"></textarea>
                <div id="anonbox">
                <input type="checkbox" name="anon"> <label>Remain Anonymous</label></div>
                <input name="eventbutton" type="submit" id="eventbutton">
            </form>
			</div>
		</div>
    </aside>
    <!-- InstanceEndEditable -->


</div>

<footer>
	<section id="footcopy">
		&copy; Community Software 2017
    </section>
    
    <section id="footsocial">
    	<a href="http://www.twitter.com"><img src="images/icons/twitter.png" width="24" height="24" class="icon-image" alt="Community Watch Twitter page" ></a>
      <a href="http://www.facebook.com"><img src="images/icons/fb.png" width="24" height="24" class="icon-image" alt="Community Watch Facebook page" ></a> 
      <a href="http://www.instagram.com"><img src="images/icons/instagram.png" width="24" height="24" class="icon-image" alt="Community Watch Instagram page"></a>
        <br>
        <a href="mailto:CommunitySoftwareWakeTech@gmail.com">Contact Us</a>
    </section>
    
	<section id="footcontact">
    	123 Main St<br>
        Anytown, NC 99999<br>
        (987)654-3210<br> 
    </section>

</footer>

</body>
<!-- InstanceEnd --></html>
