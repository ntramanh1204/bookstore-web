<%-- 
    Document   : editAccount
    Created on : Mar 10, 2024, 12:51:34 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Account</title>
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
            function togglePasswordVisibility() {
                var passwordInput = document.getElementById('password');
                var showPasswordBtn = document.getElementById('showPasswordBtn');

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    showPasswordBtn.textContent = 'Hide';
                } else {
                    passwordInput.type = 'password';
                    showPasswordBtn.textContent = 'Show';
                }
            }
        </script>

    </head>
    <body>
        <jsp:include page="template/menu.jsp"></jsp:include>

            <!-- Single Page Header start -->
            <div class="container-fluid page-header py-5">
                <h1 class="text-center text-white display-6">Edit Account Detail</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                    <li class="breadcrumb-item active text-white">Edit Accounts</li>
                </ol>
            </div>
            <!-- Single Page Header End -->

            <!--Modal Edit Start--> 
            <form action="editAccount" method="post">
                <div class="row" style="margin: 3%">
                    <h4 class="mb-3">Account Information</h4>
                <c:set value="${requestScope.account}" var="a"/>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="username">Username</label>
                        <input value="${a.username}" name="username" type="text" class="form-control" id="username" readonly>
                        <div class="invalid-feedback">
                            Valid username is required.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="password">Password</label>
                        <div class="input-group">
                            <input value="${a.password}" name="password" type="password" class="form-control" id="password" required>
                            <button type="button" id="showPasswordBtn" class="btn btn-secondary" onclick="togglePasswordVisibility()">Show</button>
                        </div>
                        <div class="invalid-feedback">
                            Valid password is required.
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="name">Name</label>
                    <input name="name" value="${a.name}" type="text" class="form-control" id="name" required>
                    <div class="invalid-feedback">
                        Please do not leave the name field empty.
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="email">Email Address</label>
                        <input value="${a.email}" name="email" type="email" class="form-control" id="email">
                        <div class="invalid-feedback">
                            Valid email address is required.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="phone">Phone Number</label>
                        <input value="${a.phone}" name="phone" type="tel" class="form-control" id="phone">
                        <div class="invalid-feedback">
                            Valid phone number is required.
                        </div>
                    </div>
                </div><div class="mb-3">
                    <label for="address">Address</label>
                    <input value="${a.address}" name="address" type="text" class="form-control" id="address">
                    <div class="invalid-feedback">
                        Please do not leave the address field empty.
                    </div>
                </div>
                <button class="btn btn-primary btn-lg btn-block" type="submit">Update Account Detail</button>
                <p>Back to <a href="manageAccount">Manage Account</a> Page</p>
            </div>
        </form>
        <!--Modal Edit End--> 


        <jsp:include page="template/footer.jsp"></jsp:include>
        <jsp:include page="template/js-lib-template.jsp"></jsp:include>
    </body>
</body>
</html>
