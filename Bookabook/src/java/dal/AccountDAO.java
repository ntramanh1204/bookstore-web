package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Account;

public class AccountDAO extends DBContext {
    
    public List<Account> getAllAccounts() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM Accounts";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getString("name"),
                                        rs.getString("phone"),
                                        rs.getString("address"),
                                        rs.getString("email"),
                                        rs.getString("username"),
                                        rs.getString("password"),
                                        rs.getInt("isAdmin"));
            list.add(a);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public boolean checkAccountPassword(String username, String password) {
        String sql = "SELECT * FROM Accounts WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                if (rs.getString("password").equals(password)) {
                    return true;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
    
    public Account login(String username, String password) {
        String sql = "SELECT * FROM Accounts WHERE username = ? AND password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Account(
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("isAdmin")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public boolean checkUsernameExisted(String username) {
        String sql = "SELECT * FROM Accounts WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
    
    public void register(String name, String phone, String address, String email, String username, String password) {
        String sql = "INSERT INTO Accounts (name, phone, address, email, username, password, isAdmin) VALUES (?, ?, ?, ?, ?, ?, 0)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, phone);
            st.setString(3, address);
            st.setString(4, email);
            st.setString(5, username);
            st.setString(6, password);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public Account getAccountByUsername(String username) {
        String sql = "SELECT * FROM Accounts WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                String name = rs.getString("name");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String email = rs.getString("email");
                String password = rs.getString("password");
                int isAdmin = rs.getInt("isAdmin");
                return new Account(name, phone, address, email, username, password, isAdmin);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public void deleteAccount(String username) {
        String sql = "DELETE FROM Accounts WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void updateAccount(String username, String name, String password, String email, String phone, String address) {
        String sql = "UPDATE Accounts SET name = ?, phone = ?, address = ?, email = ?, password = ? WHERE username = ?";
        try {
            Account acc = getAccountByUsername(username);
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, phone);
            st.setString(3, address);
            st.setString(4, email);
            st.setString(5, password);
            st.setString(6, username);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void changePassword(String username, String newPassword) {
        String sql = "UPDATE Accounts SET password = ? WHERE username = ?";
        try {
            Account acc = getAccountByUsername(username);
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newPassword);
            st.setString(2, acc.getUsername());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
        List<Account> list = dao.getAllAccounts();
        for (Account account : list) {
            System.out.println(account.toString());
        }
//        dao.changePassword("tramanh", "12345");
//        System.out.println(dao.checkAccountPassword("tramanh", "1234"));
//        System.out.println(dao.getAccountByUsername("tramanh").toString());
    }
}
