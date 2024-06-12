<%-- 
    Document   : manageAccount
    Created on : Mar 10, 2024, 12:53:56 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Accounts</title>
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
        <script type="text/javascript">
            function doDelete(username, name) {
                if (confirm("Do you want to delete account '" + name + "' with username '" + username + "'?")) {
                    window.location = "adminDeleteAccount?username=" + username;
                }
            }
        </script>
    </head>
    <body>
        <jsp:include page="template/menu.jsp"></jsp:include>

            <!-- Single Page Header start -->
            <div class="container-fluid page-header py-5">
                <h1 class="text-center text-white display-6">Manage Accounts</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                    <li class="breadcrumb-item active text-white">Manage</li>
                    <li class="breadcrumb-item active text-white">Manage Accounts</li>
                </ol>
            </div>
            <!-- Single Page Header End -->


            <!-- Cart Page Start -->
            <div class="container-fluid py-5">
                <div class="container py-5">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Name</th>
                                    <th scope="col">Phone</th>
                                    <th scope="col">Username</th>
                                    <th scope="col">Password</th>
                                    <th scope="col">Admin</th>
                                    <th scope="col">Address</th>
                                    <th scope="col">Edit</th>
                                    <th scope="col">Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listA}" var="a">
                                <tr>
                                    <th scope="row">
                                        <p class="mb-0 mt-4">${a.name}</p>
                                    </th>
                                    <td>
                                        <p class="mb-0 mt-4">${a.phone}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${a.username}</p>
                                    </td>
                                    <td>
                                        <div class="input-group quantity mt-4" style="width: 75px;">
                                            <input type="password" class="form-control form-control-sm text-center border-0" value="123456" readonly>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="checkbox" name="myCheckbox" id="myCheckbox" <c:if test="${a.isAdmin == 1}">checked</c:if> disabled/>
                                        </td>
                                        <td>
                                            <p class="mb-0 mt-4">${a.address}</p>
                                    </td>
                                    <td>
                                        <form action="editAccount">
                                            <input type="hidden" name="username" value="${a.username}">
                                            <button type="submit" class="btn btn-md rounded-circle bg-light border mt-4">
                                                <i class="fa fa-pencil-alt text-primary"></i>
                                            </button> 
                                        </form>
                                    </td>
                                    <td>
                                        <c:if test="${a.isAdmin != 1}">
                                            <button class="btn btn-md rounded-circle bg-light border mt-4">
                                                <a href="#" onclick="doDelete('${a.username}', '${a.name}')"><i class="fa fa-times text-danger"></i></a>
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- Cart Page End -->

        <jsp:include page="template/footer.jsp"></jsp:include>
        <jsp:include page="template/js-lib-template.jsp"></jsp:include>
    </body>
</html>
