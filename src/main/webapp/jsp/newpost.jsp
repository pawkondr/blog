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
        <link href="css/newpost.css" rel="stylesheet">
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

            <c:choose>
                <c:when test="${not empty message}">
                    <div class="alert alert-danger" role="alert">
                        <strong>Error!</strong> ${message}
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="jumbotron">
                        <h1>My awesome blog!</h1>
                    </div>

                    <div class="page-header">
                        <h1>New post</h1>
                        <form action="MainServlet" method="POST" id="newPost" role="form" class="newpost">
                            <input type="text" id="postTitle" name="postTitle" class="form-control" placeholder="Title" required="true">
                            <textarea type="text" id="postContent" name="postContent" class="form-control" required="true"></textarea>
                            <input type="hidden" id="newPostAction" name="action" value="newPostAction">
                            <button type="submit" class="btn btn-primary">Send</button>
                        </form>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </body>
</html>
