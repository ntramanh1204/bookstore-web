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
import model.Genre;

/**
 *
 * @author ADMIN
 */
public class GenreDAO extends DBContext {
    public List<Genre> getAllGenres() {
        List<Genre> list = new ArrayList<>();
        String sql = "select * from Genres";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Genre g = new Genre(rs.getString("id"),
                        rs.getString("genre"));
                list.add(g);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public Genre getGenreFromId(String genreId) {
        String sql = "select * from genres where id = '" + genreId + "'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Genre(rs.getString("id"),
                        rs.getString("genre"));
                
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static void main(String[] args) {
        GenreDAO dao = new GenreDAO();
        List<Genre> g = dao.getAllGenres();
        System.out.println(g);
    }
}
