package com.smarthomepoint.model;

import com.wordnik.swagger.annotations.*;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.xml.bind.annotation.*;

@Entity
@NamedQueries( {
	@NamedQuery(name = "findUserByKeyword",  query = "SELECT o  FROM User o  WHERE o.username LIKE :value OR o.firstName LIKE :value OR o.lastName LIKE :value"),
	@NamedQuery(name = "findUserByUsername",  query = "SELECT o  FROM User o  WHERE o.username =:value"),
	@NamedQuery(name = "findUserById",  query = "SELECT o  FROM User o   WHERE o.id = :value"),
	@NamedQuery(name = "findAll",  query = "SELECT o  FROM User o "),
})


@XmlRootElement(name = "User")
public class User {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	private String username;
	private String firstName;
	private String lastName;
	private String email;
	private String password;
	private String phone;
	private String imageUrl;
	private int userStatus;
	private int userRole;

	
	public User() {
	}
	
	@XmlElement(name = "id")
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@XmlElement(name = "firstName")
	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	@XmlElement(name = "username")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@XmlElement(name = "lastName")
	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	@XmlElement(name = "email")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@XmlElement(name = "password")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@XmlElement(name = "phone")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@XmlElement(name = "userStatus")
	@ApiProperty(value = "User Status", allowableValues = "1-registered,2-active,3-closed")
	public int getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(int userStatus) {
		this.userStatus = userStatus;
	}

	@XmlElement(name = "userRole")
	@ApiProperty(value = "User Role", allowableValues = "1-admin,2-majordomus,3-habitant,4-friend,5-visitor")
	public int getUserRole() {
		return userRole;
	}

	public void setUserRole(int userRole) {
		this.userRole = userRole;
	}

	@XmlElement(name = "imageUrl")
	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
}