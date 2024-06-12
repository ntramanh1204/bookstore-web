package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Order;

public class OrderDAO extends DBContext {
    
    public void updateOrderStatus(String status, int orderId) {
        String sql = "UPDATE Orders SET status = ? WHERE id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, orderId);
            statement.executeUpdate();
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Order> getAllOrdersDesc() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY id DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order o = createOrdertFromResultSet(rs);
                list.add(o);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void insertOrder(int id, String username) {
        try {
            String sql = "INSERT INTO [dbo].[Orders]\n"
                    + "           ([id], [date] ,[username], [status])\n"
                    + "     VALUES (?, GETDATE() , ?, 'Waiting')";
            //java.sql.Date currentDate = new java.sql.Date(new Date().getTime());
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            statement.setString(2, username);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public double getOrderTotal(int orderId) {
        try {
            String sql = "SELECT od.orderId, SUM(od.quantity) AS total_quantity, \n"
                    + "  SUM(od.quantity * p.price) AS total_price\n"
                    + "FROM orderdetails od\n"
                    + "INNER JOIN products p ON od.productID = p.id\n"
                    + "where orderId = ?\n"
                    + "GROUP BY od.orderId;";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                double total = rs.getInt("total_price");
                return total;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;

    }

    public Order getOrderById(int orderId) {
        String sql = "select * from orders where orderId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Order o = createOrdertFromResultSet(rs);
                return o;
            }
        } catch (SQLException e) {

        }
        return null;
    }

    public List<Order> getOrderByUsername(String username) {
        List<Order> list = new ArrayList<>();

        try {
            String sql = "select * from Orders where username = '" + username + "' order by id desc";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Order o = createOrdertFromResultSet(rs);
                list.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getLastOrderId() {
        try {
            String sql = "SELECT MAX(ID) from Orders";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    private Order createOrdertFromResultSet(ResultSet rs) throws SQLException {
        AccountDAO adao = new AccountDAO();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Customize format as needed
        int id = rs.getInt("id");
        Account account = adao.getAccountByUsername(rs.getString("username"));
        String orderdate = sdf.format(rs.getDate("date"));
        String status = rs.getString("status");

        return new Order(id, account, orderdate, status);
    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
//        dao.updateOrderStatus("confirmed", 2);
        
//        List<Order> list = dao.getOrderByUsername("lam");
        List<Order> list = dao.getAllOrdersDesc();
        for (Order order : list) {
            System.out.println(order.toString());
        }
//        dao.insertOrder(1, "customer");
//        System.out.println(dao.toString());
    }

}
