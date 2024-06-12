package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import model.Genre;
import model.Product;

public class ProductDAO extends DBContext {

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "select * from Products";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = createProductFromResultSet(rs);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getAllProducts(int index, int size) {
        List<Product> list = new ArrayList<>();
//        String sql = "select * from Products where title like '%" + txtSearch + "%'";
        String sql = "WITH x AS (SELECT ROW_NUMBER() OVER (ORDER BY id ASC) AS row, *\n"
                + "\n"
                + "FROM Products)\n"
                + "SELECT * FROM x WHERE row BETWEEN " + (index * size - (size - 1)) + " AND " + (index * size);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Product product = createProductFromResultSet(rs);
                list.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void editProduct(String title, String author, String genre,
            double price, int quantity, String authorInformation,
            String publicationDate, String bookDescription,
            double rating, String id) {
        try {
            String sql = """
                         UPDATE [dbo].[Products]
                            SET [title] = ?
                               ,[author] = ?
                               ,[genreId] = ?
                               ,[price] = ?
                               ,[quantity] = ?
                               ,[authorInformation] = ?
                               ,[publicationDate] = ?
                               ,[bookDescription] = ?
                               ,[imagePath] = ?
                               ,[rating] = ?
                          WHERE [id] = ?""";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, title);
            st.setString(2, author);
            st.setString(3, genre);
            st.setDouble(4, price);
            st.setInt(5, quantity);
            st.setString(6, authorInformation);
            st.setString(7, publicationDate);
            st.setString(8, bookDescription);
            st.setString(9, "images/");
            st.setDouble(10, rating);
            st.setString(11, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void insertProduct(String title, String author, String genre,
            String price, String quantity, String authorInformation,
            String publicationDate, String bookDescription,
            String imagePath, String rating) {
        try {
            String sql = "INSERT INTO Products VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, generateId());
            st.setString(2, title);
            st.setString(3, author);
            st.setString(4, genre);
            st.setString(5, price);
            st.setString(6, quantity);
            st.setString(7, authorInformation);
            st.setString(8, publicationDate);
            st.setString(9, bookDescription);
            st.setString(10, "images/");
            st.setString(11, rating);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public String generateId() {
        Random rand = new Random();
        int min = 10000000;
        int max = 99999999;
        while (true) {
            String id = Integer.toString(rand.nextInt((max - min) + 1) + min);
            if (!checkExistId(id)) {
                return id;
            }
        }
    }
    
//    public double getPriceByPid(String productId) {
//        String sql = "select price from products where id = '" + productId + "'";
//        try {
//            PreparedStatement st = connection.prepareStatement(sql);
//            ResultSet rs = st.executeQuery();
//            if (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return 0;
//    }

    public boolean checkExistId(String id) {
        try {
            String sql = "SELECT * FROM Products WHERE id = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public List<Product> getProductsByGenre(String gid) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from Products where genreId = '" + gid + "'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product product = createProductFromResultSet(rs);
                list.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getProductsByGenre(String genre, int index, int size) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE genreId = ? ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, genre);
            st.setInt(2, index);
            st.setInt(3, size);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product product = createProductFromResultSet(rs);
                list.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int countProduct(String txtSearch) {
        String sql = "SELECT COUNT(*) FROM Products WHERE title LIKE '%" + txtSearch + "%'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1); // cot thu 1
            }
        } catch (SQLException e) {
            System.out.println();
        }
        return 0;
    }

    public List<Product> searchByTitle(String txtSearch, int index, int size) {
        List<Product> list = new ArrayList<>();
//        String sql = "select * from Products where title like '%" + txtSearch + "%'";
        String sql = """
                     WITH x AS (
                     \tSELECT ROW_NUMBER() OVER (ORDER BY id ASC) AS row, *
                     \tFROM Products
                     \tWHERE title LIKE '%""" + txtSearch + "%'\n"
                + ")\n"
                + "SELECT * FROM x WHERE row BETWEEN " + (index * size - (size - 1)) + " AND " + (index * size);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Product p = createProductFromResultSet(rs);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> searchByAuthor(String txtSearch, int index, int size) {
        List<Product> list = new ArrayList<>();
        String sql = """
                     WITH x AS (
                     \tSELECT ROW_NUMBER() OVER (ORDER BY id ASC) AS row, *
                     \tFROM Products
                     \tWHERE author LIKE '%""" + txtSearch + "%'\n"
                + ")\n"
                + "SELECT * FROM x WHERE row BETWEEN " + (index * size - (size - 1)) + " AND " + (index * size);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Product p = createProductFromResultSet(rs);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Product getProductById(String id) {
        String sql = "select * from Products where id = '" + id + "'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Product p = createProductFromResultSet(rs);
                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Product> getHighestRating() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP 3 * FROM Products WHERE price <> 0.00 ORDER BY rating DESC;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = createProductFromResultSet(rs);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getBookNumEachGenre(String genre) {
        String sql = """
                     SELECT genre, COUNT(*) AS product_count
                     FROM products
                     WHERE genre = '?'
                     GROUP BY genre""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, genre);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("product_count");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public void deleteBook(String id) {
//        String sql = "DELETE FROM Products WHERE id = ?";
        String sql = "UPDATE Products SET quantity = 0 WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Product> getTopFeatured(int numOfProducts) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP " + numOfProducts + " * FROM Products WHERE price <> 0.00 ORDER BY rating DESC;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = createProductFromResultSet(rs);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getTopLatest(int numOfProducts) {
        List<Product> list = new ArrayList<>();
//        String sql = "SELECT TOP " + numOfProducts + " * \n"
//                + "FROM Products \n"
//                + "ORDER BY CONVERT(datetime, publicationDate, 107) DESC";

        String sql = "SELECT TOP " + numOfProducts + " *\n"
                + "FROM products\n"
                + "order by year(publicationDate) desc, MONTH(publicationDate) desc, DAY(publicationDate)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = createProductFromResultSet(rs);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getTopLatest(int index, int size) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP " + size + " * \n"
                + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY CONVERT(datetime, publicationDate, 107) DESC) AS row, *\n"
                + "      FROM Products) AS x\n"
                + "WHERE row BETWEEN " + (index * size - (size - 1)) + " AND " + (index * size);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = createProductFromResultSet(rs);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getTopOldest(int index, int size) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP " + size + " * \n"
                + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY CONVERT(datetime, publicationDate, 107) ASC) AS row, *\n"
                + "      FROM Products) AS x\n"
                + "WHERE row BETWEEN " + (index * size - (size - 1)) + " AND " + (index * size);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product product = createProductFromResultSet(rs);
                list.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getAlphabeticallyAsc(int index, int size) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP " + size + " * \n"
                + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY title ASC) AS row, *\n"
                + "      FROM Products) AS x\n"
                + "WHERE row BETWEEN " + (index * size - (size - 1)) + " AND " + (index * size);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product product = createProductFromResultSet(rs);
                list.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getAlphabeticallyDesc(int index, int size) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP " + size + " * \n"
                + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY title DESC) AS row, *\n"
                + "      FROM Products) AS x\n"
                + "WHERE row BETWEEN " + (index * size - (size - 1)) + " AND " + (index * size);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product product = createProductFromResultSet(rs);
                list.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    private Product createProductFromResultSet(ResultSet rs) throws SQLException {
        GenreDAO gdb = new GenreDAO();
        String genreId = rs.getString("genreId"); // Retrieve the genreId as a string from the ResultSet
        Genre genre = gdb.getGenreFromId(genreId); // Create a new Genre instance using the genreId

        return new Product(rs.getString("id"),
                rs.getString("title"),
                rs.getString("author"),
                genre, // Assign the Genre instance to the product
                rs.getDouble("price"),
                rs.getInt("quantity"),
                rs.getString("authorInformation"),
                rs.getString("publicationDate"),
                rs.getString("bookDescription"),
                rs.getString("imagePath"),
                rs.getDouble("rating"));
    }

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
//        List<Product> list = dao.searchByTitle("the", 1, 3);
//        List<Product> list = dao.getProductsByGenre("romance", 1, 12);
////        System.out.println(dao.countProduct("the"));
//        Product p = dao.getProductById("28962990");
        dao.deleteBook("58543750");
        
//        List<Product> list = dao.getProductsByGenre("fantasy", 1, 3);
//        for (Product product : list) {
//            System.out.println(product.toString());
//        dao.editProduct("A - My Book", p.getAuthor(), p.getGenre().getId(), p.getPrice(), p.getQuantity(), p.getAuthorInformation(), p.getPublicationDate(), p.getBookDescription(), p.getRating(), p.getId());
//        System.out.println(p.toString());
    }

//        dao.insertProduct("00", "tram anh", "fantasy", "2.4", "1", "hehe", "March 6, 2024", "hehe", "", "2.4");
//        System.out.println(dao.getProductById("31188362").toString());
}
