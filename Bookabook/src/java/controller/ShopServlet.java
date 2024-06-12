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

public class ShopServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

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
        int count = pdb.getAllProducts().size();
        int endPage = count / pageSize;
        if (count % pageSize != 0) {
            endPage += 1;
        }

        String bookList = request.getParameter("bookList");
        List<Product> listP = new ArrayList<>();

        if (bookList == null) {
            listP = pdb.getAllProducts(index, pageSize);
        } else if (bookList.equals("none")) {
            listP = pdb.getAllProducts(index, pageSize);
        } else if (bookList.equals("latest")) {
            listP = pdb.getTopLatest(index, pageSize);
        } else if (bookList.equals("oldest")) {
            listP = pdb.getTopOldest(index, pageSize);
        } else if (bookList.equals("a-z")) {
            listP = pdb.getAlphabeticallyAsc(index, pageSize);
        } else if (bookList.equals("z-a")) {
            listP = pdb.getAlphabeticallyDesc(index, pageSize);
        }

//        List<Product> listP = pdb.getAllProducts(index, pageSize);
        List<Genre> listG = gdb.getAllGenres();
        List<Product> highestRating = pdb.getHighestRating();
        
        

        request.setAttribute("listP", listP);
        request.setAttribute("listG", listG);
        request.setAttribute("highestRating", highestRating);
        request.setAttribute("end", endPage);
        request.setAttribute("index", index);

        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
