package controller;

import dal.GenreDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Collections;
import java.util.List;
import model.Genre;
import model.Product;

public class ManageProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//       HttpSession session = request.getSession();
//       Account acc = (Account) session.getAttribute("account");
        ProductDAO pdb = new ProductDAO();
        GenreDAO gdb = new GenreDAO();
        List<Product> listP = pdb.getAllProducts();
        Collections.sort(listP, (Product p1, Product p2) -> p1.getTitle().compareTo(p2.getTitle()) // Compare the attribute you want to sort by
        // Assuming the attribute is a string, you can use the compareTo() method
        );
        List<Genre> listG = gdb.getAllGenres();

        request.setAttribute("listP", listP);
        request.setAttribute("listG", listG);
        request.getRequestDispatcher("manage.jsp").forward(request, response);
    }

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
