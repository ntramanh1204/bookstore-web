/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package abundant;

import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.Product;

/**
 *
 * @author ADMIN
 */
public final class Cart {

    private List<Item> items;

    public Cart(List<Item> items) {
        this.items = items;
    }

    public Cart() {
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    private int getQuantityById(String id) {
        return getItemById(id).getQuantity();
    }

    private Item getItemById(String id) {
        for (Item item : items) {
            if (item.getProduct().getId().equals(id)) {
                return item;
            }
        }
        return null;
    }

    public void addItem(Item i) {
        if (getItemById(i.getProduct().getId()) != null) {
            Item m = getItemById(i.getProduct().getId());
            m.setQuantity(m.getQuantity() + i.getQuantity());
        } else {
            items.add(i);
        }
    }

    public void removeItem(String id) {
        if (getItemById(id) != null) {
            items.remove(getItemById(id));
        }
    }

    public double getTotalMoney() {
        double total = 0;
        for (Item item : items) {
            total += item.getQuantity();
        }
        return total;
    }

    private Product getProductById(String id, List<Product> list) {
        for (Product product : list) {
            if (product.getId().equals(id)) {
                return product;
            }
        }
        return null;
    }

    public Cart(String txt, List<Product> list) {
        items = new ArrayList<>();
        try {
            if (txt != null && txt.length() != 0) {
                String[] s = txt.split(",");
                for (String string : s) {
                    String[] n = string.split(":");
                    String id = n[0];
                    int quantity = Integer.parseInt(n[1]);
                    Product p = getProductById(id, list);
                    Item i = new Item(p, quantity, p.getPrice() * 2);
                    addItem(i);
                }
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

    }
}
