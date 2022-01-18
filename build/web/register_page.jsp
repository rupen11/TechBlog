
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link href="css/signupstyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .clip-path{
                clip-path: polygon(31% 0, 80% 5%, 100% 0, 100% 100%, 65% 100%, 20% 94%, 0 100%, 0 0);
            }
        </style>

    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <main class="primary-background clip-path"  style="padding: 2rem 0">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <form class="myForm">
                            <h2 class="text-center mb-3">Registration here</h2>
                            <hr>
                            <div class="mb-3">
                                <label for="exampleFormControlInput1" class="form-label">Username</label>
                                <input type="text" class="form-control form-control-sm" name="user_name" id="exampleFormControlInput1" placeholder="Username">
                            </div>
                            <div class="mb-3">
                                <label for="exampleFormControlInput1" class="form-label">Email address</label>
                                <input type="email" class="form-control form-control-sm" name="user_email" id="exampleFormControlInput1" placeholder="Email Address">
                            </div>
                            <div class="mb-3">
                                <label for="exampleFormControlInput1" class="form-label">Password</label>
                                <input type="password" class="form-control form-control-sm"name="user_password" id="exampleFormControlInput1" placeholder="Password">
                            </div>
                            <div class="form-check form-check-inline mb-3">
                                <input class="form-check-input" type="radio" name="gender" id="inlineRadio1" value="male">
                                <label class="form-check-label" for="inlineRadio1">Male</label>
                            </div>
                            <div class="form-check form-check-inline mb-3">
                                <input class="form-check-input" type="radio" name="gender" id="inlineRadio2" value="femlae">
                                <label class="form-check-label" for="inlineRadio2">Female</label>
                            </div>
                            <div class="mb-3">
                                <label for="exampleFormControlTextarea1" class="form-label">Describe about youself</label>
                                <textarea class="form-control form-control-sm" id="exampleFormControlTextarea1"name="about" rows="3" placeholder="Enter something about yourself..."></textarea>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" name="check">
                                <label class="form-check-label" for="flexCheckChecked">
                                    Agree Terms and Conditions
                                </label>
                            </div>
                            <div class="container text-center mb-3" id="loader" style="display: none">
                                <div class="container text-center mb-3" id="loader">
                                    <span class="fa fa-refresh fa-spin fa-4x"></span>
                                    <h4>Please wait..</h4>
                                </div>
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-dark btn-sm">Register</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
    <script>
        $(document).ready(function () {
            console.log("ready");
            $(".myForm").on("submit", function (e) {
                e.preventDefault();
                let form = new FormData(this);
                $.ajax({
                    url: "Registerservlet",
                    type: "POST",
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR);
                    },
                    processData: false,
                    contentType: false
                })
            })
        })
                ;

    </script>
</html>
