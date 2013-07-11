package com.smarthomepoint.android;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import android.content.Context;


public class Storage implements Serializable  {
	private static final long serialVersionUID = -529057421067769017L;
	private static final String DEFAULT_FILENAME = "settings.sav";
	private static final Logger logger = Logger.getLogger("");
	
	private static Storage instance;
	public static Storage getInstance() {
		if (instance==null) {
			instance = new Storage();
		}
		return instance;
	}

   	private Storage() {
	}
   	
	private Map<String, Object> persitent;
	
	static public void setPersist(Context context, String name, Object obj) {
		if (!isLoaded) load(context);
		if (getInstance().persitent==null) getInstance().persitent = new HashMap<String, Object>();
		getInstance().persitent.put(name, obj);
		save(context);
	}
	
	static public Object getPersist(Context context, String name) {
		if (!isLoaded) load(context);
		if (getInstance().persitent!=null) return getInstance().persitent.get(name);
		return null;
	}


	public static boolean isLoaded = false;
	
	public static void load(Context context)  {
		instance = (Storage) load(context, DEFAULT_FILENAME); 
	}
	
 	public static Object  load(Context context, String name)  {
		Object out = null;
		if (context == null) throw new  NullPointerException();
		try {
			FileInputStream fis = context.openFileInput(name);
			ObjectInputStream ois = new ObjectInputStream(fis);
			out = ois.readObject();
			logger.info("Object loaded from file :" + name + " size:" + new File(name).length());
			ois.close();
			isLoaded = true;
		} catch (Exception e) {
			logger.severe(e.getMessage());
			context.deleteFile(name);
			instance = null;
		}
		return out;
	}

	public static void save(Context context) {
		save(context, DEFAULT_FILENAME, getInstance());
	}

	public static void save(Context context, String name, Object value) {
		if (context ==null ) throw new NullPointerException();
		try {
			FileOutputStream fos = context.openFileOutput(name, Context.MODE_PRIVATE);
			ObjectOutputStream oos = new ObjectOutputStream(fos);
			oos.writeObject(value);
			logger.info("Object stored into file:" + name);
			oos.close();
		} catch (FileNotFoundException e) {
			logger.severe("file not found" + e.getMessage());
		} catch (IOException e) {
			logger.severe("IO exception " + e.getMessage());
		} 
	}

	public static void delete(Context context, String name)  {
		if (context == null) throw new  NullPointerException();
		try {
			context.deleteFile(name);
		} catch (Exception e) {
			logger.severe(e.getMessage());
		}
	}

	
	

}
