package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Product;

public class CartDAO extends DBContext {

    public List<Cart> getCartDetailsByUsername(String username) {
        List<Cart> list = new ArrayList<>();
        try {
            String sql = "SELECT * from Cart where username = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Cart c = new Cart();
                c.setId(rs.getInt("id"));
                c.setUsername(username);
                ProductDAO pdb = new ProductDAO();
                Product p = pdb.getProductById(rs.getString("productId"));
                c.setProduct(p);
                c.setQuantity(rs.getInt("quantity"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void addProduct(String username, String productId, int quantity) {
        try {
            String sql = "insert into Cart([username],[productId],[quantity]) values (?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, productId);
            statement.setInt(3, quantity);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public double getCartTotal(String username) {
        String sql = "SELECT Round(SUM(p.price * c.quantity), 2) AS totalValue\n"
                + "from cart c join Products p on c.productId = p.id\n"
                + "where username = '" + username + "'";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalValue");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public void removeCartDetailByPid(String username, String id) {
        try {
            String sql = "delete from Cart where username = '" + username + "' AND  productId = '" + id + "'";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

//    public boolean updateCartDetailByProductId(String productId, int quantity) {
//        try {
//            String sql = "update Cart set quantity = ? "
//                    + "where productID = " + productId;
//            PreparedStatement statement = connection.prepareStatement(sql);
//            statement.setInt(1, quantity);
//            statement.executeUpdate();
//            return true;
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return false;
//    }
    
    
    public boolean updateCartDetailByProductId(String productId, int quantity) {
    try {
        String sql = "UPDATE Cart SET quantity = ? WHERE productId = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, quantity);
        statement.setString(2, productId);
        statement.executeUpdate();
        return true;
    } catch (SQLException e) {
        System.out.println(e);
    }
    return false;
}
    
    public void deleteCartByUsername(String username) {
        try {
            String sql = "delete from Cart\n "
                    + "where username = '" + username + "'";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public int itemsInCart(String username) {
        String sql = "select count(*) as totalItems from cart where username = '" + username + "'";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalItems");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }
    
    public static void main(String[] args) {
        CartDAO cartDao = new CartDAO();
        
         OrderDAO orderDao = new OrderDAO();
        OrderDetailDAO orderDetailDao = new OrderDetailDAO();
        
        String username = "tramanh";
        
        List<Cart> cart = cartDao.getCartDetailsByUsername("customer");
        for (Cart cart1 : cart) {
            System.out.println(cart1.toString());
        }
        
//        orderDao.insertOrder(username);
        
//        List<Cart> cart = (List<Cart>) session.getAttribute("cart");
//        for (Cart item : cart) {
//            orderDetailDao.insertOrderDetail(item.getId(), item.getProduct().getId() , item.getQuantity());
//        }
//        cartDao.deleteCartByUsername(username);
    }

}
