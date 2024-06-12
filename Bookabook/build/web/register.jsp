<%-- 
    Document   : login
    Created on : Feb 20, 2024, 9:48:11 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
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
                <h1 class="text-center text-white display-6">Register</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                    <li class="breadcrumb-item active text-white">Register</li>
                </ol>
            </div>
            <!-- Single Page Header End -->

            <!--Register Form Start-->
            <div class="container" style="margin-top: 3em;">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="row">
                            <h4>Please fill in your information</h4>
                        </div>
                        <form action="register" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Full Name</label>
                                    <input name="name" type="text" class="form-control" id="name" placeholder="" required>
                                    <div class="invalid-feedback">
                                        Valid name is required.
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="username" class="form-label">Username</label>
                                    <div class="input-group has-validation">
                                        <span class="input-group-text">@</span>
                                        <input name="user" type="text" class="form-control" id="username" placeholder="Username" required>
                                        <div class="invalid-feedback">
                                            Your username is required.
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input name="email" type="email" class="form-control" id="email" placeholder="name@example.com" required>
                                    <div class="invalid-feedback">
                                        Please enter a valid email address for shipping updates.
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="phone" class="form-label">Phone</label>
                                    <input name="phone" maxlength="11" pattern="[0-9]{1,11}" type="tel" class="form-control" id="phone" placeholder="" required>
                                    <div class="invalid-feedback">
                                        Valid phone is required.
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <label for="address" class="form-label">Address</label>
                                    <input name="address" type="text" class="form-control" id="address" placeholder="Address" required>
                                    <div class="invalid-feedback">
                                        Please enter a valid address.
                                    </div>
                                </div>
                            </div>



                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-label" for="password">Password</label>
                                    <div class="input-group">
                                        <input name="pass" type="password" class="form-control" id="password" placeholder="Password" required>
                                        <div class="invalid-feedback">
                                            Please enter a password.
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label" for="confirmPassword">Confirm Password</label>
                                    <input name="repass" type="password" class="form-control" id="confirmPassword" placeholder="Confirm Password">
                                </div>
                            </div>
                            <p class="text-danger">${error}</p>
                        <p class="text-danger">${pwdError}</p>

                        <button class="btn btn-primary w-100 py-2" type="submit">Create new account</button>
                        <hr>
                        <p class="message">Already registered? <a href="login">Log In</a></p>
                    </form>
                </div>
            </div>
        </div>
        <!--Register Form End-->

        <jsp:include page="template/footer.jsp"></jsp:include>

        <jsp:include page="template/js-lib-template.jsp"></jsp:include>

    </body>

</html>