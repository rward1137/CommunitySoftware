package community.objects;

import java.util.ArrayList;

public class UserGroup {
	private ArrayList<User> users;
	private EventList events;
	private Forum forum;
	private java.util.Date createdOn;
	
	public UserGroup() {}
	
	public UserGroup (ArrayList<User> users, EventList events, Forum messages, java.util.Date createdOn) {
		this.users = users;
		this.events = events;
		forum = messages;
		this.createdOn = createdOn;
	}
	
	public java.util.Date getStartDate() { return createdOn; }
	
	public User getUser(String username) { return new User(); }
	
	public boolean contains(String username) { return false; }
	
	public ArrayList<User> getUsers() { return users; }
	
	public Forum getForum() { return forum; }
	
	public EventList getEvents() { return events; }
}
