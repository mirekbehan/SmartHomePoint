package com.smarthomepoint.android;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.view.MotionEvent;

public class TouchMouseZone extends WidgetView {
	
	
 	public TouchMouseZone() {
	}

	
 	public void measure(Rect rect) {
 		super.measure(rect);

 		sizePointerXY = (rect.height() + rect.width())/2/20;
 		
 		paintPointer = Graphics.getPaintFull(Color.WHITE);
	}
	
 	Paint paintPointer;
 	
 	int sizePointerXY;
 	
 	int pointerX, pointerY;
	
 	public void draw(Canvas canvas) {
 		super.draw(canvas);
 		
 		if (showCursor) {
 			canvas.drawCircle(pointerX, pointerY, sizePointerXY, paintPointer);
 			
 		}
 		
 		
 		canvas.drawText("X: " + pointerX + ",Y:" + pointerY,  back.centerX(), Graphics.getTextPaint().descent(), Graphics.getTextPaint());
 		
	}

 	boolean showCursor = false;
 	
 	
	public boolean touchEvent(MotionEvent event) {
		super.touchEvent(event);
		
		if (back.contains(pointerX, pointerY)) {
			showCursor = true;
			return true;
		} 
		
		showCursor = false;
		return false;
	}
	

	
 	
	
	
	
}
