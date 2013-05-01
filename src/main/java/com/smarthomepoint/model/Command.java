package com.smarthomepoint.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.wordnik.swagger.annotations.ApiProperty;

@Entity
@XmlRootElement
public class Command {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	private String type;
	private String value;
	@Temporal(TemporalType.DATE)
	private Date date;
	private Long timestamp;
	private String status;
	@OneToOne(targetEntity=User.class)
	private User user;
    private boolean complete;
	@OneToOne
	private Unit unit;

    public Command() {
	}
    
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@ApiProperty(value = "CommandType", allowableValues = "startUp, shutdown, restart, " +
			"lightOn, lightOff, lightValueRGB, lightValueR, lightValueG, lightValueB, lightValueIntensity," +
			"heatOn, heatOff, heatValueTemperature, " +
			"airOn, airOff, airValue, " +
			"windowOpen, windowClose, windowValue," +
			"doorOpen, doorClose, doorLock" )
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

	
    public boolean isComplete() {
        return complete;
    }

    public void setComplete(boolean complete) {
        this.complete = complete;
    }


	@ApiProperty(value = "Command Status", allowableValues = "queued, approved, archived, error")
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Unit getUnit() {
	    return unit;
	}

	public void setUnit(Unit param) {
	    this.unit = param;
	}



}