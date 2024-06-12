//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.Arrays;
//import java.util.List;
//
//@WebFilter(filterName = "NotFoundFilter", urlPatterns = {"/*"})
//public class NotFoundFilter implements Filter {
//    private List<String> allowedPages;
//
//    @Override
//    public void init(FilterConfig filterConfig) throws ServletException {
//        allowedPages = Arrays.asList("/home");
//    }
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//        HttpServletResponse httpResponse = (HttpServletResponse) response;
//
//        String requestedPage = httpRequest.getServletPath();
//
//        if (!allowedPages.contains(requestedPage)) {
//            httpResponse.sendRedirect(httpRequest.getContextPath() + "/not-found");
//            return;
//        }
//
//        chain.doFilter(request, response);
//    }
//
//    @Override
//    public void destroy() {
//        // Cleanup resources, if any
//    }
//}