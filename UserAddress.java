package community.objects;

public class UserAddress {
	private String addressID;
	private String streetNum;
	private String street;
	private String city;
	private String state;
	private int zip;
	private String country;
	
	public UserAddress() {}
	
	public UserAddress(String streetName, String streetNumber, String city, String state, int zip) {
		street = streetName;
		streetNum = streetNumber;
		this.city = city;
		this.state = state;
		this.zip = zip;
		country = "US";
		addressID = "1A";
	}
	
	public String getID() { return addressID; }
	
	public String toString() {
		String s = "";
		s += streetNum + " " + street + ", " + city + ", " + state + " " + zip + " (" + country + ")";
		s += "\n";
		return s;
	}
}
