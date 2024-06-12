<%-- 
    Document   : shop
    Created on : Feb 28, 2024, 12:42:51 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bookshop</title>

        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script>
            function submitForm() {
                var form = document.getElementById("form");
                form.submit();
            }
        </script>
    </head>
    <body>
        <jsp:include page="template/menu.jsp"></jsp:include>

            <!-- Single Page Header start -->
            <div class="container-fluid page-header py-5">
                <h1 class="text-center text-white display-6">Shop</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                    <li class="breadcrumb-item active text-white">Shop</li>
                </ol>
            </div>
            <!-- Single Page Header End -->

            <!-- Book Shop Start-->
            <div class="container-fluid fruite py-5">
                <div class="container py-5">
                    <h1 class="mb-4">Book a book now!</h1>
                    <div class="row g-4">
                        <div class="col-lg-12">
                            <div class="row g-4">
                                <div class="col-xl-3">
                                </div>                      
                                <div class="col-6"></div>
                                <div class="col-xl-3">
                                    <form id="form" action="shop" method="get">
                                        <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                            <label for="fruits">Sorting:</label>
                                            <select onchange="submitForm()" id="bookList" name="bookList" class="border-0 form-select-sm bg-light me-3" form="bookList">
                                                <option name="none" value="none">None</option>
                                                <option ${(bookList=='latest')?'selected':''} name="latest" value="latest">Latest</option>
                                            <option ${(bookList=='oldest')?'selected':''} name="oldest" value="oldest">Oldest</option>
                                            <option ${(bookList=='a-z')?'selected':''} name="a-z" value="a-z">A - Z</option>
                                            <option ${(bookList=='z-a')?'selected':''} name="z-a" value="z-a">Z - A</option>
                                        </select>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row g-4">
                            <div class="col-lg-3">
                                <div class="row g-4">
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <h4>Genres</h4>
                                            <ul class="list-unstyled fruite-categorie">
                                                <c:forEach items="${requestScope.listG}" var="g">
                                                    <li>
                                                        <div class="d-flex justify-content-between fruite-name">
                                                            <a href="genre?gid=${g.id}"><i class="fas fa-apple-alt me-2 active"></i>${g.genre}</a>
                                                            <!--<span>(3)</span>-->
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                    <!--                                    <div class="col-lg-12">
                                                                            <div class="mb-3">
                                                                                <h4 class="mb-2">Price</h4>
                                                                                <input type="range" class="form-range w-100" id="rangeInput" name="rangeInput" min="0" max="500" value="0" oninput="amount.value=rangeInput.value">
                                                                                <output id="amount" name="amount" min-velue="0" max-value="500" for="rangeInput">0</output>
                                                                            </div>
                                                                        </div>-->
                                    <!--                                    <div class="col-lg-12">
                                                                            <div class="mb-3">
                                                                                <h4>Additional</h4>
                                                                                <div class="mb-2">
                                                                                    <input type="radio" class="me-2" id="Categories-1" name="Categories-1" value="Beverages">
                                                                                    <label for="Categories-1"> Organic</label>
                                                                                </div>
                                                                                <div class="mb-2">
                                                                                    <input type="radio" class="me-2" id="Categories-2" name="Categories-1" value="Beverages">
                                                                                    <label for="Categories-2"> Fresh</label>
                                                                                </div>
                                                                                <div class="mb-2">
                                                                                    <input type="radio" class="me-2" id="Categories-3" name="Categories-1" value="Beverages">
                                                                                    <label for="Categories-3"> Sales</label>
                                                                                </div>
                                                                                <div class="mb-2">
                                                                                    <input type="radio" class="me-2" id="Categories-4" name="Categories-1" value="Beverages">
                                                                                    <label for="Categories-4"> Discount</label>
                                                                                </div>
                                                                                <div class="mb-2">
                                                                                    <input type="radio" class="me-2" id="Categories-5" name="Categories-1" value="Beverages">
                                                                                    <label for="Categories-5"> Expired</label>
                                                                                </div>
                                                                            </div>
                                                                        </div>-->
                                    <jsp:include page="side-part.jsp"></jsp:include>
                                        <!--                                    <div class="col-lg-12">
                                                                                <div class="position-relative">
                                                                                    <img src="images/books-378903_1280.jpg" class="img-fluid w-100 rounded" alt="">
                                                                                    <div class="position-absolute" style="top: 50%; right: 10px; transform: translateY(-50%);">
                                                                                        <h3 class="text-secondary fw-bold">Book <br> A <br> Book</h3>
                                                                                    </div>
                                                                                </div>
                                                                            </div>-->
                                    </div>
                                </div>
                                <div class="col-lg-9">
                                    <div class="row g-4 justify-content-center">
                                    <c:forEach items="${listP}" var="p">
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <a href="detail?productID=${p.id}"><img src="images/books/${p.imagePath}" class="img-fluid w-100 rounded-top" alt=""></a>
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">${p.genre.genre}</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4><a href="detail?productID=${p.id}">${p.title}</a></h4>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$${p.price}</p>
                                                        <!--                                                        <form id="addToCartForm" action="addCart" method="get">
                                                                                                                    <input type="hidden" value="${p.id}" name="id"/>
                                                                                                                    <button type="submit" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</button>
                                                                                                                </form>-->
                                                        <c:if test="${(p.quantity == 0)}">
                                                            <a href="detail?productID=${p.id}"><button type="submit" class="btn border-danger rounded-pill px-3 text-danger"><i class="fa fa-shopping-bag me-2 text-primary"></i> Sold Out</button></a>
                                                        </c:if>
                                                        <c:if test="${(p.quantity != 0)}">

                                                            <a href="detail?productID=${p.id}"><button type="submit" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> View Product</button></a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <div class="col-12">
                                        <div class="pagination d-flex justify-content-center mt-5">
                                            <c:choose>
                                                <c:when test="${empty txtS}">
                                                    <a href="shop?index=${index - 1}" class="rounded">&laquo;</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="search?index=${index - 1}&keyword=${txtS}&searchOption=${searchOption}" class="rounded">&laquo;</a>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:forEach begin="1" end="${end}" var="i">
                                                <c:choose>
                                                    <c:when test="${empty txtS}">
                                                        <a id="page-${i}" href="shop?index=${i}" class="rounded">${i}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a id="page-${i}" href="search?index=${i}&keyword=${txtS}&searchOption=${searchOption}" class="rounded">${i}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${empty txtS}">
                                                    <a href="shop?index=${index + 1}" class="rounded">&raquo;</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="search?index=${index + 1}&keyword=${txtS}&searchOption=${searchOption}" class="rounded">&raquo;</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <script>
                                        window.onload = function () {
                                            var index = ${index};
                                            var element = document.getElementById("page-" + index);
                                            if (element) {
                                                element.classList.add("active");
                                                element.classList.add("rounded");
                                            }
                                        };
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Book Shop End-->
        <jsp:include page="template/footer.jsp"></jsp:include>
        <jsp:include page="template/js-lib-template.jsp"></jsp:include>
    </body> 
</html>
