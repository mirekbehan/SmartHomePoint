package com.smarthomepoint.logic;

import com.smarthomepoint.model.*;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class  CommandResolver {

	static EntityManagerFactory emf = Persistence.createEntityManagerFactory("db");
	static Class<Command> clazz = Command.class;
	
	static public <E extends Command> void add(E value) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.persist(value);
		em.getTransaction().commit();
		em.close();
	}
	static public <E extends Command> E findById(long id) {
		EntityManager em = emf.createEntityManager();
		@SuppressWarnings("unchecked")
		E value = (E) em.find(clazz, id);
		em.close();
		return value;
	}
	static public void removeById(long id) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.remove(findById(id));
		em.getTransaction().commit();
		em.close();
	}
	static public <E extends Command> void update(E value) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.merge(value);
		em.getTransaction().commit();
		em.close();
	}

	static public <E extends Command> E findByStatus(String statuses) {
		EntityManager em = emf.createEntityManager();

		// TODO
		
		em.close();
		return null;
	}
	static public <E extends Command> E findByUser(User user) {
		EntityManager em = emf.createEntityManager();

		em.close();
		return null;
	}
		
	
	
	
	
	
	
	
	
}