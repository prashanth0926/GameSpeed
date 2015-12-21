package com.ajax;

public class Composer {

    private String id;
    private String productName;
    private String category;
    private String url;
    
    
    public Composer (String id, String productName, String category, String url) {
        this.id = id;
        this.productName = productName;
        this.category = category;
        this.url = url;
    }

    public String getCategory() {
        return category;
    }
    
    public String getId() {
        return id;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public String getUrl() {
        return url;
    }
}