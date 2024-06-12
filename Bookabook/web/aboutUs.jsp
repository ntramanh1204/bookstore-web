<%-- 
    Document   : contact
    Created on : Mar 9, 2024, 4:12:16 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About us</title>
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
                <h1 class="text-center text-white display-6">About Us</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <!--<li class="breadcrumb-item"><a href="#">Pages</a></li>-->
                    <li class="breadcrumb-item active text-white">About Us</li>
                </ol>
            </div>
            <!-- Single Page Header End -->


            <!-- Contact Start -->
            <div class="container-fluid contact py-5">
                <div class="container py-5">
                    <div class="p-5 bg-light rounded">
                        <div class="row g-4">
                            <div class="col-12">
                                <div class="text-center mx-auto" style="max-width: 700px;">
                                    <h1 class="text-primary">Bookabook</h1>
                                    <p class="mb-4">Welcome to our Bookabook! 
                                        Immerse yourself in a literary haven where you can embark on new adventures, 
                                        expand your knowledge, and find the perfect book to captivate your imagination.</p>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <p class="mb-4">
                                    This is my final project for the Java Web Application Development course (PRJ301) at FPT University. 
                                    I poured my heart and soul into it (including some late nights that were, let's be honest, pretty exhausting!), 
                                    but it might still be a bit rough around the edges. Hopefully, you'll find something interesting here! 
                                    Feel free to reach out to me with any questions.
                                    
                                </p>
                            </div>
                            <div class="col-lg-6">
                                <div class="d-flex p-4 rounded mb-4 bg-white">
                                    <i class="fas fa-map-marker-alt fa-2x text-primary me-4"></i>
                                    <div>
                                        <h4>Address</h4>
                                        <p class="mb-2">Thach That, Ha Noi</p>
                                    </div>
                                </div>
                                <div class="d-flex p-4 rounded mb-4 bg-white">
                                    <i class="fas fa-envelope fa-2x text-primary me-4"></i>
                                    <div>
                                        <h4>Contact</h4>
                                        <p class="mb-2">AnhNTHE182498@fpt.edu.vn</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Contact End -->

        <jsp:include page="template/footer.jsp"></jsp:include>
        <jsp:include page="template/js-lib-template.jsp"></jsp:include>
    </body>
</html>
