package community.objects;

import java.util.ArrayList;

public class EventList {
	private ArrayList<Event> events;
	
	public EventList() {}
	public EventList(ArrayList<Event> events) {
		this.events = events;
	}
	public boolean add(Event e) { return false; }
	public boolean contains(int eventID) { return false; }
	public Event getEvent(int eventID) { return new Event(); }
	public ArrayList<Event> getAllEvents() { return events; }
	public boolean remove(int eventID) { return false; }
}
