package com.smarthomepoint.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

import com.wordnik.swagger.annotations.ApiProperty;

@Entity
@XmlRootElement
public class Event {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	private String type;
	private String value;
	@Temporal(TemporalType.DATE)
	private Date date;
	private Long timestamp;
	private String status;
	@OneToOne
	private HouseUnit houseUnit;

    public Event() {
	}
    
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public enum Type { heartBeat, updateValue, updateName, updateLocation; }
	@ApiProperty(value = "Type", allowableValues = "heartBeat, updateValue, updateName, updateLocation" )
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public enum Status { received, queued, redirected, archived, error; }
	@ApiProperty(value = "Status", allowableValues = "received, queued, redirected, archived, error")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Long getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Long timestamp) {
		this.timestamp = timestamp;
	}

	public HouseUnit getHouseUnit() {
	    return houseUnit;
	}

	public void setHouseUnit(HouseUnit param) {
	    this.houseUnit = param;
	}



}