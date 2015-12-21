package com.ajax;

import java.util.HashMap;

public class ComposerData {
    
    private static int k = 19;
    private static String id = " ";
    
    private static HashMap composers = new HashMap();
    

    public HashMap getComposers() {
        return composers;
    }
    
    public ComposerData() {
        
        composers.put("1", new Composer("1", "XBOX One", "Product", "/microsoft.jsp"));
        composers.put("2", new Composer("2", "XBOX 360", "Product", "/microsoft.jsp"));
        composers.put("3", new Composer("3", "PS 3", "Product", "/sony.jsp"));
        composers.put("4", new Composer("4", "PS 4", "Product", "/sony.jsp"));
        composers.put("5", new Composer("5", "Wii", "Product", "/nintendo.jsp"));
        composers.put("6", new Composer("6", "Wii U", "Product", "/nintendo.jsp"));
        composers.put("7", new Composer("7", "FIFA 16", "Product", "/ea.jsp"));   
        composers.put("8", new Composer("8", "COD AW", "Product", "/activision.jsp"));
        composers.put("9", new Composer("9", "GTA V", "Product", "/ttint.jsp"));
        composers.put("10", new Composer("10", "SK", "Product", "/accessories.jsp"));
         composers.put("11", new Composer("11", "Sony", "Brand", "/sony.jsp")); 
	 composers.put("12", new Composer("12", "Microsoft", "Brand", "/microsoft.jsp"));
	 composers.put("13", new Composer("13", "Nintendo", "Brand", "/nintendo.jsp"));
	 composers.put("14", new Composer("14", "EA", "Brand", "/ea.jsp")); 
	 composers.put("15", new Composer("15", "Activision", "Brand", "/activision.jsp"));
	 composers.put("16", new Composer("16", "Take-Two Interactive", "Brand", "/ttint.jsp"));
	 composers.put("17", new Composer("17", "SkullCandy", "Accessory", "/accessories.jsp"));
	 composers.put("18", new Composer("18", "Accessories", "Accessory", "/accessories.jsp"));
	composers.put("19", new Composer("19", "Play Station", "brand", "/sony.jsp"));
    }
    
    public static void CD(String product, String category, String url) {
        k = k+1;
        id = ""+k+"";
        composers.put(id, new Composer(id, product, category, url));
    }

}
