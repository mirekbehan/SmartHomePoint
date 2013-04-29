package com.smarthomepoint.model;

import javax.persistence.MappedSuperclass;
import javax.persistence.OneToOne;
import javax.xml.bind.annotation.XmlRootElement;

import com.wordnik.swagger.annotations.ApiProperty;

@MappedSuperclass
public class Unit {
	
	
	private String description;
	private String status;
	private String valueRange;
	private String valueVolume;
	private String valueType;
	@OneToOne
	private Category category;
	public Unit() {
	}

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
	@ApiProperty(value = "status of sensor", allowableValues = "planing, testing, available, warning, error")
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
}
