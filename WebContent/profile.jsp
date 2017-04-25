<!doctype html>
<html><!-- InstanceBegin template="/Templates/postlogin.dwt" codeOutsideHTMLIsLocked="false" -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- InstanceBeginEditable name="doctitle" -->
<title>USERNAME Profile</title>
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

 <div class="container">
            <div class="row no-gutters" id="header">
                <div class="col-auto">
                    <img id="headlogo" src="images/logo.jpg" alt="community software logo"/>
                </div>
                <div class="col">
                    <section id="title">
                        Community Watch
                    </section>
                </div> 
            </div>
        
            <div class="row no-gutters" id="nav">
                <div class="col">
                    <nav class="navbar navbar-toggleable-sm navbar-inverse bg-inverse"> <!-- Brand and toggle get grouped for better mobile display -->
                        <button type="button" class="navbar-toggler navbar-toggler-left" data-toggle="collapse" data-target="#navbar-collapse-1" aria-controls="navbar-collapse-1" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                      
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="navbar-collapse-1">
                          <ul class="navbar-nav mr-auto">
                            <li class="nav-item active">
                            	<a class="nav-link" href="index.jsp">Event Log</a>
                            </li>
                            <li class="nav-item">
                            	<a class="nav-link" href="bulletinboard.jsp">Bulletin Board</a>
                            </li>
                            <li class="nav-item">
                            	<a class="nav-link" href="profile.jsp">Account</a>
                            </li>
                            <li class="nav-item">
                            	<a class="nav-link" href="LogoutServlet">Logout</a>
                            </li>
                          </ul>
                        </div><!-- /.navbar-collapse -->
                    </nav>
                </div><!-- /.col -->
            </div><!-- /.row -->
    
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
		connect = java.sql.DriverManager.getConnection("jdbc:sqlserver://waketechcommunitywatchsqlvm000001.database.windows.net;databaseName=WAKETECHCOMMUNITYWATCHDB000001;user=communitywatchadmin;password=WakeTech2018;");
		stmt = connect.createStatement();
		
		result = stmt.executeQuery("select FirstName, LastName, OrganizationID, Address from Users where Username = \'" 
											+ userName + "\'");
		while (result.next()) {
			organizationID = Integer.parseInt(result.getString("organizationID"));
			firstname = result.getString("FirstName");
			lastname = result.getString("LastName");
			address = result.getString("Address");
		}
		
		result = stmt.executeQuery("select OrganizationName from Organizations where ID = " + organizationID);
		while (result.next()) organization = result.getString("OrganizationName");
		
		
	}
	catch (ClassNotFoundException c) { c.printStackTrace(); }
    
    %>
    
            <div class="row no-gutters" id="content">
            <!-- InstanceBeginEditable name="main" -->
            
            <div class="col" id="main-content">
                <div id="user-info"><br>
                  <h4>Account Information</h4>
                    <table class="table table-condensed">
                      <tbody>
                        <tr>
                            <td><h5>Community:</h5></td>
                            <td><%= organization %></td>
                        </tr>
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
                                <label>New Password:</label><input type="password" name="newpassword1">
                                <label>Confirm Password:</label><input type="password" name="newpassword2">
                                <input type="submit" id="password-button">
                            </form>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                </div>
            </div>
    <!-- InstanceEndEditable -->
        	</div>
            <div class="row no-gutters" id="footer">
                <section id="footcopy" class="col-sm-4">
                &copy; Community Software 2017
                </section>
                
                <section id="footcontact" class="col-sm-4">
                    9101 Fayetteville Road<br>
                    Raleigh, NC 27603<br>
                    (919)866-5000<br> 
                </section>
                
                <section id="footsocial" class="col-sm-4">
                    <a href="mailto:CommunitySoftwareWakeTech@gmail.com">Contact Us</a>
                </section>
            </div>
        </div>
        <!-- InstanceBeginEditable name="js" -->

<!-- InstanceEndEditable -->
    </body>
<!-- InstanceEnd --></html>
