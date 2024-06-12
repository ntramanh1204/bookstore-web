package controller;

import dal.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Cart;

public class CartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        CartDAO cdb = new CartDAO();
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        CartDAO cdb = new CartDAO();
        List<Cart> cart = cdb.getCartDetailsByUsername(acc.getUsername());
        if (cart.isEmpty()) {
            request.setAttribute("ms", "No products.");
        }

        double total = cdb.getCartTotal(acc.getUsername());

        session.setAttribute("cartTotal", total);
        session.setAttribute("cart", cart);
        request.getRequestDispatcher("cart.jsp").forward(request, response);

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
