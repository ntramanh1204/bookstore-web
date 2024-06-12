<%-- 
    Document   : manageOrder
    Created on : Mar 12, 2024, 9:53:39 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Order</title>
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
//            function submitForm() {
//                var form = document.getElementById('form');
//                form.submit();
//            }

            function submitForm(index) {
                var form = document.getElementById('form_' + index);
                form.submit();
            }
        </script>

    </head>
    <body>
        <jsp:include page="template/menu.jsp"></jsp:include>


            <!-- Single Page Header start -->
            <div class="container-fluid page-header py-5">
                <h1 class="text-center text-white display-6">Manage Orders</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                    <!--<li class="breadcrumb-item"><a href="#">Pages</a></li>-->
                    <li class="breadcrumb-item active text-white">Manage Orders</li>
                </ol>
            </div>
            <!-- Single Page Header End -->


            <!-- Cart Page Start -->
            <div class="container-fluid py-5">
                <div class="container py-5">
                    <div class="table-responsive">
                        <span>${requestScope.ms}</span>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Order ID</th>
                                <th scope="col">Account</th>
                                <th scope="col">Order Date</th>
                                <th scope="col">Status</th>
                                <th scope="col">Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.orders}" var="a" varStatus="loop">
                                <tr>
                                    <td>
                                        <p class="mb-0 mt-4">${a.id}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${a.account.username}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${a.orderdate}</p>
                                    </td>
                                    <td>
                                        <form id="form_${loop.index}" action="manageOrder" method="post" class="order-form" style="width: 100px">
                                            <div class="form-group">
                                                <select id="status_${loop.index}" onchange="submitForm(${loop.index})" name="statusList" class="form-control">
                                                    <option value="waiting" ${(a.getStatus()=="waiting") ? 'selected' : ''}>Waiting</option>
                                                    <option value="confirmed" ${(a.getStatus()=="confirmed") ? 'selected' : ''}>Confirmed</option>
                                                    <option value="complete" ${(a.getStatus()=="complete") ? 'selected' : ''}>Complete</option>
                                                    <option value="cancelled" ${(a.getStatus()=="cancelled") ? 'selected' : ''}>Cancelled</option>
                                                </select>
                                            </div>
                                            <input type="hidden" name="orderId" value="${a.id}">
                                        </form>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">
                                            <a href="orderDetail?orderID=${a.id}">
                                                <button class="btn-primary border-info rounded-pill text-success mb-4" type="button">View Detail</button>
                                            </a>
                                        </p>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
<!--                <div class="row g-4 justify-content-end">
                    <div class="col-8"></div>
                    <div class="col-sm-8 col-md-7 col-lg-6 col-xl-4">
                        <div class="bg-light rounded">
                            <div class="p-4">
                                <h1 class="display-6 mb-4">Cart <span class="fw-normal">Total</span></h1>
                            </div>
                            <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                <h5 class="mb-0 ps-4 me-4">Total</h5>
                                <p class="mb-0 pe-4">$${cartTotal}</p>
                            </div>
                            <a href="checkout"><button class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4" type="button">Proceed Checkout</button></a>
                        </div>
                    </div>
                </div>-->
            </div>
        </div>
        <!-- Cart Page End -->

        <jsp:include page="template/footer.jsp"></jsp:include>
        <jsp:include page="template/js-lib-template.jsp"></jsp:include>
    </body>
</html>

