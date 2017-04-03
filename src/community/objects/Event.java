package community.objects;



public class Event {
	private int eventID;
	private String date;
	private int markerID;
	private int userID;
	private String details;
	private boolean anon;
	private int priorityLevelID;

	public Event() {}
	
	public Event(boolean anonymous, String date, int priority, int user, 
				int marker, int eventId, String details) {
		anon = anonymous;
		this.date = date;
		priorityLevelID = priority;
		userID = user;
		markerID = marker;
		eventID = eventId;
		this.details = details;
	}
	
	public int getID() { return eventID; }
	public void setID(int id) { eventID = id; }
	public int getMarker() { return markerID; }
	public void setMarker(int id) { markerID = id; }
	public int getUser() { return userID; }
	public void setUser(int id) { userID = id; }
	public int getPriorityLevel() { return priorityLevelID; }
	public void setPriorityLevel(int id) { priorityLevelID = id; }
	public String createdOn() { return date; }
	public void setDate(String date) { this.date = date; }
	public String getDetails() { return details; }
	public void setDetails(String d) { details = d; }
	public boolean wasLoggedAnonymously() { return anon; }
	public void setAnon(boolean a) { anon = a; }
}
