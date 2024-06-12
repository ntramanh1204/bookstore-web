<%-- 
    Document   : menu
    Created on : Feb 29, 2024, 6:58:47 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Spinner Start -->
<div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<!-- Navbar start -->
<div class="container-fluid fixed-top">
    <div class="container topbar bg-primary d-none d-lg-block">
        <div class="d-flex justify-content-between">
            <div class="top-info ps-2">
                <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">Thach That, Ha Noi</a></small>
                <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">AnhNTHE182498@fpt.edu.vn</a></small>
            </div>
            <c:if test="${sessionScope.account != null}">
                <div class="top-link pe-2">
                    <a href="profile" class="text-white"><small class="text-white mx-2">Hi ${sessionScope.account.username}</small></a>
                    <!--<a href="#" class="text-white"><small class="text-white mx-2">Privacy Policy</small>/</a>-->
                    <!--<a href="#" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a>-->
                    <!--<a href="#" class="text-white"><small class="text-white ms-2">Sales and Refunds</small></a>-->
                </div>
            </c:if>
        </div>
    </div>
    <div class="container px-0">
        <nav class="navbar navbar-light bg-white navbar-expand-xl">
            <a href="index.html" class="navbar-brand"><h1 class="text-primary display-6">Bookabook</h1></a>
            <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="fa fa-bars text-primary"></span>
            </button>
            <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                <div class="navbar-nav mx-auto">
                    <a href="index.html" class="nav-item nav-link active">Home</a>
                    <a href="shop" class="nav-item nav-link">Shop</a>

                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Genres</a>
                        <div class="dropdown-menu m-0 bg-secondary rounded-0">
                            <a href="genre?gid=cookbooks" class="dropdown-item">Cookbooks</a>
                            <a href="genre?gid=fantasy" class="dropdown-item">Fantasy</a>
                            <a href="genre?gid=fiction" class="dropdown-item">Fiction</a>
                            <a href="genre?gid=graphic-novels" class="dropdown-item">Graphic Novels</a>
                            <a href="genre?gid=historical-fiction" class="dropdown-item">Historical Fiction</a>
                            <a href="genre?gid=history" class="dropdown-item">History</a>
                            <a href="genre?gid=horror" class="dropdown-item">Horror</a>
                            <a href="genre?gid=memoir" class="dropdown-item">Memoir</a>
                            <a href="genre?gid=middle-grade" class="dropdown-item">Middle Grade</a>
                            <a href="genre?gid=mystery" class="dropdown-item">Mystery</a>
                            <a href="genre?gid=nonfiction" class="dropdown-item">Nonfiction</a>
                            <a href="genre?gid=picture-books" class="dropdown-item">Picture Books</a>
                            <a href="genre?gid=poetry" class="dropdown-item">Poetry</a>
                            <a href="genre?gid=romance" class="dropdown-item">Romance</a>
                            <a href="genre?gid=science" class="dropdown-item">Science</a>
                            <a href="genre?gid=science-fiction" class="dropdown-item">Science Fiction</a>
                            <a href="genre?gid=short-stories" class="dropdown-item">Short Stories</a>
                            <a href="genre?gid=thriller" class="dropdown-item">Thriller</a>
                            <a href="genre?gid=young-adult" class="dropdown-item">Young Adult</a>
                        </div>
                    </div>
                    <a href="aboutUs" class="nav-item nav-link">About us</a>
                    <c:if test="${sessionScope.account != null && sessionScope.account.isAdmin == 1}">
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Manage</a>
                            <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                <a href="manageProduct" class="dropdown-item">Products</a>
                                <a href="manageAccount" class="dropdown-item">Accounts</a>
                                <a href="manageOrder" class="dropdown-item">Orders</a>
                            </div>
                        </div>
                    </c:if>
                </div>
                <div class="d-flex m-3 me-0">
                    <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" data-bs-toggle="modal" data-bs-target="#searchModal"><i class="fas fa-search text-primary"></i></button>
                    <a href="cart" class="position-relative me-4 my-auto">
                        <i class="fa fa-shopping-bag fa-2x"></i>
                        <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">
                            <c:if test="${sessionScope.account != null}">
                                ${itemsInCart}
                            </c:if>
                            <c:if test="${sessionScope.account == null}">
                                0
                            </c:if>
                        </span>
                    </a>
                    <!--                                        <a href="#" class="my-auto">
                                                                <i class="fas fa-user fa-2x"></i>
                                                            </a>-->
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fas fa-user fa-2x"></i></a>
                        <div class="dropdown-menu m-0 bg-secondary rounded-0">
                            <c:if test="${sessionScope.account == null}">
                                <a href="login" class="dropdown-item">Login</a>
                                <a href="register" class="dropdown-item">Register</a>
                            </c:if>
                            <c:if test="${sessionScope.account != null}">
                                <a href="profile" class="dropdown-item">Profile</a>
                                <a href="orderHistory" class="dropdown-item">Order History</a>
                                <!--<a href="chackout.html" class="dropdown-item">Chackout</a>-->
                                <a href="logout" class="dropdown-item">Log Out</a>
                            </c:if>
                        </div>
                    </div>

                </div>
            </div>
        </nav>
    </div>
</div>
<!-- Navbar End -->


<!-- Modal Search Start -->
<!--<form action="search?index=1" method="get">
    <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content rounded-0">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex align-items-center">
                    <div class="input-group w-75 mx-auto d-flex">
                        <input name="keyword" type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                        <span id="search-icon-1" class="input-group-text p-3"><button type="submit" style="border: none"><i class="fa fa-search"></i></button></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>-->


<form action="search" method="get">
    <input type="hidden" name="index" value="1">
    <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content rounded-0">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex flex-column align-items-center">
                    <div class="input-group w-75 mx-auto d-flex">
                        <input value="${txtSearch}" name="keyword" type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                        <span id="search-icon-1" class="input-group-text p-3">
                            <button type="submit" style="border: none"><i class="fa fa-search"></i></button>
                        </span>
                    </div>
                    <div class="input-group w-75 mx-auto d-flex mt-3">
                        <div class="input-group-prepend">
                            <label class="input-group-text" for="searchOption">Search Option</label>
                        </div>
                        <select class="form-select" name="searchOption" id="searchOption">
                            <option value="title">Search by Title</option>
                            <option value="author">Search by Author</option>
                        </select>
                    </div>
                </div>


            </div>
        </div>
    </div>
</form>




<div class="input-group w-75 mx-auto d-flex mt-3">
    <select name="searchOption" id="searchOption">
        <option value="title">Search by Title</option>
        <option value="author">Search by Author</option>
        <option value="genre">Search by Genre</option>
    </select>
</div>
</div>
</div>
</div>
</div>
</form>



<!-- Modal Search End -->