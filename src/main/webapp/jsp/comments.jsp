<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>My blog</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/comment.css" rel="stylesheet">
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
                <div class="blog-post">
                    <h2 class="blog-post-title">${post.title}</h2>
                    <p class="blog-post-meta"><fmt:setLocale value="en_US"/><fmt:formatDate type="both" value="${post.postDate}"/> by ${post.author.login}</p>
                    <p>${post.content}</p>
                    <hr/>
                </div>
                <div class="container">
                    <h4 id="addComment">Leave a Comment:</h4>
                    <c:choose>
                        <c:when test="${empty currentUser}">
                            <textarea type="text" class="form-control well" disabled="true" required="true">Please sign in to add comments!</textarea>
                        </c:when>
                        <c:otherwise>
                            <form action="CommentsServlet" method="POST" id="newComment" role="form" >
                                <textarea type="text" id="commentContent" name="postContent" class="form-control well" required="true"></textarea>
                                <input type="hidden" id="addComment" name="action" value="addComment">
                                <input type="hidden" id="currentPost" name="currentPost" value="${post.postId}">
                                <button class="btn btn-primary" type="submit">Submit</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                    <hr>
                    <c:choose>
                        <c:when test="${not empty listOfComments}">
                            <c:forEach var="comment" items="${listOfComments}">
                                <ul class="media-list comments">
                                    <li class="media">
                                        <div class="media-body">
                                            <h5 class="media-heading pull-left">${comment.author.login}, <fmt:setLocale value="en_US"/><fmt:formatDate type="both" value="${comment.commnetDate}"/></h5>
                                            <p class="well">${comment.content}</p>
                                        </div>
                                    </li> 
                                </ul>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            There are no comments to show
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </body>
</html>
