package com.smarthomepoint.android;

import java.util.HashMap;
import java.util.Map;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Rect;
import android.media.MediaPlayer;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;

public class BoardView extends View {

	public BoardView(Context context) {
		super(context);
		setSoundEffectsEnabled(true);
	}

	public BoardView(Context context, AttributeSet attrs) {
		super(context, attrs);
		setSoundEffectsEnabled(true);
	}


	Map<BasicView, Rect> views = new HashMap<BasicView, Rect>();
	
	
	int width, height;
	
	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
		super.onMeasure(widthMeasureSpec, heightMeasureSpec);
		width = MeasureSpec.getSize(widthMeasureSpec);
		height = MeasureSpec.getSize(heightMeasureSpec);;
		//int d = w == 0 ? h : h == 0 ? w : w < h ? w : h;
		
		int unitSizeX = width / 2;

		views.clear();
		views.put(new MenuZone(), 	new Rect(unitSizeX * 0, 0, unitSizeX * 1 , height));
		views.put(new TouchMouseZone(), 	new Rect(unitSizeX * 1, 0, width, height));
		
		
		for (BasicView view : views.keySet()) {
			view.measure(views.get(view));
		}		

		
		setMeasuredDimension(width, height);
		
		background= BitmapFactory.decodeResource(getContext().getResources(), R.drawable.background_tile);
	}
	
	Bitmap background; 

 
	
	@Override
	protected void onDraw(Canvas canvas) {
		canvas.drawColor(Color.BLACK);
		drawBackground(canvas);
		//canvas.drawRect(0, 0, width, height, Graphics.getPaintLine());
		
		for (BasicView view : views.keySet()) {
			view.draw(canvas);
		}		
		
	}

	private void drawBackground(Canvas canvas) {
		int	left = 0, top = 0;
		int bgTileWidth = 30;//background.getWidth();
		int bgTileHeight = 14;//background.getWidth();

		while (left < width) {
		    while (top < height) {
		        canvas.drawBitmap(background, null, new Rect(left, top, left+bgTileWidth, top + bgTileHeight), null);
		        top += bgTileHeight;
		    }
		    left += bgTileWidth;
		    top = 0;
		}
	}
	
	int lastX, lastY;
	
	@Override
	public boolean onTouchEvent(MotionEvent event) {
		int x = (int) event.getX();
		int y = (int) event.getY();
		
		boolean touched = false;
		for (BasicView view : views.keySet()) {
			if (view.touchEvent(event)) touched = true;
		}
		if (touched && event.getAction() == MotionEvent.ACTION_DOWN) {
			if (soundOn) playSound();
		}

		if (touched && event.getAction() == MotionEvent.ACTION_MOVE) {
			if (soundOn) playSound();
		}

		if (touched) invalidate();


/*		if (event.getAction() == MotionEvent.ACTION_DOWN) {
			if ((lastX*lastX - x*x + lastY * lastY - y*y) > 10) {
				invalidate();
			}
		}
*/
		
		return true;
	}

	boolean soundOn = true;
	MediaPlayer mp = MediaPlayer.create(getContext(), R.raw.button_50);
	public void playSound() {
		//playSoundEffect(SoundEffectConstants.CLICK);
		//sme.playSound();
		//sme.vibrate();
	    mp.start();
		//AudioManager audioManager = (AudioManager) getContext().getSystemService(Context.AUDIO_SERVICE);
		//audioManager.playSoundEffect(AudioManager.FX_KEY_CLICK);   
	}
	
	
	
}
