<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>My blog</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/register.css" rel="stylesheet"
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
        <div class="container">
            <c:if test="${not empty message}">
                <div class="alert alert-danger" role="alert">
                    <strong>Error!</strong> ${message}
                </div>
            </c:if>
            <form class="form-signin" method="POST" action="RegisterServlet">
                <h2 class="form-signin-heading">New account</h2>
                <label for="inputLogin" class="sr-only">Login</label>
                <input type="text" id="inputLogin" class="form-control" name="inputLogin" placeholder="Login" required autofocus>
                <label for="inputPassword" class="sr-only">Password</label>
                <input type="password" id="inputPassword" class="form-control" name="inputPassword" placeholder="Password" required>
                <label for="repeatPassword" class="sr-only">Repeat password</label>
                <input type="password" id="repeatPassword" class="form-control" name="repeatPassword" placeholder="Repeat password" required>
                <input type="hidden" id="registerAction" name="action" value="registerAction">
                <button class="btn btn-lg btn-primary btn-block" id="submit" type="submit">Sign in</button>
            </form>
        </div> 

    </body>
</html>
