package community.objects;

public class Post {
	private int postID;
	private String subject;
	private String content;
	private String createdOn;
	private String createdTime;
	private int userID;
	private int statusID;
	
	public Post() {}
	
	public Post(int id, String about, String contents, String created, String createdT,
			 int user, int status) {
		postID = id;
		subject = about;
		content = contents;
		createdOn = created;
		createdTime = createdT;
		userID = user;
		statusID = status;
	}
	
	public void setID(int id) { postID = id; }
	public int getID() { return postID; }
	public void setDate(String date) { createdOn = date; }
	public String createdOn() { return createdOn; }
	public void setTime(String time) { createdTime = time; }
	public String createdAt() { return createdTime; }
	public void setStatus(int id) { statusID = id; }
	public int getStatus() { return statusID; }
	public void setUser(int id) { userID = id; }
	public int createdBy() { return userID; }
	public void setSubject(String subj) { subject = subj; }
	public String getSubject() { return subject; }
	public void setContent(String cont) { content = cont; }
	public String getContent() { return content; }
	public String fullPost() { return (subject + ": " + content); }
}
