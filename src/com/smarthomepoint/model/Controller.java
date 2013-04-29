package com.smarthomepoint.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.xml.bind.annotation.XmlRootElement;

import com.wordnik.swagger.annotations.ApiProperty;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;

@Entity
@XmlRootElement
public class Controller {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	private String description;
	private String status;
	private String ip;
	@Embedded 	
	private Location location;
	@OneToMany
	@JoinColumn(name = "Controller_id", referencedColumnName = "id")
	private List<Element> elements;

	public Controller() {
	}
	
/*	public void addFunctionality(String tag) {
		if (getTags()==null) this.tags = new ArrayList<Tag>();
		getTags().add(tag);
	}
*/
	
	
	// --- 
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	public enum Status { planing, testing, available, warning, error; }
	@ApiProperty(value = "status of sensor", allowableValues = "planing, testing, available, warning, error")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	public Location getLocation() {
		return location;
	}
	public void setLocation(Location location) {
		this.location = location;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public List<Element> getExecutors() {
	    return elements;
	}

	public void setExecutors(List<Element> elements) {
	    this.elements = elements;
	}

	
	
	
	
	
	
	

	
	
	
}
