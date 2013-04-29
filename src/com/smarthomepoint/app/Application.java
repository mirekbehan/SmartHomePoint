package com.smarthomepoint.app;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.persistence.Persistence;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import org.apache.commons.io.IOUtils;

import com.smarthomepoint.logic.HouseResolver;
import com.smarthomepoint.logic.UserResolver;

//@WebServlet(urlPatterns="/*", loadOnStartup=1)
public class Application extends HttpServlet {

	public static final String PERSISTENCE_UNIT = "db";
	
	static {
		EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT).createEntityManager();
		if (em!=null && em.getMetamodel() !=null && em.getMetamodel().getEntities() !=null ) {
		
				//em.createQuery(IOUtils.toString(Application.class.getResourceAsStream("createDDL.sql")));
				UserResolver.createDefaultData();
				HouseResolver.createDefaultData();
			
		}
	}
	
	
	
}
