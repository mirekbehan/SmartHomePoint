package com.smarthomepoint.model;


import javax.persistence.Embeddable;
import javax.xml.bind.annotation.*;

@Embeddable
@XmlRootElement(name = "Location")
public class Location {
	
	private double latitude;
	private double longitude;
	private double altitude;

	public Location() {
	}
	
	public Location(double latitude, double longitude, double altitude) {
		this.latitude =latitude;
		this.longitude = longitude;
		this.altitude = altitude;
	}
	
	
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getAltitude() {
		return altitude;
	}
	public void setAltitude(double altitude) {
		this.altitude = altitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	
	
	
}