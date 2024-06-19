package model;

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
        return "Cart{" + "id=" + id + ", username=" + username + ", product=" + product + ", quantity=" + quantity
                + '}';
    }

}
