package com.smarthomepoint.resource;

import com.wordnik.swagger.annotations.*;
import com.smarthomepoint.logic.CommandResolver;
import com.smarthomepoint.logic.HouseResolver;
import com.smarthomepoint.model.Command;
import com.smarthomepoint.model.Sensor;
import com.smarthomepoint.model.User;
import com.smarthomepoint.util.JavaRestResourceUtil;
import com.smarthomepoint.exception.NotFoundException;

import javax.ws.rs.core.Response;
import javax.ws.rs.*;

@Path("/command.json")
@Api(value="/command" , description = "Command for SmartHomePoint")
@Produces({"application/json"})
public class CommandResource {
	
	static JavaRestResourceUtil ru = new JavaRestResourceUtil();

	@GET
	@Path("/{id}")
	@ApiOperation(value = "Find command by ID", notes = "Returns a command. Nonintegers will simulate " +
			"API error conditions", responseClass = "com.smarthomepoint.model.Command")
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid ID supplied"),
			@ApiError(code = 404, reason = "Command not found") })
	public Response getCommandById(
			@ApiParam(value = "ID of command that needs to be fetched", allowableValues = "range[1,255]", 
			required = true) @PathParam("id") String id) throws NotFoundException {
		Command value = CommandResolver.findById(ru.getLong(0, 100000, 0, id));
		if (null != value) {
			return Response.ok().entity(value).build();
		} else {
			throw new NotFoundException(404, "Command not found");
		}
	}

	@POST
	@ApiOperation(value = "Execute new Command")
	@ApiErrors(value = { @ApiError(code = 405, reason = "Invalid input") })
	public Response executeCommand(
			@ApiParam(value = "Command object that needs to be executed", required = true) Command value) {
		CommandResolver.add(value);
		// TODO execution
		return Response.ok().entity("SUCCESS").build();
	}

	@PUT
	@ApiOperation(value = "Update an existing command")
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid ID supplied"),
			@ApiError(code = 404, reason = "Command not found"),
			@ApiError(code = 405, reason = "Validation exception") })
	public Response updateCommand(
			@ApiParam(value = "Command object that needs to be reexucuted with different values", required = true) Command value) {
		CommandResolver.update(value);
		return Response.ok().entity("SUCCESS").build();
	}

	@GET
	@Path("/findByStatus")
	@ApiOperation(value = "Finds Commands by status", notes = "Multiple status values can be provided with comma seperated strings", 
	responseClass = "com.smarthomepoint.model.Command", multiValueResponse = true)
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid status value") })
	public Response findCommandsByStatus(
			@ApiParam(value = "Status values that need to be considered for filter", required = true, defaultValue = "available", 
			allowableValues = "available,pending,sold", allowMultiple = true) @QueryParam("status") String status) {
		return Response.ok(CommandResolver.findByStatus(status)).build();
	}

	@GET
	@Path("/findByUser")
	@ApiOperation(value = "Finds Commands by user", notes = "User can be provided with id only.", 
	responseClass = "com.smarthomepoint.model.User", multiValueResponse = true)
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid tag value") })
	public Response findCommandsByUser(
			@ApiParam(value = "Commands to filter by", required = true, allowMultiple = true) 
			@QueryParam("users") User user) {
		return Response.ok(CommandResolver.findByUser(user)).build();
	}
}
