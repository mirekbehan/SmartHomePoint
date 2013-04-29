package com.smarthomepoint.logic;

import com.smarthomepoint.model.*;

import java.util.List;
import java.util.ArrayList;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class UserResolver {

	static EntityManagerFactory emf = Persistence.createEntityManagerFactory("db");

	
	static public void createDefaultData() {
		createUser(1, "admin", "Mirek", "Behan", "mirek.behan@gmail.com", "+420731479654", 2, 1);
		createUser(2, "major", "first name 2", "last name 2", "email2@test.com", "123-456-7890", 2, 2);
		createUser(3, "wife", "first name 3", "last name 3",  "email3@test.com", "123-456-7890", 2, 3);
		createUser(4, "friend", "first name 4", "last name 4", "email4@test.com", "123-456-7890", 2, 4);
		createUser(5, "visitor", "first name 5", "last name 5", "email5@test.com", "123-456-7890", 2, 4);
	}
	
	static public boolean existsUser(User user) {
		EntityManager em = emf.createEntityManager();
		User result =em.find(User.class, user.getId());
		em.close();
		return result == null ? false : true;
	}
	
	static public void addUser(User user) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.persist(user);
		em.getTransaction().commit();
		em.close();
	}

	static public User findUserById(long id) {
		EntityManager em = emf.createEntityManager();
		User user = em.find(User.class, id);
		em.close();
		return user;
	}
	
	static public User findUserByUsername(String username) {
		EntityManager em = emf.createEntityManager();
		User user = em.createNamedQuery("findUserByUsername", User.class).getSingleResult();
		em.close();
		return user;
	}

	static public User findUserByKeyword(String keyword) {
		EntityManager em = emf.createEntityManager();
		User user = em.createNamedQuery("findUserByKeyword", User.class).getSingleResult();
		em.close();
		return user;
	}
	
	static public User findUserAll() {
		EntityManager em = emf.createEntityManager();
		User user = em.createNamedQuery("findAll", User.class).getSingleResult();
		em.close();
		return user;
	}
	
	static public void removeUser(String username) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.remove(findUserByUsername(username));
		em.getTransaction().commit();
		em.close();
	}
	
	static public void updateUser(User value) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.merge(value);
		em.getTransaction().commit();
		em.close();
	}
	
	static private User createUser(long id, String username, String firstName, 
			String lastName, String email, String phone, int userStatus, int userRole) {
		
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();

		User user = new User();
		user.setId(id);
		user.setUsername(username);
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setEmail(email);
		user.setPassword("pass");
		user.setPhone(phone);
		user.setUserStatus(userStatus);
		user.setUserRole(userRole);
		
		em.persist(user);
		em.getTransaction().commit();
		em.close();
		
		return user;
	}
}