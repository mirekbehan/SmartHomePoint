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
import com.smarthomepoint.model.HouseUnit;
import java.util.Collection;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;

@Entity
@XmlRootElement(name = "HouseUnit")
public class HouseUnit {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	private String name;
	@Embedded
	private Location location;
	@ManyToOne(targetEntity = Controller.class)
	private List<Controller> controllers = new ArrayList<Controller>();
	@OneToMany
	@JoinColumn(name = "HouseUnit_id", referencedColumnName = "id")
	private Collection<HouseUnit> houseUnit;
	private String type;

	public HouseUnit() {
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
	public Collection<HouseUnit> getHouseUnit() {
		return houseUnit;
	}
	public void setHouseUnit(Collection<HouseUnit> param) {
		this.houseUnit = param;
	}
	
	
	public void setType(String param) {
		this.type = param;
	}
	public String getType() {
		return type;
	}

}
