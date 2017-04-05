<!doctype html>
<html><!-- InstanceBegin template="/Templates/postlogin.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta charset="UTF-8">
<!-- InstanceBeginEditable name="doctitle" -->
<title>Community Watch Forum</title>
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
        
    </section>
</header>

<div id="content">

<%@ page import="community.objects.Post" %>
<%
java.sql.Connection connect;
java.sql.Statement stmt;
java.sql.ResultSet result;
java.sql.PreparedStatement prep;

java.util.ArrayList<Post> posts = new java.util.ArrayList<>();
Post post;
int mostRecentPost = 0;

try {
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	connect = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
	stmt = connect.createStatement();
	
	result = stmt.executeQuery("select ID from Posts");
	while (result.next()) {mostRecentPost = Integer.parseInt(result.getString("ID")); }
	mostRecentPost = mostRecentPost - 20;
	
	result = stmt.executeQuery("select * from Posts where ID >= " + mostRecentPost);
	while (result.next()) {
		post = new Post();
		post.setID(Integer.parseInt(result.getString("ID")) );
		post.setSubject(result.getString("PostSubject"));
		post.setContent(result.getString("Content"));
		post.setDate(result.getString("PostCreatedDate"));
		post.setTime(result.getString("PostCreatedTime"));
		post.setUser(Integer.parseInt(result.getString("userID")));
		posts.add(post);
	}
	
}
catch(ClassNotFoundException c){ c.printStackTrace();}
catch(java.sql.SQLException s) { s.printStackTrace(); }


%>
	
    <nav>
    	<ul>
        	<li><a href="index.html">Event Log</a></li>
            <li><a href="forum.html">Forum</a></li>
            <li class="dropdown">
            	<a href="" class="dropbtn">Account</a>
                <div class="dropdown-content">
                	<a href="profile.html">Profile</a>
                    <a href="forum.html">Bulletin Board</a>
                    <form action="LogoutServlet" method="post">
                    <input type="submit" value="Logout" />
                    </form>
                    
                </div>
                
            </li>
        </ul>
    </nav>
    <!-- InstanceBeginEditable name="main" -->
    <div id="main-content">
    	
        <div id="posts" style="overflow:scroll">
        	<div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(0).getSubject() %></h3>
                <div class="panel-subtitle"> <%= posts.get(0).createdOn() %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(0).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Title goes here</h3>
                <div class="panel-subtitle"> User name and date goes here </div>
              </div>
              <div class="panel-body">
              Message body goes here  
              </div>
            </div>
            
        </div>
        
    </div>
    
    <aside><br>
    	<h5>New Post</h5>
        
    	<form action="PostServlet" method="post">
        	<input type="text" name="subject" placeholder="Subject line" size="41" maxlength="50">
            <textarea rows="4" cols="30" name="content" placeholder="Your message..." maxlength="300"></textarea>
            <input type="submit"><input type="reset">
        </form>
    </aside>
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
