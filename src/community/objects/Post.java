package community.objects;

public class Post {
	// Post details
	private String subject, content;
	private int postID;
	// Date & Time
	private String createdOn, createdTime;
	// User Details
	private String username;
	private int userID, statusID;
	
	// CONSTRUCTOR
	public Post() {}
	
	// SET POST DETAILS
	public void setSubject(String subj) { subject = subj; }	
	public void setContent(String cont) { content = cont; }	
	public void setID(int id) { postID = id; }
	
	// GET POST DETAILS
	public String getSubject() { return subject; }
	public String getContent() { return content; }	
	public int getID() { return postID; }
	
	// SET DATE & TIME
	public void setDate(String date) { createdOn = date; }	
	public void setTime(String time) { createdTime = time; }
	
	// GET DATE & TIME
	public String createdOn() { return createdOn; }
	public String createdAt() { return createdTime; }
	
	// SET USER DETAILS
	public void setUser(int id) { userID = id; }
	public void setUsername(String user) { username = user; }	
	public void setStatus(int id) { statusID = id; }
	
	// GET USER DETAILS
	public int getUserID() { return userID; }
	public String createdBy() { return username; }
	public int getStatus() { return statusID; }
}
