<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <title>Error</title>
        <style>
            .error_container{
                display: flex;
                flex-direction: column;
                align-items: center;
                background-color: darkslategrey;
                height: 100vh;
                color:white;
                justify-content: center;
            }
            .error_container img{
                width: 300px;
            }
            .error_container p{
                margin: 1rem 0 2rem 0;
                font-size: 1.3rem;
                font-weight: 300;
            }
            .error_container a{
                text-decoration: none;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid error_container">
            <img src="img/error-404.png" class="img-fluid" />
            <h3 class="display-3">Something Went Wrong - Error</h3>
            <p>this is worng so sorry this is page error page and this called this eror </p>
            <button class="btn btn-dark"><a href="index.jsp">Home</a></button>
        </div>




        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
