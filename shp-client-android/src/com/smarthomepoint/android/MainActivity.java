package com.smarthomepoint.android;

import android.app.Activity;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.view.Window;


public class MainActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		load();
		
		setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		board = new BoardView(getApplicationContext());
		setContentView(board);
		
	}

	BoardView board;
	

	@Override
 	protected void onResume() {
		board.invalidate();
		super.onResume();
	}
	
 	public void load() {
		//Model.getInstance().setCustomizeAll((CategoryGroup) Storage.getPersist(getApplicationContext(), "settings"));
	}
	
 	public void save() {
		//Storage.setPersist(getApplicationContext(), "settings", Model.getInstance().getCustomizeAll());
	}
	
	@Override
 	public void onBackPressed() {
		finish();
	}
	
	@Override
	protected void onDestroy() {
		save();
		super.onDestroy();
	}
	
	
}
