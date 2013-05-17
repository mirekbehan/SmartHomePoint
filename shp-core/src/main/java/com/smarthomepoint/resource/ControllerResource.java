package com.smarthomepoint.resource;

import java.util.List;

import com.wordnik.swagger.annotations.*;
import com.smarthomepoint.logic.HouseResolver;
import com.smarthomepoint.model.Controller;
import com.smarthomepoint.exception.NotFoundException;

import javax.ws.rs.core.Response;
import javax.ws.rs.*;


@Path("/controller.json")
@Api(value="/controller" , description = "Operations with controllers")
@Produces({"application/json"})
public class ControllerResource {

	static JavaRestResourceUtil ru = new JavaRestResourceUtil();

	@GET
	@ApiOperation(value = "Find all controller in the house", notes = "All controllers in the house. ", 
								responseClass = "com.smarthomepoint.model.Controller")
		@ApiErrors(value = { @ApiError(code = 404, reason = "Controller not found") })
	public Response getControllers() throws NotFoundException {
		List<Controller> values = HouseResolver.findAllControllers();
		if (null != values) {
			return Response.ok().entity(values).build();
		} else {
			throw new NotFoundException(404, "No Controllers not found");
		}
	}
	

/*	@POST
	@ApiOperation(value = "Create new controller at house", responseClass = "com.smarthomepoint.model.Controller")
	@ApiErrors({ @ApiError(code = 400, reason = "Invalid Controller") })
	public Response createController(
			@ApiParam(value = "controller to add into houseUnit", required = true) Controller value) {

		//HouseResolver.add;
		
		return Response.ok().entity("").build();
	}
*/	
	
	@GET
	@Path("/{id}")
	@ApiOperation(value = "Find controller by ID", notes = "For valid response try integer IDs in range <1;255>. "
			, responseClass = "com.smarthomepoint.model.Controller")
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid ID supplied"),
			@ApiError(code = 404, reason = "Controller not found") })
	public Response getRoomById(
			@ApiParam(value = "ID of controller that needs to be fetched", allowableValues = "range[1,255]", required = true) 
			@PathParam("id") String id)
			throws NotFoundException {
		
		Controller value = null; // HouseResolver.findRoomById(ru.getLong(0, 255, 0, id));
		
		
		if (null != value) {
			return Response.ok().entity(value).build();
		} else {
			throw new NotFoundException(404, "Controller not found");
		}
	}

/*	@DELETE
	@Path("/{id}")
	@ApiOperation(value = "Delete controller by ID", notes = "For valid response try integer IDs with value <  255. "
			+ "Anything above 255 or nonintegers will generate API errors")
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid ID supplied"),
			@ApiError(code = 404, reason = "Room not found") })
	public Response deleteRoom(
			@ApiParam(value = "ID of the room that needs to be deleted", allowableValues = "range[1,255]", required = true) 
			@PathParam("orderId") String id) {
		HouseResolver.removeRoomById(ru.getLong(0, 255, 0, id));
		return Response.ok().entity("").build();
	}
*/	

	
	
	
}
