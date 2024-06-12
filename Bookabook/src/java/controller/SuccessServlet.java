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

/**
 *
 * @author ADMIN
 */
public class SuccessServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    } 
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        
        CartDAO cartDao = new CartDAO();     
        
        List<Cart> cart = cartDao.getCartDetailsByUsername(acc.getUsername());
        double total = cartDao.getCartTotal(acc.getUsername());

        session.setAttribute("cartTotal", total);
        request.setAttribute("successCart", cart);
         
        session.setAttribute("itemsInCart", 0);
        request.getRequestDispatcher("success.jsp").forward(request, response);
        cartDao.deleteCartByUsername(acc.getUsername());
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
