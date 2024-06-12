package controller;

import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Order;

public class ManageOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO odao = new OrderDAO();
        List<Order> list = odao.getAllOrdersDesc();
        if (list.isEmpty()) {
            request.setAttribute("ms", "Nothing here yet.");
        } else {
            request.setAttribute("orders", list);
        }
        request.getRequestDispatcher("manageOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("statusList");
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        OrderDAO dao = new OrderDAO();
        dao.updateOrderStatus(status, orderId);
        List<Order> list2 = dao.getAllOrdersDesc();

        if (list2.isEmpty()) {
            request.setAttribute("ms", "Nothing here yet.");
        } else {
            request.setAttribute("orders", list2);
        }
        request.getRequestDispatcher("manageOrder.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
