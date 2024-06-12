/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.Product;

/**
 *
 * @author ADMIN
 */
public class OrderDetailDAO extends DBContext {

    public void insertOrderDetail(int orderId, String productId, int quantity) {
        try {
            String sql = "insert into orderdetails (orderId, productId, quantity) values(" + orderId + ", '" + productId + "', " + quantity + ")";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<OrderDetail> getOrderDetailById(int orderId) {
        ProductDAO pdao = new ProductDAO();
        OrderDAO odao = new OrderDAO();
        List<OrderDetail> list = new ArrayList<>();
        String sql = "select * from OrderDetails where orderId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                Order o = odao.getOrderById(orderId);
                Product p = pdao.getProductById(rs.getString("productId"));
                int quantity = rs.getInt("quantity");
                OrderDetail orderDetail = new OrderDetail(id, o, p, quantity);
                list.add(orderDetail);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public double getOrderTotal(int orderId) {
        String sql = "SELECT od.orderId, SUM(p.price * od.quantity) AS totalValue\n"
                + "FROM OrderDetails od\n"
                + "JOIN Products p ON od.productId = p.id\n"
                + "WHERE od.orderId = ?\n"
                + "GROUP BY od.orderId;";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalValue");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public static void main(String[] args) {
        OrderDetailDAO orderDetailDao = new OrderDetailDAO();
//        orderDetailDao.insertOrderDetail(1, "18460392" , 4);
//        List<OrderDetail> list = orderDetailDao.getOrderDetailById(1);
//        for (OrderDetail orderDetail : list) {
//            System.out.println(orderDetail.toString());
//        }

        System.out.println(orderDetailDao.getOrderTotal(1));
    }
}
