package com.smarthomepoint.resource;

import com.wordnik.swagger.annotations.*;
import com.smarthomepoint.logic.UserResolver;
import com.smarthomepoint.model.User;
import com.smarthomepoint.exception.ApiException;
import com.smarthomepoint.exception.NotFoundException;


import javax.ws.rs.core.Response;
import javax.ws.rs.*;


@Path("/user.json")
@Api(value="/user", description = "Operations about user")
@Produces({"application/json"})
public class UserResource {

	
	@GET
	@ApiOperation(value = "Show all users", notes = "Without authorization ...")
	public Response showAllUsers() {
		return Response.ok().entity(UserResolver.findUserAll()).build();
	}
	
	
	@POST
	@ApiOperation(value = "Create user", notes = "This can only be done by the logged in user.")
	public Response createUser(
			@ApiParam(value = "Created user object", required = true) User user) {
		UserResolver.addUser(user);
		return Response.ok().entity("").build();
	}

    @POST
    @Path("/createWithArray")
    @ApiOperation(value = "Creates list of users with given input array")
    public Response createUsersWithArrayInput(@ApiParam(value = "List of user object", required = true) User[] users) {
        for (User user : users) {
        	UserResolver.addUser(user);
        }
        return Response.ok().entity("").build();
    }

    @POST
    @Path("/createWithList")
    @ApiOperation(value = "Creates list of users with given input array")
    public Response createUsersWithListInput(@ApiParam(value = "List of user object", required = true) java.util.List<User> users) {
        for (User user : users) {
        	UserResolver.addUser(user);
        }
        return Response.ok().entity("").build();
    }

	@PUT
	@Path("/{username}")
	@ApiOperation(value = "Updated user", notes = "This can only be done by the logged in user.")
	@ApiErrors(value = {
			@ApiError(code = 400, reason = "Invalid user supplied"),
			@ApiError(code = 404, reason = "User not found") })
	public Response updateUser(
			@ApiParam(value = "name that need to be deleted", required = true) @PathParam("username") String username,
			@ApiParam(value = "Updated user object", required = true) User user) {
		UserResolver.addUser(user);
		return Response.ok().entity("").build();
	}

	@DELETE
	@Path("/{username}")
	@ApiOperation(value = "Delete user", notes = "This can only be done by the logged in user.")
	@ApiErrors(value = {
			@ApiError(code = 400, reason = "Invalid username supplied"),
			@ApiError(code = 404, reason = "User not found") })
	public Response deleteUser(
			@ApiParam(value = "The name that needs to be deleted", required = true) @PathParam("username") String username) {
		UserResolver.removeUser(username);
		return Response.ok().entity("").build();
	}

	@GET
	@Path("/{username}")
	@ApiOperation(value = "Get user by username", responseClass = "com.smarthomepoint.model.User")
	@ApiErrors(value = {
			@ApiError(code = 400, reason = "Invalid username supplied"),
			@ApiError(code = 404, reason = "User not found") })
	public Response getUserByName(
			@ApiParam(value = "The username that needs to be fetched.", required = true) 
			@PathParam("username") String username)
		throws ApiException {
		User user = UserResolver.findUserByUsername(username);
		if (null != user) {
			return Response.ok().entity(user).build();
		} else {
			throw new NotFoundException(404, "User not found");
		}
	}

	@GET
	@Path("/findUserByKeyword/{keyword}")
	@ApiOperation(value = "Get user by keyword in username, first name or last name", responseClass = "com.smarthomepoint.model.User")
	@ApiErrors(value = {
			@ApiError(code = 400, reason = "Invalid username supplied"),
			@ApiError(code = 404, reason = "User not found") })
	public Response getUserByKeyword(
			@ApiParam(value = "Any keyword that identifies user which would be fetched. ", required = true) 
			@PathParam("keyword") String value)
		throws ApiException {
		User user = UserResolver.findUserByKeyword(value);
		if (null != user) {
			return Response.ok().entity(user).build();
		} else {
			throw new NotFoundException(404, "User not found");
		}
	}

	
	@GET
	@Path("/login")
	@ApiOperation(value = "Logs user into the system", responseClass = "string")
	@ApiErrors(value = { @ApiError(code = 400, reason = "Invalid username/password supplied") })
	public Response loginUser(
			@ApiParam(value = "The user name for login", required = true) @QueryParam("username") String username,
			@ApiParam(value = "The password for login in clear text", required = true) @QueryParam("password") String password) {
		return Response.ok()
				.entity("logged in user session:" + System.currentTimeMillis())
				.build();
	}

	@GET
	@Path("/logout")
	@ApiOperation(value = "Logs out current logged in user session")
	public Response logoutUser() {
		return Response.ok().entity("").build();
	}
}
