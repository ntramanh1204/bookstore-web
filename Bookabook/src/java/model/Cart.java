/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import model.Product;

/**
 *
 * @author DELL
 */
public class Cart {
    private int id;
    private String username;
    private Product product;
    private int quantity;

    public Cart(int id, String username, Product product, int quantity) {
        this.id = id;
        this.username = username;
        this.product = product;
        this.quantity = quantity;
    }

    public Cart() {
    }
    
    

//    public double getTotal(){
//        return this.quantity * this.product.price;
//    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Cart{" + "id=" + id + ", username=" + username + ", product=" + product + ", quantity=" + quantity + '}';
    }
    
    
}
