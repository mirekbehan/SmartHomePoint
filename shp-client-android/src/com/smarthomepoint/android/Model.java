package com.smarthomepoint.android;
import java.util.ArrayList;
import java.util.List;

public class Model {

	
	public class Category {
		
		String title;
		List<Category> subCategories = new ArrayList<Model.Category>();
		
		public Category(String value) {
			title = value;
		}
		
		public void addCategory(Category category) {
			subCategories.add(category);
		}
		
		
		
		
	}

	
	
	
	
	
	public final Category main = new Category("Main") {{
		addCategory(new Category("TV") {{
					addCategory(new Category("Channels"));
					addCategory(new Category("Volume") {{
						addCategory(new Category("UP"));
						addCategory(new Category("DOWN"));
					}});
					addCategory(new Category("Brightness") {{ 
						addCategory(new Category("UP"));
						addCategory(new Category("DOWN"));
					}});
					addCategory(new Category("Contrast") {{
						addCategory(new Category("UP"));
						addCategory(new Category("DOWN"));
					}});
		}});
		addCategory(new Category("Social") {{
			addCategory(new Category("Facebook"));
			addCategory(new Category("G+"));
			addCategory(new Category("Twitter"));
			addCategory(new Category("..."));
		}});
		addCategory(new Category("Home") {{
			addCategory(new Category("Lights"));
			addCategory(new Category("Heat"));
			addCategory(new Category("Doors"));
			addCategory(new Category("..."));
		}});
		addCategory(new Category("Streams") {{
			addCategory(new Category("Live"));
			addCategory(new Category("Music"));
			addCategory(new Category("Movies"));
			addCategory(new Category("..."));
		}});

		
		
	}};
	
	
	
}
