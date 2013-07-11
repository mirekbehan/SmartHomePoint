package com.smarthomepoint.android;

import android.graphics.Canvas;
import android.graphics.Rect;
import android.view.MotionEvent;

public class WidgetView implements BasicView {
	
	
	public WidgetView() {
	}

	int padding = 2;
	
	Rect back;
 	public void measure(Rect rect) {
		//this.rect = rect;
 		this.back = new Rect(rect.left + padding, rect.top + padding, rect.right - padding, rect.bottom - padding);
	}
	
	
 	public void draw(Canvas canvas) {
		if (back ==null) {
			throw(new RuntimeException("No rectangle defined"));
		}
	}

 	boolean showOptions = false;
 	
 	
 	int pointerX, pointerY;
 	
	public boolean touchEvent(MotionEvent event) {
		pointerX = (int) event.getX();
		pointerY = (int) event.getY();
		return false;
	}
	

	
 	
	
	
	
}
