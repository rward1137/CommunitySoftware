package community.objects;

import java.util.ArrayList;

public class Thread {
	private ArrayList<Post> posts;
	
	public Thread() {}
	public Thread(ArrayList<Post> posts) {
		this.posts = posts;
	}
	public boolean addPost(Post post) { return false; }
	public boolean contains(int postID) { return false; }
	public Post getPost(int postID) { return new Post(); }
	public ArrayList<Post> getAllPosts() { return posts; }
}
