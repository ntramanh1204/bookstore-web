package controller;

import dal.OrderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.OrderDetail;

public class OrderDetailServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        OrderDetailDAO odDao = new OrderDetailDAO();
        String orderId_raw = request.getParameter("orderID");
        try {
            int orderId = Integer.parseInt(orderId_raw);
            List<OrderDetail> list = odDao.getOrderDetailById(orderId);
            double totalValue = odDao.getOrderTotal(orderId);
            request.setAttribute("orderId", orderId);
            request.setAttribute("orderDetail", list);
            request.setAttribute("total", totalValue);
        } catch(NumberFormatException e) {
            
        }
        
        request.getRequestDispatcher("orderDetail.jsp").forward(request, response);
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
