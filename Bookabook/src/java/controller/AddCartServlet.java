package controller;

import dal.CartDAO;
import dal.ProductDAO;
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
import model.Product;

public class AddCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pid = request.getParameter("id");
        String quantity_raw = request.getParameter("quantity");
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        String buyQuantity_raw = request.getParameter("buyQuantity");
        if (buyQuantity_raw == null) {
            buyQuantity_raw = "1";
        }
        try {
//            response.getWriter().print('huhu');
            int buyQuantity = Integer.parseInt(buyQuantity_raw);
            int quantity = Integer.parseInt(quantity_raw);
            if (buyQuantity <= 0) {
                request.setAttribute("quantityError", "Quantity can't be under 1");
            } else if (buyQuantity > quantity) {
                request.setAttribute("quantityError", "Not enough products!");
            } else {
                CartDAO cartdao = new CartDAO();
                List<Cart> cart = cartdao.getCartDetailsByUsername(acc.getUsername());

                ProductDAO pdb = new ProductDAO();
                Product p = pdb.getProductById(pid);
                cartdao.updateCartDetailByProductId(pid, buyQuantity);
                if (p.getQuantity() <= 0) {
                    request.setAttribute("cartMessage", "No item available");
                    return;
                } else if (!checkCartDetailInCart(p, cart)) {
                    cartdao.addProduct(acc.getUsername(), pid, buyQuantity);
                    request.setAttribute("cartMessage", "Add to cart successfully");
                } else if (checkCartDetailInCart(p, cart)) {
                    for (Cart cartItem : cart) {
                        if (cartItem.getProduct().getId().equals(pid)) {
                            int oldQuantity = cartItem.getQuantity();
                            cartdao.updateCartDetailByProductId(pid, (oldQuantity + buyQuantity));
                            request.setAttribute("cartMessage", "Add to cart successfully");
                        }
                    }
                }
                int itemsInCart = cartdao.itemsInCart(acc.getUsername());
                session.setAttribute("account", acc);
                session.setAttribute("itemsInCart", itemsInCart);
                request.setAttribute("productDetail", p);
            }
            request.getRequestDispatcher("detail?productID=" + pid).forward(request, response);
        } catch (NumberFormatException e) {

        }

    }

    private boolean checkCartDetailInCart(Product p, List<Cart> cart) {
        for (Cart cartDetail : cart) {
            if (cartDetail.getProduct().getId().equals(p.getId())) {
                return true;
            }
        }
        return false;
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
