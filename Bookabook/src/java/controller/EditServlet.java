package controller;

import dal.AccountDAO;
import dal.GenreDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Account;
import model.Genre;
import model.Product;

public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        ProductDAO pdb = new ProductDAO();
        GenreDAO gdb = new GenreDAO();

        Product product = pdb.getProductById(id);
        List<Genre> listG = gdb.getAllGenres();
//        response.getWriter().println(id);
//        response.getWriter().println(p);
//        response.getWriter().println(listG);
        request.setAttribute("product", product);
        request.setAttribute("listG", listG);
//        
        request.getRequestDispatcher("edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        ProductDAO pdb = new ProductDAO();
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        String publicationDate = request.getParameter("publicationDate");
        String authorInformation = request.getParameter("authorInformation");
        String description = request.getParameter("bookDescription");
        String price_raw = request.getParameter("price");
        String quantity_raw = request.getParameter("quantity");
        String rating_raw = request.getParameter("rating");
        
        try {
            int quantity = Integer.parseInt(quantity_raw);
            double price = Double.parseDouble(price_raw);
            double rating = Double.parseDouble(rating_raw);
            pdb.editProduct(title, author, genre, price, quantity, authorInformation, publicationDate, description, rating, id);
            response.sendRedirect("manageProduct");
        } catch(Exception e) {
            System.out.println(e);
        }

//        response.sendRedirect("manage");
//        request.setAttribute("title", title);
//        request.setAttribute("author", author);
//        request.setAttribute("genre", title);
//        request.setAttribute("publicationDate", publicationDate);
//        request.setAttribute("authorInformation", authorInformation);
//        request.setAttribute("bookDescription", description);
//        request.setAttribute("price", price);
//        request.setAttribute("quantity", quantity);
//        request.setAttribute("rating", rating);
//        request.getRequestDispatcher("manageProduct").forward(request, response);
        

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
