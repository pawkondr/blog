<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>My blog</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/blog.css" rel="stylesheet"
    </head>
    <body>
        <script src="js/bootstrap.min.js"></script>

        <!-- Navbar -->
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <a href="MainServlet" class="navbar-brand">My blog</a>
                </div>
                <ul class="nav navbar-nav navbar-right">
                    <c:choose>
                        <c:when test="${empty currentUser}">
                            <li><a href="LoginServlet">Login</a></li>
                            <li><a href="RegisterServlet">Register</a></li>
                            </c:when>
                            <c:otherwise>
                            <li><p class="navbar-text">${currentUser.login}</p></li>
                                <c:if test="${not empty currentUser and currentUser.status == 'admin'}">
                                <li><a href="NewPostServlet">Add post</a></li>
                                </c:if>
                            <li><a href="MainServlet?action=logoutAction">Logout</a></li>
                            </c:otherwise>
                        </c:choose>
                </ul>
            </div>
        </nav>

        <!-- Main Container -->
        <div class="container" role="main">
            <c:if test="${not empty message}">
                <div class="alert alert-success" role="alert">
                    <strong>Success!</strong> ${message}
                </div>
            </c:if>
            <div class="jumbotron">
                <h1>My awesome blog!</h1>
            </div>
            <div class="blog-main">
                <c:choose>
                    <c:when test="${not empty listOfPosts}">
                        <c:forEach var="post" items="${listOfPosts}">
                            <div class="blog-post">
                                <h2 class="blog-post-title">${post.title}</h2>
                                <p class="blog-post-meta"><fmt:setLocale value="en"/><fmt:formatDate type="both" value="${post.postDate}"/> by ${post.author.login}</p>
                                <p>${post.content}</p>
                                <div class="btn-group">
                                    <form action="CommentsServlet" method="POST" id="showCommentsForm" role="form">
                                        <input type="hidden" id="currentPost" name="currentPost" value="${post.postId}">
                                        <input type="hidden" id="showCommentsAction" name="action" value="showCommentsAction">
                                        <button class="btn btn-primary" type="submit">Comments (${fn:length(post.listOfComments)})</button>
                                    </form>
                                    <c:if test="${not empty currentUser and currentUser.status == 'admin'}">
                                        <form action="MainServlet" method="POST" id="showCommentsForm" role="form">
                                            <input type="hidden" id="currentPost" name="currentPost" value="${post.postId}">
                                            <input type="hidden" id="deletePostAction" name="action" value="deletePostAction">
                                            <button type="submit" class="btn btn-primary" onclick="return confirm('Are you sure?');">Delete</button>
                                        </form>
                                    </c:if>
                                </div>
                                <hr/>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        There are no posts to show
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </body>
</html>
