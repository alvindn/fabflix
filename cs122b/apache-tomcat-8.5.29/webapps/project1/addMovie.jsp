<%--
  Created by IntelliJ IDEA.
  User: alvindn
  Date: 4/13/18
  Time: 6:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%// Create a new connection to database
    Context initCtx = new InitialContext();
    Context envCtx = (Context) initCtx.lookup("java:comp/env");
    DataSource ds = (DataSource) envCtx.lookup("jdbc/moviedb");

    Connection connection = ds.getConnection();
    Statement statement = connection.createStatement();



%>


<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Fablix</title>
    <link rel="stylesheet" href="index.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Merriweather:900|
        Raleway:500|Rubik|Philosopher:400|Inconsolata:400|Gugi:400|Muli|Anton|Mina" rel="stylesheet">
</head>

<body>
<div id="header">
    <div class="logo">
        <a class="home" href="./employee.html">Fablix</a>
    </div>
    <div class="leftMenu">
        <ul>
            <li>
                <a class="moviesSelect" href="./newStar">Add Star</a>
            </li>
            <li>
                <a class="tv" href="./addMovie">Add Movie</a>
            </li>
            <li>
                <a class="topRate" href="./metadata">Metadata</a>
            </li>
        </ul>
    </div>
    <div class="rightMenu">
        <ul>
            <li>
                <a class="user" href="./index.html">Home</a>
            </li>
        </ul>
    </div>
</div>
<div class="search1">
    <form action="postAdd" method="GET">
        <input type="text" class="searchBox1" name="title" placeholder="Movie Title..." required>
        <input type="text" class="searchBox1" name="year" placeholder="Movie Year" required>
        <input type="text" class="searchBox1" name="director" placeholder="Director Name..." required>
        <input type="text" class="searchBox1" name="star" placeholder="Star Name..." required>
        <input type="text" class="searchBox1" name="birth" placeholder="Birth year (optional)...">
        <input type="text" class="searchBox1" name="genre" placeholder="Genre Name..." required>
        <button type="submit" class="searchButton">Add Movie</button>
    </form>
</div>
</body>
</html>
