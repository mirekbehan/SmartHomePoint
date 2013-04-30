package com.smarthomepoint.resource;

import java.util.List;

import com.wordnik.swagger.annotations.*;
import com.smarthomepoint.logic.HouseResolver;
import com.smarthomepoint.model.Element;
import com.smarthomepoint.model.HouseUnit;
import com.smarthomepoint.exception.NotFoundException;

import javax.ws.rs.core.Response;
import javax.ws.rs.*;


@Path("/element.json")
@Api(value="/element" , description = "Operations with elements")
@Produces({"application/json"})
public class ElementResource {

	static JavaRestResourceUtil ru = new JavaRestResourceUtil();

	@GET
	@ApiOperation(value = "Find all elements in system", responseClass = "com.smarthomepoint.model.Element")
		@ApiErrors(value = { @ApiError(code = 404, reason = "Elements not found") })
	public Response getelements() throws NotFoundException {
		List<Element> values = HouseResolver.findAllElements();
		if (null != values) {
			return Response.ok().entity(values).build();
		} else {
			throw new NotFoundException(404, "Elements not found");
		}
	}

	@POST
	@ApiOperation(value = "Create new element at house", responseClass = "com.smarthomepoint.model.element")
	@ApiErrors({ @ApiError(code = 400, reason = "Invalid element") })
	public Response createElement(@ApiParam(value = "Element to add into system", required = true) 
				Element value) {
		
		//HouseResolver.addElement(value);
		
		return Response.ok().entity("").build();
	}
	
	@GET
	@Path("/{id}")
	@ApiOperation(value = "Find element by ID", notes = "For valid response try integer IDs in range <1;255>. "
			+ "Other values will generated exceptions", responseClass = "com.smarthomepoint.model.element")
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid ID supplied"),
			@ApiError(code = 404, reason = "Element not found") })
	public Response getElementById(
			@ApiParam(value = "ID of element that needs to be fetched", allowableValues = "range[1,255]", required = true) 
			@PathParam("id") String id)
			throws NotFoundException {

		Element value = null; //HouseResolver.findelementById(ru.getLong(0, 255, 0, id));
		
		if (null != value) {
			return Response.ok().entity(value).build();
		} else {
			throw new NotFoundException(404, "element not found");
		}
	}

	@PUT
	@Path("/{id}")
	@ApiOperation(value = "Update element by ID", notes = "For valid response try integer IDs with value <  255. "
			+ "Anything above 255 or nonintegers will generate API errors")
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid ID supplied"),
			@ApiError(code = 404, reason = "element not found") })
	public Response updateElement(
			@ApiParam(value = "ID of the element that needs to be deleted", allowableValues = "range[1,255]", required = true) 
			@PathParam("orderId") String id) {
		
		//HouseResolver.removeElementById(ru.getLong(0, 255, 0, id));
		
		return Response.ok().entity("").build();
	}

	
	@DELETE
	@Path("/{id}")
	@ApiOperation(value = "Delete element by ID", notes = "For valid response try integer IDs with value <  255. "
			+ "Anything above 255 or nonintegers will generate API errors")
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid ID supplied"),
			@ApiError(code = 404, reason = "element not found") })
	public Response deleteelement(
			@ApiParam(value = "ID of the element that needs to be deleted", allowableValues = "range[1,255]", required = true) 
			@PathParam("orderId") String id) {
		
//		HouseResolver.removeElementById(ru.getLong(0, 255, 0, id));
		
		return Response.ok().entity("").build();
	}
	

	
	
	
}
