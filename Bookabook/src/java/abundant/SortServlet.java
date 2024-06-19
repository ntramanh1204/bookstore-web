package abundant;

import dal.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class SortServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO pdb = new ProductDAO();

        List<Product> productList;

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

        request.setAttribute("subjectId", bookList);
        request.setAttribute("subjectList", bookList);
        request.setAttribute("instructorList", bookList);
        request.getRequestDispatcher("show.jsp").forward(request, response);
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
