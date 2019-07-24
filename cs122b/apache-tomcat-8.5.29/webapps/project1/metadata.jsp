<%--
  Created by IntelliJ IDEA.
  User: alvindn
  Date: 4/13/18
  Time: 6:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
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

    String query = "SELECT table_name AS table_name, column_name AS attribute_name, data_type AS data_type " +
            "  FROM information_schema.columns " +
            "  WHERE (table_name = 'customers' OR table_name = 'creditcards' OR table_name = 'employees' " +
            "  OR table_name = 'genres' OR table_name = 'genres_in_movies' OR table_name = 'movies' OR table_name = 'ratings' " +
            "  OR table_name = 'sales' OR table_name = 'stars_in_movies' OR table_name = 'customers') " +
            "  ORDER BY table_name";

    // Retrieve parameter "name" from the http request, which refers to the value of <input name="name"> in index.html

    ResultSet rs = statement.executeQuery(query);
    ResultSetMetaData metadata = rs.getMetaData();


%>


<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Fablix</title>
    <link rel="stylesheet" href="search.css">

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
<%--<div class="search">--%>
<%--<form action="form" method="GET">--%>
<%--<input type="text" class="searchBox" name="title" placeholder="Search movies...">--%>
<%--<input type="text" class="searchBox" name="year" placeholder="Search movies...">--%>
<%--<input type="text" class="searchBox" name="director" placeholder="Search movies...">--%>
<%--<input type="text" class="searchBox" name="star" placeholder="Search movies...">--%>
<%--<button type="submit" class="searchButton">Search</button>--%>
<%--</form>--%>
<%--</div>--%>
<div id="top20">
    Metadata Results
</div>
<div id="movieTable">
    <table border="1">
        <tr>
            <% for(int i = 1; i <= metadata.getColumnCount(); i++) {%>
            <th bgcolor="red">
                <%=metadata.getColumnName(i)%>
            </th>
            <%}%>
        </tr>
        <%while(rs.next()){%>
        <tr>
            <%for(int i=1; i<= metadata.getColumnCount();i++) {%>
                <th>
                <%=rs.getString(i)%>
                </th>
            <%}%>
        </tr>
        <%}%>
    </table>
</div>
</body>
</html>

<%--<%rs.close();%>--%>