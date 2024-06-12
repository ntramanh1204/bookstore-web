<%-- 
    Document   : manage
    Created on : Mar 2, 2024, 3:26:01 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Products</title>
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
                <h1 class="text-center text-white display-6">Manage Products</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                    <li class="breadcrumb-item active text-white">Manage</li>
                    <li class="breadcrumb-item active text-white">Manage Products</li>
                </ol>
            </div>
            <!-- Single Page Header End -->


            <!-- Manage Page Start -->
            <div class="container-fluid py-5">
                <div class="container py-5">
                    <button class="btn btn-primary mb-4" data-bs-toggle="modal" data-bs-target="#addModal">Add New Product</button>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Book</th>
                                    <th scope="col">Title</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col" colspan="2">Handle</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listP}" var="p">
                                <tr>
                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <img src="images/books/${p.imagePath}" class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;" alt="">
                                        </div>
                                    </th>
                                    <td>
                                        <p class="mb-0 mt-4"><a href="detail?productID=${p.id}">${p.title}</a></p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">$${p.price}</p>
                                    </td>
                                    <td>
                                        <div class="input-group quantity mt-4" style="width: 75px;">
                                            <!--                                            <div class="input-group-btn">
                                                                                            <button class="btn btn-sm btn-minus rounded-circle bg-light border" >
                                                                                                <i class="fa fa-minus"></i>
                                                                                            </button>
                                                                                        </div>-->
                                            <input type="text" class="form-control form-control-sm text-center border-0" value="${p.quantity}" readonly>
                                            <!--                                            <div class="input-group-btn">
                                                                                            <button class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                                                <i class="fa fa-plus"></i>
                                                                                            </button>
                                                                                        </div>-->
                                        </div>
                                    </td>

                                    <td>
                                        <!--<form action="edit?productID=${p.id}" method="get">-->
                                        <!--                                            <button class="btn btn-md rounded-circle bg-light border mt-4" data-bs-toggle="modal" data-bs-target="#editModal">-->
                                        <form action="edit">
                                            <input type="hidden" name="id" value="${p.id}">
                                            <button type="submit" class="btn btn-md rounded-circle bg-light border mt-4">
                                                <i class="fa fa-pencil-alt text-primary"></i>
                                            </button> 
                                        </form>
                                    </td>
                                    <td>
                                        <button class="btn btn-md rounded-circle bg-light border mt-4">
                                            <a href="#" onclick="doDelete('${p.id}', '${p.title}')"><i class="fa fa-times text-danger"></i></a>
                                        </button>
                                    </td>

                            <script type="text/javascript">
                                function doDelete(id, name) {
                                    if (confirm("Do you want to delete book '" + name + "'? (The quantity will be set to zero)")) {
                                        window.location = "delete?productID=" + id;
                                    }
                                }
                            </script>


                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- Manage Page End -->

        <!-- Modal Add Start -->
        <form action="add" method="post">
            <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-fullscreen">
                    <div class="modal-content rounded-0">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Add New Product</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="row" style="margin: 3%">
                            <h4 class="mb-3">Product Information</h4>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="title">Title</label>
                                    <input name="title" type="text" class="form-control" id="title" placeholder="" value="" required>
                                    <div class="invalid-feedback">
                                        Valid title is required.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="author">Author</label>
                                    <input name="author" type="text" class="form-control" id="author" placeholder="" value="" required>
                                    <div class="invalid-feedback">
                                        Valid author is required.
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="genre">Genre</label>
                                    <select style="cursor: pointer" class="form-control" id="genre" required>
                                        <option value="">Choose...</option>
                                        <c:forEach items="${listG}" var="g">
                                            <option value="${g.id}">${g.genre}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">
                                        Valid genre is required.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="publicationDate">Publication Date (Optional)</label>
                                    <input style="cursor: pointer" name="publicationDate" type="date" class="form-control" id="publicationDate" placeholder="" value="">
                                </div>
                                <div class="invalid-feedback">
                                    Valid date is required.
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="description">Book Description</label>
                                <input name="description" type="text" class="form-control" id="description" placeholder="" required>
                                <div class="invalid-feedback">
                                    Please do not leave the description empty.
                                </div>
                            </div>

                            <div class="row">


                                <div class="col-md-6 mb-3">
                                    <label for="price" class="form-label">Price</label>
                                    <div class="input-group has-validation">
                                        <span class="input-group-text">$</span>
                                        <input name="price" type="number" step="0.01" min="0.01" class="form-control" id="price" placeholder="" required>
                                        <div class="invalid-feedback">
                                            Please enter a valid price.
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="quantity">Quantity</label>
                                    <input name="quantity" type="number" min="1" class="form-control" id="quantity" placeholder="" required>
                                    <div class="invalid-feedback">
                                        Please provide a valid quantity for the product.
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <!--                                <div class="col-md-6 mb-3">
                                                                    <label for="image">Image</label>
                                                                    <input style="cursor: pointer" name="image" type="file" class="form-control" id="image" placeholder="" accept="image/*" required>
                                                                    <div class="invalid-feedback">
                                                                        Image required.
                                                                    </div>
                                                                </div>-->
                                <div class="col-md-6 mb-3">
                                    <label for="rating">Average Rating <span class="text-muted">(Optional)</span></label>
                                    <input name="rating" type="number" max="5.00" step="0.01" min="0.01" class="form-control" id="rating" placeholder="">
                                    <div class="invalid-feedback">
                                        Rating required.
                                    </div>
                                </div>
                            </div>
                            <!--<hr class="mb-4">-->
                            <!--                            <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input" id="same-address">
                                                            <label class="custom-control-label" for="same-address">Shipping address is the same as my billing address</label>
                                                        </div>-->
                            <button class="btn btn-primary btn-lg btn-block" type="submit">Add New Product</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <!-- Modal Add End -->



        <!--         Modal Edit Start 
                <form action="edit" method="post">
                    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-fullscreen">
                            <div class="modal-content rounded-0">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Edit Product</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="row" style="margin: 3%">
                                    <h4 class="mb-3">Product Information</h4>
                                    
                                     <div class="mb-3">
                                        <label for="id">Product ID</label>
                                        <input name="id" type="text" class="form-control" id="id" value="${detail.id}" readonly>
                                        <div class="invalid-feedback">
                                            Please do not leave the description empty.
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="title">Title</label>
                                            <input value="${detail.title}" name="title" type="text" class="form-control" id="title" required>
                                            <div class="invalid-feedback">
                                                Valid title is required.
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="author">Author</label>
                                            <input value="${detail.author}" name="author" type="text" class="form-control" id="author" required>
                                            <div class="invalid-feedback">
                                                Valid author is required.
                                            </div>
                                        </div>
                                    </div>
        
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="genre">Genre</label>
                                            <select style="cursor: pointer" class="form-control" id="genre" required>
                                                <option value="${detail.genre}">Choose...</option>
        <c:forEach items="${listG}" var="g">
            <option ${detail.id} value="${g.id}">${g.genre}</option>
        </c:forEach>
    </select>
    <div class="invalid-feedback">
        Valid genre is required.
    </div>
</div>
<div class="col-md-6 mb-3">
    <label for="publicationDate">Publication Date (Optional)</label>
    <input value="${detail.publicationDate}" style="cursor: pointer" name="publicationDate" type="date" class="form-control" id="publicationDate" required>
</div>
<div class="invalid-feedback">
    Valid date is required.
</div>
</div>

<div class="mb-3">
<label for="description">Book Description</label>
<textarea name="description" type="text" class="form-control" id="description" ${detail.description} required></textarea>
<div class="invalid-feedback">
    Please do not leave the description empty.
</div>
</div>

<div class="row">


<div class="col-md-6 mb-3">
    <label for="price" class="form-label">Price</label>
    <div class="input-group has-validation">
        <span class="input-group-text">$</span>
        <input value="${detail.price}" name="price" type="number" step="0.01" min="0.01" class="form-control" id="price" required>
        <div class="invalid-feedback">
            Please enter a valid price.
        </div>
    </div>
</div>
<div class="col-md-6 mb-3">
    <label for="quantity">Quantity</label>
    <input name="quantity" type="number" step="0.01" min="0.01" class="form-control" id="quantity" value="${detail.quantity}" required>
    <div class="invalid-feedback">
        Please provide a valid quantity for the product.
    </div>
</div>
</div>
<div class="row">
<div class="col-md-6 mb-3">
    <label for="image">Image</label>
    <input style="cursor: pointer" name="image" type="file" class="form-control" id="image" placeholder="" accept="image/*" required>
    <div class="invalid-feedback">
        Image required.
    </div>
</div>
<div class="col-md-6 mb-3">
    <label for="rating">Average Rating <span class="text-muted">(Optional)</span></label>
    <input value="${detail.rating}" name="rating" type="number" step="0.01" min="0.01" class="form-control" id="rating">
    <div class="invalid-feedback">
        Rating required.
    </div>
</div>
</div>
<hr class="mb-4">
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="same-address">
                            <label class="custom-control-label" for="same-address">Shipping address is the same as my billing address</label>
                        </div>
<button class="btn btn-primary btn-lg btn-block" type="submit">Save Product</button>
</form>
</div>
</div>
</div>
</div>
</form>
Modal Edit End -->


        <jsp:include page="template/footer.jsp"></jsp:include>
        <jsp:include page="template/js-lib-template.jsp"></jsp:include>
    </body>
</html>
