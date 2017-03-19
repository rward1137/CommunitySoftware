package community.objects;

import java.util.ArrayList;

public class Forum {
	private ArrayList<Thread> threads;
	
	public Forum() {}
	public Forum(ArrayList<Thread> threads) {
		this.threads = threads;
	}
	public boolean addThread(Forum forum) { return false; }
	public ArrayList<Thread> getAllThreads() { return threads; }
}
