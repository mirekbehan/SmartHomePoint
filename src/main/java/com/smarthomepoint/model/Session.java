package com.smarthomepoint.model;

import javax.persistence.*;
import com.smarthomepoint.model.User;

@Entity
@Table(name = "SESSION")
public class Session {

	@Id
	private long id;
	private String token;
	private String expire;
	@OneToOne
	private User user;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public User getUser() {
		return user;
	}

	public void setToken(String param) {
		this.token = param;
	}

	public String getToken() {
		return token;
	}

	public void setExpire(String param) {
		this.expire = param;
	}

	public String getExpire() {
		return expire;
	}


}