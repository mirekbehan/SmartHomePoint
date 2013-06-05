package com.smarthomepoint.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.xml.bind.annotation.XmlRootElement;

import com.wordnik.swagger.annotations.ApiProperty;

@Entity
@XmlRootElement
public class Element {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	public Element() {
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	private String type;
	private String description;
	private String status;
	private String valueRange;
	private String valueVolume;
	private String valueType;
	@OneToOne
	private Category category;

	
	
	public String getValueRange() {
		return valueRange;
	}

	public void setValueRange(String valueRange) {
		this.valueRange = valueRange;
	}

	public String getValueVolume() {
		return valueVolume;
	}

	public void setValueVolume(String valueVolume) {
		this.valueVolume = valueVolume;
	}

	public String getValueType() {
		return valueType;
	}

	public void setValueType(String valueType) {
		this.valueType = valueType;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public enum Status { planing, testing, available, warning, error; }
	@ApiProperty(value = "status of element", allowableValues = "planing, testing, available, warning, error")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public enum Type { sensor, executor, monitor ; }
	@ApiProperty(value = "type of element", allowableValues = "sensor, executor, monitor")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	

}
