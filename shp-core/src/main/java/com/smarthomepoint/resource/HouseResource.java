package com.smarthomepoint.resource;

import java.util.List;

import com.wordnik.swagger.annotations.*;
import com.smarthomepoint.logic.HouseResolver;
import com.smarthomepoint.model.Controller;
import com.smarthomepoint.model.Element;
import com.smarthomepoint.model.Unit;
import com.smarthomepoint.exception.NotFoundException;

import javax.ws.rs.core.Response;
import javax.ws.rs.*;


@Path("/house.json")
@Api(value="/house" , description = "Operations with house")
@Produces({"application/json"})
public class HouseResource {

	static JavaRestResourceUtil ru = new JavaRestResourceUtil();

	@GET
	@Path("/room")
	@ApiOperation(value = "Find all rooms in house", notes = "All rooms in the house. "
			+ "Other values will generated exceptions", responseClass = "com.smarthomepoint.model.Unit")
		@ApiErrors(value = { @ApiError(code = 404, reason = "Units not found") })
	public Response getUnits() throws NotFoundException {
		List<Unit> values = HouseResolver.findAllRooms();
		if (null != values) {
			return Response.ok().entity(values).build();
		} else {
			throw new NotFoundException(404, "Units not found");
		}
	}
	

	@POST
	@Path("/house")
	@ApiOperation(value = "Create new room at house", responseClass = "com.smarthomepoint.model.Unit")
	@ApiErrors({ @ApiError(code = 400, reason = "Invalid Unit") })
	public Response createRoom(
			@ApiParam(value = "room to add into house", required = true) Unit value) {
		HouseResolver.addRoom(value);
		return Response.ok().entity("").build();
	}
	
	@GET
	@Path("/room/{id}")
	@ApiOperation(value = "Find room by ID", notes = "For valid response try integer IDs in range <1;255>. "
			+ "Other values will generated exceptions", responseClass = "com.smarthomepoint.model.Unit")
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid ID supplied"),
			@ApiError(code = 404, reason = "Room not found") })
	public Response getRoomById(
			@ApiParam(value = "ID of room that needs to be fetched", allowableValues = "range[1,255]", required = true) 
			@PathParam("id") String id)
			throws NotFoundException {
		Unit order = HouseResolver.findRoomById(ru.getLong(0, 255, 0, id));
		if (null != order) {
			return Response.ok().entity(order).build();
		} else {
			throw new NotFoundException(404, "Room not found");
		}
	}

	@DELETE
	@Path("/room/{id}")
	@ApiOperation(value = "Delete room by ID", notes = "For valid response try integer IDs with value <  255. "
			+ "Anything above 255 or nonintegers will generate API errors")
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid ID supplied"),
			@ApiError(code = 404, reason = "Room not found") })
	public Response deleteRoom(
			@ApiParam(value = "ID of the room that needs to be deleted", allowableValues = "range[1,255]", required = true) 
			@PathParam("id") String id) {
		HouseResolver.removeRoomById(ru.getLong(0, 255, 0, id));
		return Response.ok().entity("").build();
	}
	

	
	
	@GET
	@Path("/room/{id}/controller")
	@ApiOperation(value = "Find all controller in the house room", notes = "All controllers in the house room. ", 
								responseClass = "com.smarthomepoint.model.Controller")
		@ApiErrors(value = { @ApiError(code = 404, reason = "Controllers not found") })
	public Response getControllersByRoom(
			@ApiParam(value = "ID of the room that needs to be fetched", allowableValues = "range[1,255]", required = true) 
			@PathParam("id") String id) throws NotFoundException {
		List<Controller> values = HouseResolver.findAllControllersByRoom(ru.getInt(0, 255, 1, id));
		if (null != values) {
			return Response.ok().entity(values).build();
		} else {
			throw new NotFoundException(404, "No Controllers not found");
		}
	}

	
	@GET
	@Path("/room/{id}/element")
	@ApiOperation(value = "Find elements in room", responseClass = "com.smarthomepoint.model.Element")
	@ApiErrors(value = { @ApiError(code = 404, reason = "Elements not found") })
	public Response getElementsByRoom(
			@ApiParam(value = "ID of room that needs to be fetched", allowableValues = "range[1,255]", required = true) 
			@PathParam("id") String id) throws NotFoundException {
		List<Element> values = HouseResolver.findAllElementsByRoom(ru.getInt(0, 255, 0, id));
		
		if (null != values) {
			return Response.ok().entity(values).build();
		} else {
			throw new NotFoundException(404, "Elements not found");
		}
	}
	
	
	
}
