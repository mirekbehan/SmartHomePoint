package com.smarthomepoint.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.xml.bind.annotation.XmlRootElement;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;

@Entity
@XmlRootElement(name = "Unit")
public class Unit {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	private String name;
	@Embedded
	private Location location;
	@ManyToOne(targetEntity = Controller.class)
	private List<Controller> controllers = new ArrayList<Controller>();
	@OneToMany
	@JoinColumn(name = "Unit_id", referencedColumnName = "id")
	private List<Unit> units;
	private String type;

	public Unit() {
	}

	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Location getLocation() {
		return location;
	}
	public void setLocation(Location location) {
		this.location = location;
	}
	public List<Controller> getControllers() {
		return controllers;
	}
	public void setControllers(List<Controller> controllers) {
		this.controllers = controllers;
	}
	public List<Unit> getUnits() {
		return units;
	}
	public void setUnits(List<Unit> param) {
		this.units = param;
	}
	
	
	public void setType(String param) {
		this.type = param;
	}
	public String getType() {
		return type;
	}

}
