package community.objects;

public class Post {
	private int postID;
	private String subject;
	private String content;
	private java.util.Date createdOn;
	private int threadID;
	private int userID;
	private int statusID;
	
	public Post() {}
	
	public Post(int id, String about, String contents, java.util.Date created,
			int thread, int user, int status) {
		postID = id;
		subject = about;
		content = contents;
		createdOn = created;
		threadID = thread;
		userID = user;
		statusID = status;
	}
	
	public int getID() { return postID; }
	public java.util.Date createdOn() { return createdOn; }
	public int getStatus() { return statusID; }
	public int createdBy() { return userID; }
	public int belongsIn() { return threadID; }
	public String getSubject() { return subject; }
	public String getContent() { return content; }
	public String fullPost() { return (subject + ": " + content); }
}
