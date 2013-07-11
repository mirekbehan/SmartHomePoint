package com.smarthomepoint.android;

import android.graphics.Canvas;
import android.graphics.Rect;
import android.view.MotionEvent;

public interface BasicView {

	public void measure(Rect rect);
	public void draw(Canvas canvas);
	public boolean touchEvent(MotionEvent event);
	
	
}
