package com.smarthomepoint.android;

import java.util.HashMap;
import java.util.Map;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.view.MotionEvent;

import com.smarthomepoint.android.Model.Category;

public class MenuZone extends WidgetView {
	

	
 	public MenuZone() {
	}

 	
 	public void calcSubCategories(int x, int y, Category category) {
		int count = category.subCategories.size();
		int i = 0;
		for (Category subCat: category.subCategories) {
 			int degrees = 200 / count;
 			int dx = (int) (sizePointerXY * 2 * Math.cos(Math.toRadians(-90 +degrees * i)));
 			int dy = (int) (sizePointerXY * 2 * Math.sin(Math.toRadians(-90 + degrees * i)));
 			Rect submenu = new Rect(x + dx - sizePointerXY/2, y + dy - sizePointerXY/2, 
 								x + dx + sizePointerXY/2, y + dy + sizePointerXY/2);
			activeZone.put(subCat, submenu);
			i++;
			calcSubCategories(x + dx, y + dy, subCat);
		}
 	}
 	
	
 	public void measure(Rect rect) {
 		super.measure(rect);

 		sizePointerXY = (rect.height() + rect.width())/20;
 		
 		paintPointer 	= Graphics.getPaintFull(Color.WHITE);
 		paintText 		= Graphics.getTextPaint(sizePointerXY/2);

 		current = main;
 		rectCategoryStart = new Rect(0, back.centerY()-sizePointerXY/2 , sizePointerXY, back.centerY() + sizePointerXY/2);
 		calcSubCategories(sizePointerXY,back.centerY(), current);

 		
	}
	
 	Paint paintPointer, paintText;
 	
 	int sizePointerXY;
 	
 	public void draw(Canvas canvas) {
 		super.draw(canvas);
 		
 		
 		if (!showMenu) {
 	 		canvas.drawCircle(rectCategoryStart.centerX(), rectCategoryStart.centerY(), sizePointerXY, paintPointer);
 			canvas.drawText(current.title, rectCategoryStart.centerX() , rectCategoryStart.centerY() , paintText);
 		} else {
	 		for (Category category : current.subCategories) {
	 			int x = activeZone.get(category).centerX();
	 			int y = activeZone.get(category).centerY();
	 			canvas.drawCircle(x, y, sizePointerXY, paintPointer);
	 			canvas.drawText(category.title, x, y, paintText);
	 		}
		}
 		

	}

 	boolean showMenu, isTouchDown;
 	Rect rectCategoryStart;
 	
 	Category main = new Model().main;
 	Category current;
 	
 	Map<Category, Rect> activeZone = new HashMap<Category, Rect>();
 	
 	
	public boolean touchEvent(MotionEvent event) {
		super.touchEvent(event);

		if (event.getAction() == MotionEvent.ACTION_MOVE 
				//&& ( Math.abs(event.getX() - pointerX) > 10 || Math.abs(event.getY() - pointerY) > 10  )
				)  {
			for (Category category : activeZone.keySet()) {
				if (activeZone.get(category).contains(pointerX, pointerY)) {
					if (current!= category && current.subCategories.contains(category)) { 
						current = category;
						return true;
					}
				}
			}
			//super.touchEvent(event);
		}

		if (event.getAction() == MotionEvent.ACTION_DOWN && rectCategoryStart.contains((int)event.getX(), (int)event.getY())) {
			showMenu = true;
			current = main;
			return true;
		}
		
		
		if (event.getAction() == MotionEvent.ACTION_UP) {
			showMenu = false;
			current = main;
			//super.touchEvent(event);
			return true;
		}
		
		
		return false;
	}
	

	
 	
	
	
	
}
