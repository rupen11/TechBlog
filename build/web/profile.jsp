<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <title>Profile</title>
        <script src="./js/myjs.js"></script>
    </head>
    <body>
        <!--Navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Techblog</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="profile.jsp">Pofile</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav mr-right">
                        <li class="nav-item mx-3">
                            <a class="nav-link" href="" data-bs-toggle="modal" data-bs-target="#exampleModal"> <span class="fa fa-user-circle "></span> <%= user.getName()%></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="" data-bs-toggle="modal" data-bs-target="#modelPost"> <span class="fa fa-diamond"></span> Post</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Logoutservlet"> <span class="fa fa-user-plus "></span> Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!--end navbar-->


        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {

        %>
        <div class="alert <%= m.getCss()%> alert-dismissible fade show" role="alert">
            <%= m.getContent()%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%
                session.removeAttribute("msg");
            }
        %>

        <!--Main body-->

        <div class="container">
            <div class="row mt-4">
                <!--first column-->
                <div class="col-md-4">
                    <div class="list-group">
                        <a href="#" class="cat-link list-group-item list-group-item-action bg-dark text-white" onClick="getPosts(0, this)" aria-current="true">
                            All Post
                        </a>

                        <!--get category list-->
                        <%
                            PostDao postd = new PostDao(ConnectionProvider.getConnection());
                            ArrayList<Category> categoryList = postd.getAllCategories();
                            for (Category cat : categoryList) {
                        %>
                        <a href="#" class="cat-link list-group-item list-group-item-action" onClick="getPosts(<%= cat.getCid()%>, this)"><%= cat.getName()%></a>
                        <%}%>

                    </div>
                </div>
                <!--end first column-->
                <!--second column-->
                <div class="col-md-8">
                    <div class="text-center" id="loader">
                        <i class="fa fa-circle-o-notch fa-4x fa-spin"></i>
                        <h4 class="mt-3">Loading...</h4>
                    </div>
                    <div class="container-fluid" id="post__container">
                        <div class="row" id="posts"></div>
                    </div>
                </div>
                <!--end second column-->
            </div>
        </div>

        <!--End main body-->

        <!--Model Post-->
        <div class="modal fade" id="modelPost" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">What's in your mind?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="AddPostServlet" id="postForm" method="post" enctype="multipart/form-data">
                            <select class="form-control mt-3" name="catId">
                                <option selected disabled>Select Category</option>
                                <%
                                    PostDao pd = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = pd.getAllCategories();
                                    for (Category c : list) {
                                %>
                                <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                                <%
                                    }
                                %>
                            </select>
                            <input type="text" name="title" class="form-control mt-3" placeholder="Title"/>
                            <textarea rows="5" name="description" class="form-control mt-3" placeholder="Enter Some Description..."></textarea>
                            <textarea rows="5" name="code" class="form-control mt-3" placeholder="Enter Some Code..."></textarea>
                            <input type="file" name="file" class="form-control mt-3"/>
                            <div class="text-center mt-3">
                                <button type="submit" class="btn btn-dark">Post</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!--Model-->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Your Profile</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center">
                        <img src="pics/<%= user.getProfileimage()%>" alt="userimage" style="border-radius: 50%; width: 100px; height:100px; margin-bottom: 1rem;">
                        <div id="profilDetails">
                            <h5><%= user.getName()%></h5>
                            <table class="table table-hover">
                                <tbody>
                                    <tr>
                                        <th>Id:</th>
                                        <td><%= user.getId()%></td>
                                    </tr>
                                    <tr>
                                        <th>Email:</th>
                                        <td><%= user.getEmail()%></td>
                                    </tr>
                                    <tr>
                                        <th>Gender:</th>
                                        <td><%= user.getGender()%></td>
                                    </tr>
                                    <tr>
                                        <th>Status:</th>
                                        <td><%= user.getAbout()%></td>
                                    </tr>
                                    <tr>
                                        <th>Registered on:</th>
                                        <td><%= user.getDateTime()%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div id="profileEdit" style="display: none;">
                            <h5>Edit Profile</h5>
                            <form action="Editservlet" method="post" enctype="multipart/form-data">
                                <table class="table table-hover table-sm">
                                    <tbody>
                                        <tr>
                                            <th>Id:</th>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th>Name:</th>
                                            <td>
                                                <input class="form-control" type="text" name="user_name" value="<%= user.getName()%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Email:</th>
                                            <td>
                                                <input class="form-control" type="email" name="user_email" value="<%= user.getEmail()%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Password:</th>
                                            <td>
                                                <input class="form-control" type="text" name="user_password" value="<%= user.getPassword()%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Gender:</th>
                                            <td><%= user.getGender()%></td>
                                        </tr>
                                        <tr>
                                            <th>Status:</th>
                                            <td>
                                                <textarea class="form-control" rows="2" name="about"> <%= user.getAbout()%></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Profile Image</th>
                                            <td>
                                                <input class="form-control" type="file" name="profileimage">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Registered on:</th>
                                            <td><%= user.getDateTime()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <button type="submit" class="btn btn-success btn-sm" id="saveEditProfile">SAVE</button>
                            </form>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">CLOSE</button>
                        <button type="button" class="btn btn-danger btn-sm" id="showEditProfile">EDIT</button>
                    </div>
                </div>
            </div>
        </div>
        <!--end model-->





        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>





        <script>
                            $(document).ready(() => {
                                let toggleProfile = false;
                                $("#showEditProfile").click(() => {
                                    console.log("ok");
                                    if (toggleProfile == false) {
                                        $("#showEditProfile").text("Back");
                                        $("#profilDetails").hide();
                                        $("#profileEdit").show();
                                        toggleProfile = true;
                                    } else {
                                        $("#showEditProfile").text("EDIT");
                                        $("#profileEdit").hide();
                                        $("#profilDetails").show();
                                        toggleProfile = false;
                                    }
                                });
                            });
        </script>

        <!--Post-->
        <script>
            $(document).ready(function (e) {
                $("#postForm").on("submit", function (event) {
                    event.preventDefault();
                    let form = new FormData(this);
                    $.ajax({
                        url: "AddPostServlet",
                        type: "POST",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            if (data.trim() === "Done") {
                                swal({
                                    title: "Post Created",
                                    text: "Creating Post Finish",
                                    icon: "success",
                                    button: "Ok",
                                });
                            } else {
                                swal({
                                    title: "Post Not Created",
                                    text: "Please Try Again Later",
                                    icon: "warning",
                                    button: "Ok",
                                });
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>

        <!--loading post using ajax-->
        <script>
            function getPosts(cartId, cur) {

                $(".cat-link").removeClass("bg-dark text-white");
                $(cur).addClass("bg-dark text-white");




                $("#post__container").hide();
                $("#loader").show();
                $.ajax({
                    url: "load_posts.jsp",
                    data: {cid: cartId},
                    success: function (data, textStatus, jqXHR) {
                        $("#loader").hide();
                        $("#post__container").show();
                        $("#posts").html(data);
                    }
                });
            }

            $(document).ready(function (e) {
                let firstLink = $('.cat-link')[0];
                getPosts(0, firstLink);
            });
        </script>
    </body>
</html>
