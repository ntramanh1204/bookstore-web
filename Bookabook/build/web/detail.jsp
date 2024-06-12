<%-- 
    Document   : detail
    Created on : Feb 29, 2024, 11:36:17 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Product" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${productDetail.title} - ${productDetail.author}</title>
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

        <script>
//            var rating = ${productDetail.rating};
//            for (var i = 1; i <= 5; i++) {
//                if (i <= Math.floor(rating)) {
//                    document.write('<i class="fa fa-star text-secondary"></i>');
//                } else if (i - rating <= 0.5) {
//                    document.write('<i class="fa fa-star-half text-secondary"></i>');
//                } else {
//                    document.write('<i class="fa fa-star"></i>');
//                }
//            }
        </script>
    </head>
    <body>

        <jsp:include page="template/menu.jsp"></jsp:include>

            <!-- Single Product Start -->
            <div class="container-fluid py-5 mt-5">
                <div class="container py-5">
                    <div class="row g-4 mb-5">
                        <div class="col-lg-8 col-xl-9">
                            <div class="row g-4">
                                <div class="col-lg-6">
                                    <div style="display: flex; justify-content: center; align-items: center;">
                                        <a href="#">
                                            <img src="images/books/${productDetail.imagePath}" class="img-fluid rounded" alt="Image">
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <form id="addToCartForm" action="addCart" method="get">
                                    <input type="hidden" value="${productDetail.id}" name="id"/>
                                    <input type="hidden" value="${productDetail.quantity}" name="quantity"/>
                                    <h4 class="fw-bold mb-3">${productDetail.title}</h4>
                                    <p class="mb-3">Author: ${productDetail.author}</p>
                                    <h5 class="fw-bold mb-3">$${productDetail.price}</h5>
                                    <div class="d-flex mb-4"><span>Rating: ${productDetail.rating}</span>
                                    </div>
                                    <p class="mb-4">Remaining: ${productDetail.quantity}</p>


                                    <c:if test="${productDetail.quantity == 0}">
                                        <p class="text-danger text-uppercase">Sold out</p>
                                    </c:if>
                                    <c:if test="${productDetail.quantity > 0}">
                                        <div class="input-group quantity mb-5" style="width: 100px;">
                                            <div class="input-group-btn">
                                                <button type="button" class="btn btn-sm btn-minus rounded-circle bg-light border" >
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                            </div>
                                            <input min="1" max="${productDetail.quantity}" name="buyQuantity" id="buyQuantity" type="text" class="form-control form-control-sm text-center border-0" value="1">
                                            <div class="input-group-btn">
                                                <button type="button" class="btn btn-sm btn-plus rounded-circle bg-light border" >
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                            <p class="text-danger text-uppercase">${quantityError}</p>
                                        <button type="submit" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary">
                                            <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
                                        </button>
                                        <p>${cartMessage}</p>
                                    </c:if>
                                </form>
                            </div>

                            <script>
//                                function submitForm() {
//                                    var productId = "${productDetail.id}"; 
//                                    var quantity = document.getElementById("buyQuantity").value;
//
//                                    var url = "addCart?productId=" + productId + "&quantity=" + quantity;
//
//                                    window.location.href = url;
//                                }
                            </script>
                            <!--                            <script type="text/javascript">
                                                            function buy(id) {
                                                                var m = document.f.num.value;
                                                                document.f.action = "buy?id=" + id + "&num=" + m;
                                                                document.f.submit();
                                                            }
                                                        </script>-->

                            <div class="col-lg-12">
                                <nav>
                                    <div class="nav nav-tabs mb-3">
                                        <button class="nav-link active border-white border-bottom-0" type="button" role="tab"
                                                id="nav-about-tab" data-bs-toggle="tab" data-bs-target="#nav-about"
                                                aria-controls="nav-about" aria-selected="true">Description</button>
                                        <button class="nav-link border-white border-bottom-0" type="button" role="tab"
                                                id="nav-mission-tab" data-bs-toggle="tab" data-bs-target="#nav-mission"
                                                aria-controls="nav-mission" aria-selected="false">Author</button>
                                    </div>
                                </nav>
                                <div class="tab-content mb-5">
                                    <div class="tab-pane active" id="nav-about" role="tabpanel" aria-labelledby="nav-about-tab">
                                        <p>${productDetail.bookDescription}</p>
                                        <div class="px-2">
                                            <div class="row g-4">
                                                <div class="col-12">
                                                    <div class="row bg-light align-items-center text-center justify-content-center py-2">
                                                        <div class="col-6">
                                                            <p class="mb-0">Author</p>
                                                        </div>
                                                        <div class="col-6">
                                                            <p class="mb-0">${productDetail.author}</p>
                                                        </div>
                                                    </div>
                                                    <div class="row text-center align-items-center justify-content-center py-2">
                                                        <div class="col-6">
                                                            <p class="mb-0">Genre</p>
                                                        </div>
                                                        <div class="col-6">
                                                            <p class="mb-0">${productDetail.genre.genre}</p>
                                                        </div>
                                                    </div>
                                                    <div class="row bg-light text-center align-items-center justify-content-center py-2">
                                                        <div class="col-6">
                                                            <p class="mb-0">Publication Date</p>
                                                        </div>
                                                        <div class="col-6">
                                                            <p class="mb-0">${productDetail.publicationDate}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="nav-mission" role="tabpanel" aria-labelledby="nav-mission-tab">
                                        <div class="d-flex">
                                            <div class="">
                                                <p class="mb-2" style="font-size: 14px;">Author</p>
                                                <div class="d-flex justify-content-between">
                                                    <h5>${productDetail.author}</h5>
                                                    <!-- <div class="d-flex mb-3">
                                                         <i class="fa fa-star text-secondary"></i>
                                                         <i class="fa fa-star text-secondary"></i>
                                                          <i class="fa fa-star text-secondary"></i>
                                                           <i class="fa fa-star text-secondary"></i>
                                                          <i class="fa fa-star"></i>
                                                         </div>-->
                                                </div>
                                                <p>${productDetail.authorInformation}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3">
                        <div class="row g-4 fruite">
                            <div class="col-lg-12">
                                <div class="mb-4">
                                    <h4>Genres</h4>
                                    <ul class="list-unstyled fruite-categorie">
                                        <c:forEach items="${requestScope.listG}" var="g">
                                            <li>
                                                <div class="d-flex justify-content-between fruite-name">
                                                    <a href="genre?gid=${g.id}"><i class="fas fa-apple-alt me-2"></i>${g.genre}</a>
                                                    <!--<span>(3)</span>-->
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <jsp:include page="side-part.jsp"></jsp:include>
                            </div>
                        </div>
                    </div>
                    <!--<h1 class="fw-bold mb-0">Related products</h1>-->
                    <!--                    <div class="vesitable">
                                            <div class="owl-carousel vegetable-carousel justify-content-center">
                                                <div class="border border-primary rounded position-relative vesitable-item">
                                                    <div class="vesitable-img">
                                                        <img src="img/vegetable-item-6.jpg" class="img-fluid w-100 rounded-top" alt="">
                                                    </div>
                                                    <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Vegetable</div>
                                                    <div class="p-4 pb-0 rounded-bottom">
                                                        <h4>Parsely</h4>
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold">$4.99 / kg</p>
                                                            <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="border border-primary rounded position-relative vesitable-item">
                                                    <div class="vesitable-img">
                                                        <img src="img/vegetable-item-1.jpg" class="img-fluid w-100 rounded-top" alt="">
                                                    </div>
                                                    <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Vegetable</div>
                                                    <div class="p-4 pb-0 rounded-bottom">
                                                        <h4>Parsely</h4>
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold">$4.99 / kg</p>
                                                            <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="border border-primary rounded position-relative vesitable-item">
                                                    <div class="vesitable-img">
                                                        <img src="img/vegetable-item-3.png" class="img-fluid w-100 rounded-top bg-light" alt="">
                                                    </div>
                                                    <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Vegetable</div>
                                                    <div class="p-4 pb-0 rounded-bottom">
                                                        <h4>Banana</h4>
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                            <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="border border-primary rounded position-relative vesitable-item">
                                                    <div class="vesitable-img">
                                                        <img src="img/vegetable-item-4.jpg" class="img-fluid w-100 rounded-top" alt="">
                                                    </div>
                                                    <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Vegetable</div>
                                                    <div class="p-4 pb-0 rounded-bottom">
                                                        <h4>Bell Papper</h4>
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                            <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="border border-primary rounded position-relative vesitable-item">
                                                    <div class="vesitable-img">
                                                        <img src="img/vegetable-item-5.jpg" class="img-fluid w-100 rounded-top" alt="">
                                                    </div>
                                                    <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Vegetable</div>
                                                    <div class="p-4 pb-0 rounded-bottom">
                                                        <h4>Potatoes</h4>
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                            <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="border border-primary rounded position-relative vesitable-item">
                                                    <div class="vesitable-img">
                                                        <img src="img/vegetable-item-6.jpg" class="img-fluid w-100 rounded-top" alt="">
                                                    </div>
                                                    <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Vegetable</div>
                                                    <div class="p-4 pb-0 rounded-bottom">
                                                        <h4>Parsely</h4>
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                            <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="border border-primary rounded position-relative vesitable-item">
                                                    <div class="vesitable-img">
                                                        <img src="img/vegetable-item-5.jpg" class="img-fluid w-100 rounded-top" alt="">
                                                    </div>
                                                    <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Vegetable</div>
                                                    <div class="p-4 pb-0 rounded-bottom">
                                                        <h4>Potatoes</h4>
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                            <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="border border-primary rounded position-relative vesitable-item">
                                                    <div class="vesitable-img">
                                                        <img src="img/vegetable-item-6.jpg" class="img-fluid w-100 rounded-top" alt="">
                                                    </div>
                                                    <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Vegetable</div>
                                                    <div class="p-4 pb-0 rounded-bottom">
                                                        <h4>Parsely</h4>
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
                                                            <a href="#" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>-->
                </div>
            </div>
            <!-- Single Product End -->
        <jsp:include page="template/footer.jsp"></jsp:include>
        <jsp:include page="template/js-lib-template.jsp"></jsp:include>
    </body>
</html>
