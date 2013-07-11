package com.smarthomepoint.android;

import java.util.Date;
import java.util.logging.Logger;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

public class MotionReceiver implements SensorEventListener {

	static private final Logger logger = Logger.getLogger("");

	static MotionReceiver instance;
 	static public MotionReceiver getInstance(Context context) {
		if (instance==null) instance =  new MotionReceiver(context);
		return instance;
	}

	Context context;
	SensorManager manager;
	
	public MotionReceiver(Context context) {
		this.context = context;
		manager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
	}
    
	private IListener listener;
	public void register(IListener listener) {
		this.listener = listener;
	}

	private Sensor sensor;
	
	long timeMark;
	public void start() {
		sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
		manager.registerListener(this, sensor, 100);
		logger.info("Motion receiver registered");
		timeMark= new Date().getTime();
	}
	public boolean isRunning() {
		return new Date().getTime() < timeMark - 2000;
	}
 	public void stop() {
		manager.unregisterListener(this, sensor);
	}
 	

 	float[] values = new float[3];
 	private final float NOISEL = (float) 2.0;
 	private final float NOISER = (float) -2.0;
 	
	public void onSensorChanged(SensorEvent event) {
		timeMark = new Date().getTime();

		if (values[0] - event.values[0] > NOISEL) {
			logger.info("direction left");
		}
		if (values[0] - event.values[0] < NOISER) {
			logger.info("direction right");
		}
		if (values[1] - event.values[1] > NOISEL) {
			logger.info("direction up");
		}
		if (values[1] - event.values[1] < NOISER) {
			logger.info("direction down");
		}
		if (values[2] - event.values[2] > NOISEL) {
			logger.info("direction front");
		}
		if (values[2] - event.values[2] < NOISER) {
			logger.info("direction back");
		}
		
 		values[0] = event.values[0];
 		values[1] = event.values[1];
 		values[2] = event.values[2];

/*		
		
 		float deltaX = values[0] - event.values[0]);
 		float deltaY = Math.abs(values[1] - event.values[1]);
 		float deltaZ = Math.abs(values[2] - event.values[2]);
 		if (deltaX < NOISE) deltaX = (float)0.0;
 		if (deltaY < NOISE) deltaY = (float)0.0;
 		if (deltaZ < NOISE) deltaZ = (float)0.0;
*/
		if (listener!=null) {
		
				//listener.onReceive(event);
		}
	}
	public void onAccuracyChanged(Sensor sensor, int accuracy) {
	}
	

	
}
