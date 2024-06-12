package controller;

import dal.CartDAO;
import dal.OrderDAO;
import dal.OrderDetailDAO;
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

public class CheckoutServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        CartDAO cdb = new CartDAO();

        List<Cart> cart = cdb.getCartDetailsByUsername(acc.getUsername());
        double total = cdb.getCartTotal(acc.getUsername());

        request.setAttribute("cartTotal", total);
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO orderDao = new OrderDAO();
        CartDAO cartDao = new CartDAO();
        OrderDetailDAO orderDetailDao = new OrderDetailDAO();

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        int id = 1 + orderDao.getLastOrderId();
        orderDao.insertOrder(id, acc.getUsername());
        List<Cart> cart = cartDao.getCartDetailsByUsername(acc.getUsername());
        for (Cart item : cart) {
            orderDetailDao.insertOrderDetail(id, item.getProduct().getId(), item.getQuantity());
        }

        response.sendRedirect("success");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
