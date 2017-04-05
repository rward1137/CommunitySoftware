package community.objects;



public class Event {
	private int eventID;
	private String date;
	private String time;
	private int markerID;
	private int userID;
	private String username;
	private String details;
	private boolean anon;
	private int priorityLevelID;
	private String location;
	private float latitude;
	private float longitude;

	public Event() {}
	
	public Event(boolean anonymous, String date, String time, int priority, int user, 
				int marker, int eventId, String details) {
		anon = anonymous;
		this.date = date;
		this.time = time;
		priorityLevelID = priority;
		userID = user;
		markerID = marker;
		eventID = eventId;
		this.details = details;
	}
	
	public void setLong(float longitude) { this.longitude = longitude; }
	public float getLong() { return longitude; }
	public void setLat(float lat) { latitude = lat; }
	public float getLat() { return latitude; }
	public void setLocation(String address) { location = address; }
	public String getLocation() { return location; }
	public void setUser(String name) { username = name; }
	public int getID() { return eventID; }
	public void setID(int id) { eventID = id; }
	public int getMarker() { return markerID; }
	public void setMarker(int id) { markerID = id; }
	public String getUser() { return username; }
	public void setUserID(int id) { userID = id; }
	public int getUserID() { return userID; }
	public int getPriorityLevel() { return priorityLevelID; }
	public void setPriorityLevel(int id) { priorityLevelID = id; }
	public String createdOn() { return date; }
	public void setDate(String date) { this.date = date; }
	public String createdAt() { return time; }
	public void setTime(String time) { this.time = time; }
	public String getDetails() { return details; }
	public void setDetails(String d) { details = d; }
	public boolean wasLoggedAnonymously() { return anon; }
	public void setAnon(boolean a) { anon = a; }
}
