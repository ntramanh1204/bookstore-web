package controller;

import dal.GenreDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Genre;
import model.Product;

public class GenreServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String genreID = request.getParameter("gid");
        ProductDAO pdb = new ProductDAO();
        GenreDAO gdb = new GenreDAO();
        
        String indexStr = request.getParameter("index");
        int index;
        if (indexStr != null && !indexStr.isEmpty()) {
            index = Integer.parseInt(indexStr);
        } else {
            // Set a default value for index when it is not provided
            index = 1;
        }
        
        int pageSize = 12;
        int count = pdb.getProductsByGenre("gid").size();
        int endPage = count / pageSize;
        if (count % pageSize != 0) {
            endPage += 1;
        }
        
        List<Product> list = pdb.getProductsByGenre(genreID, index, pageSize);
        List<Genre> listG = gdb.getAllGenres();
        List<Product> highestRating = pdb.getHighestRating();
        request.setAttribute("gid", genreID);
        request.setAttribute("listP", list);
        request.setAttribute("listG", listG);
        request.setAttribute("highestRating", highestRating);
        request.setAttribute("end", endPage);
        request.setAttribute("index", index);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
