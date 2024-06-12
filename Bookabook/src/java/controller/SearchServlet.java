package controller;

import dal.GenreDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Genre;
import model.Product;

public class SearchServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String txtSearch = request.getParameter("keyword");
        String searchOption = request.getParameter("searchOption");

        ProductDAO pdb = new ProductDAO();
        GenreDAO gdb = new GenreDAO();

        String indexStr = request.getParameter("index");
        int index = Integer.parseInt(indexStr);
        int count = pdb.countProduct(txtSearch);
        int pageSize = 12;
        int endPage = count / pageSize;
        if (count % pageSize != 0) {
            endPage += 1;
        }
        if (searchOption == null || searchOption.isEmpty()) {
            searchOption = "title";
        }
        List<Product> listP = new ArrayList<>();
        if (searchOption.equals("title")) {
            listP = pdb.searchByTitle(txtSearch, index, pageSize);
        } else if (searchOption.equals("author")) {
            listP = pdb.searchByAuthor(txtSearch, index, pageSize);
        }
//        List<Product> listPAuthor = pdb.searchByAuthor(txtSearch, index, pageSize);
        List<Genre> listG = gdb.getAllGenres();
        List<Product> highestRating = pdb.getHighestRating();

        request.setAttribute("end", endPage);
        request.setAttribute("listP", listP);
//        request.setAttribute("listPAuthor", listPAuthor);
        request.setAttribute("listG", listG);
        request.setAttribute("highestRating", highestRating);
        request.setAttribute("txtS", txtSearch);
        request.setAttribute("index", index);
        request.setAttribute("searchOption", searchOption);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
