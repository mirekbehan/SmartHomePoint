package com.smarthomepoint.android;

import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.Align;
import android.graphics.Paint.Style;

public class Graphics {

	
	static private Paint paintText;
	static public Paint getTextPaint(float size) {
		Paint paint = new Paint(getTextPaint());
		paint.setTextSize(size);
		return paint;
	}
	
	static public Paint getTextPaint() {
		if (paintText == null) {
			paintText = new Paint();
			paintText.setTextSize(10);
			paintText.setColor(Color.WHITE);
			paintText.setTextAlign(Align.CENTER);
		}
		return paintText;
	}
	static private Paint paintTextBack;
	static public Paint getTextPaintBack() {
		if (paintTextBack == null) {
			paintTextBack = new Paint();
			paintTextBack.setColor(Color.DKGRAY);
			paintTextBack.setStyle(Style.FILL);
		}
		return paintTextBack;
	}
	static private Paint paintTitleText;
	static public Paint getTitlePaint() {
		if (paintTitleText == null) {
			paintTitleText= new Paint();
			paintTitleText.setTextSize(30);
			paintTitleText.setColor(Color.WHITE);
			paintTitleText.setTextAlign(Align.CENTER);
		}
		return paintTitleText;
	}

	
	
 	static private Paint paintLine;
 	static public Paint getPaintLine() {
		if (paintLine == null) {
			paintLine = new Paint();
			paintLine.setColor(Color.WHITE);
			paintLine.setAntiAlias(true);
			paintLine.setDither(true);
			paintLine.setStyle(Paint.Style.STROKE);
			paintLine.setStrokeJoin(Paint.Join.ROUND);
			paintLine.setStrokeCap(Paint.Cap.ROUND);
			paintLine.setStrokeWidth(1);
		}
		return paintLine;
	}
	
 	
 	
 	
 	static Paint backPaint;
 	static public Paint getBackPaint() {
		if (backPaint==null) {
			backPaint = new Paint();
			backPaint.setColor(Color.WHITE);
			backPaint.setStyle(Style.STROKE);
			backPaint.setStrokeWidth(1);
		}
		return backPaint;
	}
	
 	static Paint frontPaint;
	static public Paint getFrontPaint() {
		if (frontPaint==null) {
			frontPaint = new Paint();
			frontPaint.setColor(Color.WHITE);
			frontPaint.setStyle(Style.FILL_AND_STROKE);
			frontPaint.setStrokeWidth(1);
		}
		return frontPaint;
	}
	


 	static private Paint paintFull;
 	static public Paint getPaintFull() {
		if (paintFull == null) {
			paintFull = new Paint();
			paintFull.setColor(Color.WHITE);
			paintFull.setAntiAlias(true);
			paintFull.setDither(true);
			paintFull.setStyle(Paint.Style.FILL);
			paintFull.setStrokeJoin(Paint.Join.ROUND);
			paintFull.setStrokeCap(Paint.Cap.ROUND);
			paintFull.setStrokeWidth(1);
		}
		return paintFull;
	}
 	static public Paint getPaintFull(int color) {
 		Paint paint = new Paint(getPaintFull());
 		paint.setColor(color);
		return paint;
	}
 	static public Paint getPaintFullDarkGreen() {
 		Paint paint = new Paint(getPaintFull());
		paint.setARGB(255, 0, 100, 0);
		return paint;
	}
 	
 	
	
 	/*	    mDrawable = new ShapeDrawable(new OvalShape());
    mDrawable.getPaint().setColor(0xff74AC23);
    mDrawable.setBounds(x, y, x + width, y + height);
*/

 	
 	
 	
}
