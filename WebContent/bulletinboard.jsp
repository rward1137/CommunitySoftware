<!doctype html>
<html><!-- InstanceBegin template="/Templates/postlogin.dwt" codeOutsideHTMLIsLocked="false" -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
	connect = java.sql.DriverManager.getConnection("jdbc:sqlserver://waketechcommunitywatchsqlvm000001.database.windows.net;databaseName=WAKETECHCOMMUNITYWATCHDB000001;user=communitywatchadmin;password=WakeTech2018;");
	stmt = connect.createStatement();
	
	result = stmt.executeQuery("select ID from Posts");
	while (result.next()) {mostRecentPost = Integer.parseInt(result.getString("ID")); }
	mostRecentPost = mostRecentPost - 20;
	
	result = stmt.executeQuery("select * from Posts where ID >= " + mostRecentPost);
	while (result.next()) {
		post = new Post();
		post.setID(Integer.parseInt(result.getString("ID")) );
		post.setSubject(result.getString("Subject"));
		post.setContent(result.getString("Content"));
		post.setDate(result.getString("Created"));
		post.setDate(post.createdOn().substring(0, 16));
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

while (posts.size() < 21) {
	post = new Post();
	post.setID(0);
	post.setSubject("Test Post");
	post.setContent("This is just a test post");
	post.setDate("1-1-11");
	post.setTime("10:30");
	post.setUser(1);
	posts.add(0, post);
}
// posts.get(i).getSubject()
//				.createdBy()
//				.createdOn()
//				.getContent()
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
        	
            <div class="row no-gutters" id="content">
            <!-- InstanceBeginEditable name="main" -->
            	<div class="col-12 col-md-8" id="main-content">
                    <div id="posts">
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(20).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(20).createdBy() + "\t"
                            										+ posts.get(20).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(20).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(19).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(19).createdBy() + "\t"
                            										+ posts.get(19).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(19).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(18).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(18).createdBy() + "\t"
                            										+ posts.get(18).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(18).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(17).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(17).createdBy() + "\t"
                            										+ posts.get(17).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(17).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(16).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(16).createdBy() + "\t"
                            										+ posts.get(16).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(16).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(15).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(15).createdBy() + "\t"
                            										+ posts.get(15).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(15).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(14).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(14).createdBy() + "\t"
                            										+ posts.get(14).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(14).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(13).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(13).createdBy() + "\t"
                            										+ posts.get(13).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(13).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(12).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(12).createdBy() + "\t"
                            										+ posts.get(12).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(12).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(11).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(11).createdBy() + "\t"
                            										+ posts.get(11).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(11).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(10).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(10).createdBy() + "\t"
                            										+ posts.get(10).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(10).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(9).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(9).createdBy() + "\t"
                            										+ posts.get(9).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(9).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(8).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(8).createdBy() + "\t"
                            										+ posts.get(8).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(8).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(7).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(7).createdBy() + "\t"
                            										+ posts.get(7).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(7).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(6).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(6).createdBy() + "\t"
                            										+ posts.get(6).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(6).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(5).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(5).createdBy() + "\t"
                            										+ posts.get(5).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(5).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(4).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(4).createdBy() + "\t"
                            										+ posts.get(4).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(4).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(3).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(3).createdBy() + "\t"
                            										+ posts.get(3).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(3).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(2).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(2).createdBy() + "\t"
                            										+ posts.get(2).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(2).getContent() %>
                            </p>
                          </div>
                        </div>
                        <div class="card">
                          <div class="card-block">
                            <h4 class="card-title"><%= posts.get(1).getSubject() %></h4>
                            <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(1).createdBy() + "\t"
                            										+ posts.get(1).createdOn() %></h6>
                            <p class="card-text">
                            	<%= posts.get(1).getContent() %>
                            </p>
                          </div>
                        </div>
                         
                    </div> <!-- /#posts -->
                    
                </div> <!-- /.col #main-content-->
                
                <div class="col-12 col-md-4" id="aside">
                    
                    <div id="new-bulletin">
                    <h5>New Post</h5>
                    <form id="bull-form" action="PostServlet" method="post">
                        <input type="text" name="subject" placeholder="Subject line" size="41" maxlength="50"> <br> <br>
                        <textarea rows="4" name="content" cols="30" placeholder="Your message..." maxlength="300"></textarea> <br>
                        <input type="submit"><input type="reset">
                    </form>
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