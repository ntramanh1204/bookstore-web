<%-- 
    Document   : side-part
    Created on : Feb 29, 2024, 7:21:33 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-lg-12">
    <h4 class="mb-">Featured books</h4>
    <c:forEach items="${requestScope.highestRating}" var="p">
        <div class="d-flex align-items-center justify-content-start">
            <div class="rounded me-4" style="width: 100px; height: 100px;">
                <a href="detail?productID=${p.id}"><img src="images/books/${p.imagePath}" class="img-fluid rounded" style="width: 80px; height: 100px;" alt=""></a>
            </div>
            <div style="width: 200px; height: 125px;">
                <h6 class="mb-2"><a href="detail?productID=${p.id}" class="btn-link">${p.title}</a></h6>
                <div class="d-flex mb-2">
                    <script>
                        var rating = ${p.rating};
                        for (var i = 1; i <= 5; i++) {
                            if (i <= Math.floor(rating)) {
                                document.write('<i class="fa fa-star text-secondary"></i>');
                            } else if (i - rating <= 0.5) {
                                document.write('<i class="fa fa-star-half text-secondary"></i>');
                            } else {
                                document.write('<i class="fa fa-star"></i>');
                            }
                        }
                    </script>
                    &nbsp;<span>${p.rating}</span>
                </div>
                <div class="d-flex mb-2">
                    <h5 class="fw-bold me-2">$${p.price}</h5>
                    <!--<h5 class="text-danger text-decoration-line-through">4.11 $</h5>-->
                </div>
            </div>
        </div>       
    </c:forEach>
    <!--<div class="d-flex justify-content-center my-4">
        <a href="#" class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100">View More</a>
    </div>-->
</div>
