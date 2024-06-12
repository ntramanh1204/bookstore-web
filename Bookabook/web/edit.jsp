<%-- 
    Document   : edit
    Created on : Mar 4, 2024, 11:56:40 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Product</title>
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

            <!-- Single Page Header start -->
            <div class="container-fluid page-header py-5">
                <h1 class="text-center text-white display-6">Edit Product Detail</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                    <li class="breadcrumb-item active text-white">Edit Products</li>
                </ol>
            </div>
            <!-- Single Page Header End -->
            <!--Modal Edit Start--> 
            <form action="edit" method="post">
                <div class="row" style="margin: 3%">
                    <h4 class="mb-3">Product Information</h4>

                    <div class="mb-3">
                        <label for="id">Product ID</label>
                        <input name="id" value="${product.id}" type="text" class="form-control" id="id" value="" readonly>
                    <div class="invalid-feedback">
                        Please do not leave the id empty.
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="title">Title</label>
                        <input value="${product.title}" name="title" type="text" class="form-control" id="title" required>
                        <div class="invalid-feedback">
                            Valid title is required.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="author">Author</label>
                        <input value="${product.author}" name="author" type="text" class="form-control" id="author" required>
                        <div class="invalid-feedback">
                            Valid author is required.
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="genre">Genre</label>
                        <select style="cursor: pointer" class="form-control" id="genre" required>
                            <c:forEach items="${listG}" var="g">
                                <option ${product.id} value="${g.id}">${g.genre}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">
                            Valid genre is required.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="publicationDate">Publication Date (Optional)</label>
                        <input value="${product.publicationDate}" style="cursor: pointer" name="publicationDate" type="date" class="form-control" id="publicationDate" >
                        <div class="invalid-feedback">
                            Valid date is required.
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="bookDescription">Book Description</label>
                    <textarea name="bookDescription" type="text" class="form-control" id="bookDescription" required>${product.bookDescription}</textarea>
                    <div class="invalid-feedback">
                        Please do not leave the description empty.
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="price" class="form-label">Price</label>
                        <div class="input-group has-validation">
                            <span class="input-group-text">$</span>
                            <input value="${product.price}" name="price" type="number" step="0.01" min="0.01" class="form-control" id="price" required>
                            <div class="invalid-feedback">
                                Please enter a valid price.
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="quantity">Quantity</label>
                        <input name="quantity" type="number" step="0.01" min="0.01" class="form-control" id="quantity" value="${product.quantity}" required>
                        <div class="invalid-feedback">
                            Please provide a valid quantity for the product.
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="image">Image</label>
                        <input value="images/books/${product.imagePath}" style="cursor: pointer" name="image" type="file" class="form-control" id="image" placeholder="" accept="image/*">
                        <div class="invalid-feedback">
                            Image required.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="rating">Average Rating <span class="text-muted">(Optional)</span></label>
                        <input value="${product.rating}" name="rating" type="number" step="0.01" min="0.01" class="form-control" id="rating">
                        <div class="invalid-feedback">
                            Rating required.
                        </div>
                    </div>
                </div>
                <button class="btn btn-primary btn-lg btn-block" type="submit">Save Product</button>
            </div>
        </form>
        <!--Modal Edit End--> 


        <jsp:include page="template/footer.jsp"></jsp:include>
        <jsp:include page="template/js-lib-template.jsp"></jsp:include>
    </body>
</html>
