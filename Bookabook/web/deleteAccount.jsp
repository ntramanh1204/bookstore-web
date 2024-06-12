<%-- 
    Document   : deleteAccount
    Created on : Mar 5, 2024, 2:15:16 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Account</title>
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

            <script type="text/javascript">
                function doDelete(username) {
                    if (confirm("Do you want to permanently delete the account with username '" + username + "'?")) {
                        var xhr = new XMLHttpRequest();
                        xhr.open("POST", "deleteAccount", true);
                        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        xhr.onreadystatechange = function () {
                            if (xhr.readyState === XMLHttpRequest.DONE) {
                                if (xhr.status === 200) {
                                    // Handle the successful response here
                                    console.log("Account deleted successfully");
                                } else {
                                    // Handle the error response here
                                    console.log("Error deleting account");
                                }
                            }
                        };
                        xhr.send("username=" + encodeURIComponent(username));
                    }
                }
            </script>



            <!--Delete Form start-->
            <main class="form-signin d-flex justify-content-center align-items-center" style="height: 100vh;">
                <form style="width: 25em;" action="deleteAccount" method="post">
                    <h1 class="h3 mb-3 fw-normal">Delete Account ${sessionScope.account.username}</h1>

                <div class="form-floating">
                    <input value="${username}" name="user" type="text" class="form-control" id="floatingInput" placeholder="Username">
                    <label for="floatingInput">Username</label>
                </div>
                <div class="form-floating">
                    <input name="pass" type="password" class="form-control" id="floatingPassword" placeholder="Password">
                    <label for="floatingPassword">Password</label>
                </div>
                <p class="text-danger">${error}</p>
                <button class="btn btn-danger w-100 py-2" onclick="doDelete('${sessionScope.account.username}')">Delete</button>
                <hr>
                <p class="message"><a href="profile">Return to profile page</a></p>
            </form>
        </main>
        <!--Delete Form End-->

        <jsp:include page="template/footer.jsp"></jsp:include>
        <jsp:include page="template/js-lib-template.jsp"></jsp:include>
    </body>
</html>
