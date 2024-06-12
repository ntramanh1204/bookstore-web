<%-- 
    Document   : home
    Created on : Feb 26, 2024, 9:27:42 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Home of the bookworms</title>
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
    </head>

    <body>

        <jsp:include page="template/menu.jsp"></jsp:include>

            <!-- Hero Start -->
            <div class="container-fluid py-5 mb-5 hero-header">
                <div class="container py-5">
                    <div class="row g-5 align-items-center">
                        <div class="col-md-12 col-lg-7">
                            <h4 class="mb-3 text-secondary">Book Paradise</h4>
                            <h1 class="mb-5 display-3 text-primary">A curated collection of captivating books</h1>
                            <div class="position-relative mx-auto">
                                <form action="search" method="get">
                                    <input type="hidden" name="index" value="1">
                                    <input type="search" name="keyword" class="form-control border-2 border-secondary w-75 py-3 px-4 rounded-pill" type="text" placeholder="Search By Title">
                                    <button type="submit" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 25%;">Find Now!</button>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-12 col-lg-5">
                            <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                                <div class="carousel-inner" role="listbox">
                                    <div class="carousel-item active rounded">
                                        <img src="images/webimg/featured.jpg" class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
                                        <a href="#favourite" class="btn px-4 py-2 text-white rounded">Featured Books</a>
                                    </div>
                                    <div class="carousel-item rounded">
                                        <img src="images/webimg/latest.jpg" class="img-fluid w-100 h-100 rounded" alt="Second slide">
                                        <a href="#favourite" class="btn px-4 py-2 text-white rounded">Latest Books</a>
                                    </div>
                                </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Hero End -->


            <!-- Features Section Start -->
            <div class="container-fluid featurs py-5">
                <div class="container py-5">
                    <div class="row g-4">
                        <div class="col-md-6 col-lg-3">
                            <div class="featurs-item text-center rounded bg-light p-4">
                                <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                    <i class="fas fa-car-side fa-3x text-white"></i>
                                </div>
                                <div class="featurs-content text-center">
                                    <h5>Free Shipping</h5>
                                    <p class="mb-0">Free on order over $300</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <div class="featurs-item text-center rounded bg-light p-4">
                                <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                    <i class="fas fa-user-shield fa-3x text-white"></i>
                                </div>
                                <div class="featurs-content text-center">
                                    <h5>Security Payment</h5>
                                    <p class="mb-0">100% security payment</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <div class="featurs-item text-center rounded bg-light p-4">
                                <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                    <i class="fas fa-exchange-alt fa-3x text-white"></i>
                                </div>
                                <div class="featurs-content text-center">
                                    <h5>30 Day Return</h5>
                                    <p class="mb-0">30 day money guarantee</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <div class="featurs-item text-center rounded bg-light p-4">
                                <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                    <i class="fa fa-phone-alt fa-3x text-white"></i>
                                </div>
                                <div class="featurs-content text-center">
                                    <h5>24/7 Support</h5>
                                    <p class="mb-0">Support every time fast</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Features Section End -->


            <!-- Fruits Shop Start-->
            <div class="container-fluid fruite py-5">
                <div class="container py-5">
                    <div class="tab-class text-center">
                        <div class="row g-4">
                            <div class="col-lg-4 text-start">
                                <h1 id="favourite">My Favorite Books</h1>
                            </div>
                            <div class="col-lg-8 text-end">
                                <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                    <li class="nav-item">
                                        <a class="d-flex m-2 py-2 bg-light rounded-pill active" data-bs-toggle="pill" href="#tab-1">
                                            <span class="text-dark" style="width: 130px;">Featured</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="d-flex py-2 m-2 bg-light rounded-pill " data-bs-toggle="pill" href="#tab-2">
                                            <span class="text-dark" style="width: 130px;">Latest</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane fade show p-0 active">
                                <div class="row g-4">
                                    <div class="col-lg-12">
                                        <div class="row g-4">


                                        <c:forEach items="${requestScope.featured}" var="p">

                                            <div class="col-md-6 col-lg-4 col-xl-3">
                                                <div class="rounded position-relative fruite-item">
                                                    <div class="fruite-img">
                                                        <a href="detail?productID=${p.id}"><img src="images/books/${p.imagePath}" class="img-fluid w-100 rounded-top" alt=""></a>
                                                    </div>
                                                    <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">${p.genre.genre}</div>
                                                    <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                        <h4><a href="detail?productID=${p.id}">${p.title}</a></h4>
                                                        <!--<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>-->
                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold mb-0">$${p.price}</p>
                                                            <form id="addToCartForm" action="addCart" method="get">
                                                                <input type="hidden" value="${p.id}" name="id"/>
                                                                <button type="submit" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </c:forEach>   

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="tab-2" class="tab-pane fade show p-0 ">
                            <div class="row g-4">
                                <div class="col-lg-12">
                                    <div class="row g-4">
                                        <c:forEach items="${requestScope.latest}" var="q">
                                            <div class="col-md-6 col-lg-4 col-xl-3">
                                                <div class="rounded position-relative fruite-item">
                                                    <div class="fruite-img">
                                                        <a href="detail?productID=${q.id}"><img src="images/books/${q.imagePath}" class="img-fluid w-100 rounded-top" alt=""></a>
                                                    </div>
                                                    <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">${q.genre.genre}</div>
                                                    <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                        <h4><a href="detail?productID=${q.id}">${q.title}</a></h4>
                                                        <div class="d-flex justify-content-between flex-lg-wrap">
                                                            <p class="text-dark fs-5 fw-bold mb-0">$${q.price}</p>
                                                            <form id="addToCartForm" action="addCart" method="get">
                                                                <input type="hidden" value="${q.id}" name="id"/>
                                                                <button type="submit" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>      
                </div>
            </div>
            <!-- Fruits Shop End-->


            <jsp:include page="template/footer.jsp"></jsp:include>
            <jsp:include page="template/js-lib-template.jsp"></jsp:include>

    </body>

</html>
