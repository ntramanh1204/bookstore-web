/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Locale;
import model.Account;
import model.Product;

/**
 *
 * @author ADMIN
 */
public class AddServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        String publicationDate = request.getParameter("publicationDate");
        String authorInformation = request.getParameter("authorInformation");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String rating = request.getParameter("rating");
//        String imagePath = request.getParameter("image");
        String imagePath = "";

        ProductDAO pdb = new ProductDAO();

        Locale locale = Locale.getDefault();

//        Product product = getProduct(); // Replace with the actual product

//        Locale locale = Locale.getDefault();
        title = toTitleCase(title, locale);
//        product.setTitle(titleCase);

        pdb.insertProduct(title, author, genre, price, quantity, authorInformation, publicationDate, description, imagePath, rating);
        response.sendRedirect("manageProduct");
    }

    private static String toTitleCase(String input, Locale locale) {
        if (input == null || input.isEmpty()) {
            return input;
        }

        StringBuilder titleCase = new StringBuilder();
        String[] words = input.split("\\s");

        for (String word : words) {
            if (!word.isEmpty()) {
                String firstLetter = word.substring(0, 1).toUpperCase(locale);
                String restLetters = word.substring(1).toLowerCase(locale);
                titleCase.append(firstLetter).append(restLetters).append(" ");
            }
        }

        return titleCase.toString().trim();
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
