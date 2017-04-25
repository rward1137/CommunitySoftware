package community.objects;

public class Event {
	// Location
	private String location;
	private float latitude, longitude;
	// User 
	private int userID;
	private String username;
	private boolean anon;
	// Date & Time
	private String date, time;
	// Details
	private String details;
	private int priorityLevelID, eventID, markerID;
	
	// CONSTRUCTOR
	public Event() {}
	
	// SET LOCATION
	public void setLocation(String address) { location = address; }
	public void setLong(float longitude) { this.longitude = longitude; }
	public void setLat(float lat) { latitude = lat; }
	
	// GET LOCATION
	public String getLocation() { return location; }
	public float getLong() { return longitude; }
	public float getLat() { return latitude; }
	
	// SET USER INFO
	public void setUserID(int id) { userID = id; }
	public void setUser(String name) { username = name; }
	public void setAnon(boolean a) { anon = a; }
	
	// GET USER INFO
	public int getUserID() { return userID; }
	public String getUser() { return username; }
	public boolean wasLoggedAnonymously() { return anon; }
	
	// SET DATE/TIME
	public void setDate(String date) { this.date = date; }	
	public void setTime(String time) { this.time = time; }
	
	// GET DATE/TIME
	public String createdOn() { return date; }	
	public String createdAt() { return time; }
	
	// SET EVENT DETAILS
	public void setDetails(String d) { details = d; }
	public void setID(int id) { eventID = id; }
	public void setMarker(int id) { markerID = id; }
	public void setPriorityLevel(int id) { priorityLevelID = id; }
	
	// GET EVENT DETAILS
	public String getDetails() { return details; }	
	public int getID() { return eventID; }
	public int getMarker() { return markerID; }
	public int getPriorityLevel() { return priorityLevelID; }	
}
