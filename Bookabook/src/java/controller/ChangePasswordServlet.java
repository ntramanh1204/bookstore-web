package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

public class ChangePasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountDAO adb = new AccountDAO();
        Account account = (Account) session.getAttribute("account");
        String username = account.getUsername();
        if (account == null) {
            response.sendRedirect("login");
        } else {
            String oldPassword = request.getParameter("oldPass");
            String newPassword = request.getParameter("newPass");
            String reNewPassword = request.getParameter("reNewPass");

            if (!adb.checkAccountPassword(username, oldPassword)) {
                request.setAttribute("pwdError", "Your old password is incorrect. Please try again.");
            } else if (!newPassword.equals(reNewPassword)) {
                request.setAttribute("pwdError", "The new passwords do not match. Please re-enter your passwords.");
                
            } else {
                adb.changePassword(username, newPassword);
                request.setAttribute("pwdError", "Successful!");
//                response.sendRedirect("home");
            }
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
