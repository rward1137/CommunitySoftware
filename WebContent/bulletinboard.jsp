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
	mostRecentPost = mostRecentPost - 21;
	
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
	
	for (Post p : posts) {
		result = stmt.executeQuery("select username from users where id = " + p.getUserID());
		while (result.next()) p.setUsername(result.getString("username"));
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
                <h3 class="panel-title"><%= posts.get(20).getSubject() %></h3>
                <h6><%= posts.get(20).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(20).createdOn() + " "
                				+ posts.get(20).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(20).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(19).getSubject() %></h3>
                <h6><%= posts.get(19).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(19).createdOn() + " "
                				+ posts.get(19).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(19).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(18).getSubject() %></h3>
                <h6><%= posts.get(18).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(18).createdOn() + " "
                				+ posts.get(18).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(18).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(17).getSubject() %></h3>
                <h6><%= posts.get(17).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(17).createdOn() + " "
                				+ posts.get(17).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(17).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(16).getSubject() %></h3>
                <h6><%= posts.get(16).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(16).createdOn() + " "
                				+ posts.get(16).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(16).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(15).getSubject() %></h3>
                <h6><%= posts.get(15).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(15).createdOn() + " "
                				+ posts.get(15).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(15).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(14).getSubject() %></h3>
                <h6><%= posts.get(14).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(14).createdOn() + " "
                				+ posts.get(14).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(14).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(13).getSubject() %></h3>
                <h6><%= posts.get(13).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(13).createdOn() + " "
                				+ posts.get(13).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(13).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(12).getSubject() %></h3>
                <h6><%= posts.get(12).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(12).createdOn() + " "
                				+ posts.get(12).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(12).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(11).getSubject() %></h3>
                <h6><%= posts.get(11).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(11).createdOn() + " "
                				+ posts.get(11).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(11).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(10).getSubject() %></h3>
                <h6><%= posts.get(10).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(10).createdOn() + " "
                				+ posts.get(10).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(10).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(9).getSubject() %></h3>
                <h6><%= posts.get(9).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(9).createdOn() + " "
                				+ posts.get(9).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(9).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(8).getSubject() %></h3>
                <h6><%= posts.get(8).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(8).createdOn() + " "
                				+ posts.get(8).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(8).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(7).getSubject() %></h3>
                <h6><%= posts.get(7).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(7).createdOn() + " "
                				+ posts.get(7).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(7).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(6).getSubject() %></h3>
                <h6><%= posts.get(6).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(6).createdOn() + " "
                				+ posts.get(6).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(6).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(5).getSubject() %></h3>
                <h6><%= posts.get(5).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(5).createdOn() + " "
                				+ posts.get(5).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(5).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(4).getSubject() %></h3>
                <h6><%= posts.get(4).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(4).createdOn() + " "
                				+ posts.get(4).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(4).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(3).getSubject() %></h3>
                <h6><%= posts.get(3).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(3).createdOn() + " "
                				+ posts.get(3).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(3).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(2).getSubject() %></h3>
                <h6><%= posts.get(2).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(2).createdOn() + " "
                				+ posts.get(2).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(2).getContent() %>  
              </div>
            </div>
            
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= posts.get(1).getSubject() %></h3>
                <h6><%= posts.get(1).createdBy() %></h6>
                <div class="panel-subtitle"> <%= posts.get(1).createdOn() + " "
                				+ posts.get(1).createdAt().substring(0, 5) %> </div>
              </div>
              <div class="panel-body">
              <%= posts.get(1).getContent() %>  
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
