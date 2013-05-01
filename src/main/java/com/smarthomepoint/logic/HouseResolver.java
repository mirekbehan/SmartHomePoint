package com.smarthomepoint.logic;

import com.smarthomepoint.model.*;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;


public class HouseResolver {

	static EntityManagerFactory emf = Persistence.createEntityManagerFactory("db");

	
	static public void createDefaultData() {

		Location absoluteLocation = new Location(50.1, 70.5, 0.2);

		createCategory(1, "Light");
		createCategory(2, "Temperature");
		createCategory(3, "Humidy");

		createSensor(createElement(1, getCategoryById(1), "LightSensor",  "float", "0.01-7,000", "cd/m2")) ;
		createSensor(createElement(2, getCategoryById(1), "LightSensor",  "float", "0.01-7,000", "cd/m2")) ;
		createSensor(createElement(3, getCategoryById(1), "LightSensor",  "float", "0.01-7,000", "cd/m2")) ;
		createSensor(createElement(4, getCategoryById(2), "TemperatureSensor",  "byte", "-40-80", "C"));
		createSensor(createElement(5, getCategoryById(2), "TemperatureSensor",  "byte", "-40-80", "C"));
		createSensor(createElement(6, getCategoryById(2), "TemperatureSensor",  "byte", "-40-80", "C"));
		createSensor(createElement(7, getCategoryById(3), "HumiditySensor",  "byte", "0-100", "%"));
		createSensor(createElement(8, getCategoryById(3), "HumiditySensor",  "byte", "0-100", "%"));
		createSensor(createElement(9, getCategoryById(3), "HumiditySensor",  "byte", "0-100", "%"));
		
		createElement(1, getCategoryById(1), "LightOn", "boolean", "0", "On", Element.Type.executor.name());
		createElement(2, getCategoryById(1), "LightOff",  "boolean", "0", "Off", Element.Type.executor.name());
		createElement(3, getCategoryById(1), "LightIntensity",  "byte", "0-255", "On", Element.Type.executor.name());
		createElement(4, getCategoryById(1), "LightR",  "byte", "0-255", "RedColor", Element.Type.executor.name());
		createElement(5, getCategoryById(1), "LightG",  "byte", "0-255", "GreenColor", Element.Type.executor.name());
		createElement(6, getCategoryById(1), "LightB",  "byte", "0-255", "BlueColor", Element.Type.executor.name());
//		createExecutor(7, getCategoryById(2), "TemperatureOn",  Sensor.Status.testing.name(), "boolean");
//		createExecutor(8, getCategoryById(2), "TemperatureOff",  Sensor.Status.testing.name(), "boolean");
//		createExecutor(9, getCategoryById(2), "TemperatureCelsius",  Sensor.Status.testing.name(), "byte");
//		createExecutor(10, getCategoryById(2), "TemperatureFahrenheit",  Sensor.Status.testing.name(), "byte");
//		createExecutor(11, getCategoryById(3), "HumiditySensor",  Sensor.Status.testing.name());
//		createExecutor(12, getCategoryById(3), "HumiditySensor",  Sensor.Status.testing.name());
		
		
		createController(1, "Integrated Controller with RGB lights, Heat&Air Condition control", "10.0.0.1", 
				absoluteLocation, Controller.Status.testing.name(),
				//Arrays.asList(new Sensor[] { getSensorById(1), getSensorById(4), getSensorById(7)}) ,
				getElementsByCategory(getCategoryById(1))  );

		createController(2, "Integrated Controller with RGB lights, Heat&Air Condition control", "10.0.0.2", 
				absoluteLocation, Controller.Status.testing.name(),
				//Arrays.asList(new Sensor[] { getSensorById(2), getSensorById(5), getSensorById(8)}) ,
				getElementsByCategory(getCategoryById(1))  );

		createController(3, "Integrated Controller with RGB lights, Heat&Air Condition control", "10.0.0.3", 
				absoluteLocation, Controller.Status.testing.name(),
				//Arrays.asList(new Sensor[] { getSensorById(2), getSensorById(5), getSensorById(8)}) ,
				getElementsByCategory(getCategoryById(1))  );

		
		
//		createRoom(1, "MainKitchen", Arrays.asList(new Controller[] { getControllerById(1) }) , absoluteLocation ); 
//		createRoom(2, "MainLivingRoom", Arrays.asList(new Controller[] { getControllerById(2) }) , absoluteLocation ); 
//		createRoom(2, "MainHall", Arrays.asList(new Controller[] { getControllerById(3) }) , absoluteLocation ); 

	
	}
	
	static public void addRoom(Unit room) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.persist(room);
		em.getTransaction().commit();
		em.close();
	}

	static public Unit findRoomById(long id) {
		EntityManager em = emf.createEntityManager();
		Unit value = em.find(Unit.class, id);
		em.close();
		return value;
	}
	static public List<Unit> findAllRooms() {
		EntityManager em = emf.createEntityManager();
		List<Unit> value = em.createQuery("SELECT o FROM HouseUnit o WHERE o.type='room'", Unit.class)
				.getResultList();
		em.close();
		return value;
	}
	static public List<Controller> findAllControllers() {
		EntityManager em = emf.createEntityManager();
		List<Controller> value = em.createQuery("SELECT o FROM Controller o", Controller.class)
				.getResultList();
		em.close();
		return value;
	}
	static public List<Controller> findAllControllersByRoom(int id) {
		EntityManager em = emf.createEntityManager();
		List<Controller> value = em.createQuery("SELECT o FROM Controller o", Controller.class)
				.getResultList();
		em.close();
		return value;
	}

	static public List<Element> findAllElements() {
		EntityManager em = emf.createEntityManager();
		List<Element> value = em.createQuery("SELECT o FROM Element o", Element.class)
				.getResultList();
		em.close();
		return value;
	}
	static public List<Element> findAllElementsByRoom(long id) {
		EntityManager em = emf.createEntityManager();
		List<Element> value = em.createQuery("SELECT o FROM Element o", Element.class)
				.getResultList();
		em.close();
		return value;
	}

	static public void removeRoomById(long id) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.remove(findRoomById(id));
		em.getTransaction().commit();
		em.close();
	}
	static public void updateRoom(Unit value) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.merge(value);
		em.getTransaction().commit();
		em.close();
	}
	
	
	
	static public List<Category> getCategories() {
		EntityManager em = emf.createEntityManager();
		return em.createQuery("SELECT o FROM Category o", Category.class).getResultList();
	}
	static public Category getCategoryById(long id) {
		EntityManager em = emf.createEntityManager();
		return em.find(Category.class, id);
	}
	static public List<Sensor> getSensors() {
		EntityManager em = emf.createEntityManager();
		return em.createQuery("SELECT o FROM Element o WHERE o.type='sensor' ", Sensor.class).getResultList();
	}
	static public Sensor getSensorById(long id) {
		EntityManager em = emf.createEntityManager();
		return em.find(Sensor.class, id);
	}
	
	static public List<Element> getElements() {
		EntityManager em = emf.createEntityManager();
		return em.createQuery("SELECT o FROM Element o", Element.class).getResultList();
	}
	static public Element getExecutorById(long id) {
		EntityManager em = emf.createEntityManager();
		return em.find(Element.class, id);
	}
	static public List<Element> getElementsByCategory(Category category) {
		EntityManager em = emf.createEntityManager();
		return em.createQuery("SELECT e FROM Executor e WHERE e.category.id=:value", Element.class)
				.setParameter("value", category.getId()).getResultList();
	}
	static public List<Controller> getControllers() {
		EntityManager em = emf.createEntityManager();
		return em.createQuery("SELECT o FROM Controller o", Controller.class).getResultList();
	}
	static public Controller getControllerById(long id) {
		EntityManager em = emf.createEntityManager();
		return em.find(Controller.class, id);
	}

	
	
	static public void setUnitStatus(long id, String status) {
		
	}
	
	
	
	
	
	
	static private Category createCategory(long id, String name) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();

		Category value = new Category();
		value.setId(id);
		value.setName(name);
		
		em.persist(value);
		em.getTransaction().commit();
		em.close();
		return value;
	}
	

	static private Element createElement(long id, Category category, String description,
			String valueType, String valueRange, String valueVolume) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();

		Element value = new Element();
		value.setId(id);
		value.setCategory(category);
		value.setDescription(description);
		value.setStatus(Sensor.Status.testing.name());
		value.setValueType(valueType);
		value.setValueRange(valueRange);
		value.setValueVolume(valueVolume);
		
		em.persist(value);
		em.getTransaction().commit();
		em.close();
		return value;
	}
	static private Element createElement(int id, Category category, String description,
			String valueType, String valueRange, String valueVolume, String type) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();

		Element value = createElement(id, category, description, valueType, valueRange, valueVolume);
		value.setType(type);
		em.persist(value);
		em.getTransaction().commit();
		em.close();
		return value;
	}


	static private Sensor createSensor(Element element) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();

		Sensor value = (Sensor) element;
		value.setType(Element.Type.sensor.name());

		em.persist(value);
		em.getTransaction().commit();
		em.close();
		return value;
	}
	
	static private Controller createController(long id, String description, String ip, Location location, String status,
			 List<Element> elements) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();

		Controller value = new Controller();
		value.setId(id);
		value.setDescription(description);
		value.setIp(ip);
		value.setLocation(location);
		value.setStatus(status);
		value.setExecutors(elements);
		
		em.persist(value);
		em.getTransaction().commit();
		em.close();
		return value;
	}
	
	static private Unit createUnit(long id, String name, List<Controller> controllers, Location location) {
	
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();

		Unit value = new Unit();
		value.setId(id);
		value.setName(name);
		value.setControllers(controllers);
		value.setLocation(location);
		
		em.persist(value);
		em.getTransaction().commit();
		em.close();
		return value;
	}
	
	
	
	
	
	
	
	
	
}