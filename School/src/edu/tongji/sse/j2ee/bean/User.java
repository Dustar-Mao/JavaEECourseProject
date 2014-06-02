package edu.tongji.sse.j2ee.bean;

import edu.tongji.sse.j2ee.errors.UserIdNotFound;
import edu.tongji.sse.j2ee.errors.WrongPassword;

public class User {
	final private int uID;
	private boolean stude;
	private boolean admin;
	private String name;
	private String phone;
	private String email;
	
	public User() {
		uID = 0;
		stude = false;
		admin = false;
		name = "";
	}
	
	public User(String ID, String password) 
			throws UserIdNotFound,WrongPassword {
		if (ID == null)
			throw new UserIdNotFound();
		uID=Integer.parseInt(ID);
		if (password == null)
			throw new WrongPassword();
		name="test";
		stude = false;
		admin = false;
	}
	
	public User(int uID, boolean isStudent, boolean isAdmin, String name) {
		this.uID = uID;
		this.stude = isStudent;
		this.admin = isAdmin;
		this.name = name;
	}
	
	public int getuID() {
		return uID;
	}

	public boolean isStude() {
		return stude;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
