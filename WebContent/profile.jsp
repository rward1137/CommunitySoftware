<!doctype html>
<html><!-- InstanceBegin template="/Templates/postlogin.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta charset="UTF-8">
<!-- InstanceBeginEditable name="doctitle" -->
<title>Your Community Watch Profile</title>
<!-- InstanceEndEditable -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="CSS/style.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
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
if(cookies != null){
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
        
    </section>
</header>

<div id="content">
	
    <nav>
    	<ul>
        	<li><a href="index.jsp">Event Log</a></li>
            <li><a href="bulletinboard.jsp">Bulletin Board</a></li>
            <li><a href="profile.jsp">Account</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </nav>
    
    <%
    // Community Name
    // Full Name
    // Username
    // Address
 	java.sql.Connection connect;
	java.sql.Statement stmt;
	java.sql.ResultSet result;
	java.sql.PreparedStatement prep;
	String organization = "";
	int organizationID = 0;
	String firstname = "", lastname = "", address = "";
	
	try {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		connect = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
		stmt = connect.createStatement();
		
		result = stmt.executeQuery("select FirstName, LastName, OrganizationID, AddressID from Users where Username = \'" 
											+ userName + "\'");
		while (result.next()) {
			organizationID = Integer.parseInt(result.getString("organizationID"));
			firstname = result.getString("FirstName");
			lastname = result.getString("LastName");
			address = result.getString("AddressID");
		}
		
		result = stmt.executeQuery("select OrganizationName from Organizations where ID = " + organizationID);
		while (result.next()) organization = result.getString("OrganizationName");
		
		
	}
	catch (ClassNotFoundException c) { c.printStackTrace(); }
    
    %>
    
    <!-- InstanceBeginEditable name="main" -->
    <div id="user-info"><br>
      <h4>Account Information</h4>
    	<table class="table table-condensed">
          <tbody>
          	<tr>
            	<td><h5>Community:</h5></td>
            	<td><%= organization %></td>
            <tr>
              <td><h5>Full Name:</h5></td>
              <td><%= firstname + " " + lastname %></td>
            </tr>
            <tr>
              <td><h5>Username:</h5></td>
              <td><%= userName %></td>
            </tr>
            <tr>
              <td><h5>Address:</h5></td>
              <td><%= address %></td>
            </tr>
            <tr>
              <td><h5>Update Password:</h5></td>
              <td>
                <form id="change-password" action="PasswordServlet" method="post">
                    <label>Current Password:</label><input type="password" name="oldpassword">
                    <label>New Password:</label><input type="password" name="newpassword">
                    <label>Confirm Password:</label><input type="password" name="newpassword">
                    <input type="submit">
                </form>
              </td>
            </tr>
          </tbody>
        </table>
    
    </div>
    <!-- InstanceEndEditable -->


</div>

<footer>
	<section id="footcopy">
		&copy; Community Software 2017
    </section>
    
    <section id="footcontact">
    	901 Fayetteville Rd<br>
        Raleigh, NC 27603<br>
        (919)866-5000<br>
    </section>
    
    <section id="footsocial">
        <a href="mailto:CommunitySoftwareWakeTech@gmail.com">Contact Us</a>
    </section>
    
	

</footer>
<!-- InstanceBeginEditable name="js" -->

<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
