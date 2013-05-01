package com.smarthomepoint.model;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.TemporalType;
import javax.persistence.Temporal;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@XmlRootElement
public class Message {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	private Long id;
	private String content;
	@Temporal(TemporalType.DATE)
	private Date posted;
	@OneToOne
	private User user;
	@OneToOne
	private Unit unit;
	
	public Message() {
	}

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getPosted() {
		return posted;
	}

	public void setPosted(Date posted) {
		this.posted = posted;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Unit getUnit() {
		return unit;
	}

	public void setUnit(Unit value) {
		this.unit = value;
	}


}
