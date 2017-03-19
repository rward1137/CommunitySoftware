package community.objects;

public class Event {
	private int eventID;
	private java.util.Date date;
	private int markerID;
	private int userID;
	private String details;
	private boolean anon;
	private int priorityLevelID;

	public Event() {}
	
	public Event(boolean anonymous, java.util.Date date, int priority, int user, 
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
	public int getMarker() { return markerID; }
	public int getUser() { return userID; }
	public int getPriorityLevel() { return priorityLevelID; }
	public java.util.Date createdOn() { return date; }
	public String getDetails() { return details; }
	public boolean wasLoggedAnonymously() { return anon; }
}
