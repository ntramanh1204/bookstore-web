package controller;

import dal.AccountDAO;
import dal.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String rePass = request.getParameter("repass");

        if (!pass.equals(rePass)) {
            request.setAttribute("pwdError", "The passwords do not match. Please re-enter your password.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            AccountDAO adb = new AccountDAO();
            if (adb.checkUsernameExisted(user)) {
                request.setAttribute("error", "Username existed!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                adb.register(name, phone, address, email, user, pass);
                Account acc = adb.login(user, pass);
                HttpSession session = request.getSession();
                CartDAO cartdao = new CartDAO();
                int itemsInCart = cartdao.itemsInCart(acc.getUsername());
                session.setAttribute("itemsInCart", itemsInCart);
                session.setAttribute("account", acc);
                response.sendRedirect("home");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
