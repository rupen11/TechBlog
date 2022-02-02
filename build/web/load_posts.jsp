<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%
    PostDao pd = new PostDao(ConnectionProvider.getConnection());

    int cid = Integer.parseInt(request.getParameter("cid"));

    List<Post> post = null;

    if (cid == 0) {
        post = pd.getAllPost();
    } else {
        post = pd.getAllPost(cid);
    }

    if (post.size() == 0) {
        out.println("<h3 class='display-3 text-center'>No Posts in this Category</h3>");
    }

    for (Post p : post) {
%>
<div class="col-md-6 mb-4">
    <div class="card">
        <img class="card-img-top" src="blog_pic/<%= p.getpPic()%>" alt="Card image cap" style="height: 180px;">
        <div class="card-body">
            <b><%= p.getpTitle()%></b>
            <p><%= p.getpContent()%></p>
        </div>
        <div class="card-footer bg-light text-white text-center">
            <%
                LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
            %>
            <a class="mx-1 btn btn-outline-dark btn-sm" onClick="doLike(<%= p.getPid()%>, <%= user.getId()%>)"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%= ldao.countLikeOnPost(p.getPid())%></span></a>
            <a href="blog_page.jsp?post_id=<%= p.getPid()%>" class="mx-1 btn btn-outline-dark btn-sm">Read More</a>
            <a class="mx-1 btn btn-outline-dark btn-sm"><i class="fa fa-comment-o"></i> 20</a>
        </div>
    </div>
</div>
<%}%>