package community.objects;

public class User {
	private int userID;
	private String username;
	private String password;
	private String fname;
	private String lname;
	private String email;
	private java.util.Date createdOn;
	private java.util.Date lastActive;
	private String userLevel;
	private String userStatus;
	private String organization;
	private UserAddress address;
	
	public User() {}
	
	public User(String username, String password, String fname, String lname, String email, UserAddress address,
				String level, String org) {
		this.username = username;
		this.password = password;
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.address = address;
		this.userLevel = level;
		this.organization = org;
		createdOn = new java.util.Date(System.currentTimeMillis());	
	}
	
	public String getName() { return (fname + " " + lname); }
	public String getLogin() { return (username + "\n" + password); }
	public String getUsername() { return username; }
	public String getPassword() { return password; }
	public int getID() { return userID; }
	public String getEmail() { return email; }
	public java.util.Date activeSince() { return createdOn; }
	public java.util.Date lastActive() { return lastActive; }
	public String belongsTo() { return organization; }
	public UserAddress getaddress() { return address; }
	public String getLevel() { return userLevel; }
	public String getStatus() { return userStatus; }

}
