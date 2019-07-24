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
<%@ page import="javax.management.QueryEval" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%// Create a new connection to database
    Context initCtx = new InitialContext();
    Context envCtx = (Context) initCtx.lookup("java:comp/env");
    DataSource ds = (DataSource) envCtx.lookup("jdbc/moviedb");

    Connection connection = ds.getConnection();






    String star = request.getParameter("star");

    String starQuery = "SELECT DISTINCT stars.name AS name, stars.birthYear AS year " +
            "FROM movies " +
            "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
            "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
            "WHERE stars.name = ? ";

    String starMovies = "SELECT DISTINCT title AS title, rating AS rating " +
            "FROM movies " +
            "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
            "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
            "LEFT JOIN ratings ON ratings.movieId = movies.id " +
            "WHERE stars.name = ? ";

    PreparedStatement statement = connection.prepareStatement(starQuery);
    PreparedStatement statement2 = connection.prepareStatement(starMovies);

    statement.setString(1,star);
    statement2.setString(1,star);

    // execute query
    ResultSet rs = statement.executeQuery();
    ResultSet rs2 = statement2.executeQuery();

    ResultSetMetaData metadata = rs.getMetaData();
    ResultSetMetaData metadata2 = rs2.getMetaData();
//
//    ArrayList<String> allGenres = new ArrayList<>();
//
//    while (rs.next()) {
//        String genres = rs.getString("name");
//        allGenres.add(genres);
//    }

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
        <a class="home" href="./">Fablix</a>
    </div>
    <div class="leftMenu">
        <ul>
            <li>
                <a class="moviesSelect" href="./searching">Advanced Search</a>
            </li>
            <li>
                <a class="tv" href="./browse">Browse</a>
            </li>
            <li>
                <a class="topRate" href="./movielist">Top 20 Rated</a>
            </li>
        </ul>
    </div>
    <div class="rightMenu">
        <ul>
            <li>
                <a class="user" href="./cart">Checkout</a>
            </li>
        </ul>
    </div>
</div>
<div id="top20">
    Star Page
</div>
<div id="movieTable">
    <table border="1">
        <tr>
            <% for(int i = 1; i <= metadata.getColumnCount(); i++) {%>
            <th>
                <%=metadata.getColumnName(i)%>
            </th>
            <%}%>
        </tr>
        <%while(rs.next()){%>
        <tr>
            <%for(int i=1; i<= metadata.getColumnCount();i++) {%>
            <%--<%if(i==3 || i==6) {--%>

            <%--%><th><a href="index.html"><%=rs.getString(i)%></a></th>--%>
            <%--<%} else {%>--%>
            <%if(rs.getString(i)==null) {
                String na = "Year Not Available";%>
                <th>
                    <%=na%>
                </th>
            <%} else {%>
                <th>
                    <%=rs.getString(i)%>
                </th>
            <%}%>
        <%}%>
        <%}%>
        </tr>
    </table>

    <table border="1">
        <tr>
            <% for(int i = 1; i <= metadata2.getColumnCount(); i++) {%>
            <th>
                <%=metadata2.getColumnName(i)%>
            </th>
            <%}%>
        </tr>
    </br>
        <%while(rs2.next()){%>
        <tr>
            <%for(int j=1; j <= metadata2.getColumnCount();j++) {%>
                <%if(j == 1) {%>
                    <th>
                        <a href="./form?title=<%=rs2.getString(j)%>&year=&director=&star=&pages=10&sort=ta&initial=0&genre=&char="><%=rs2.getString(j)%></a>
                    </th>
                <%} else {%>
                    <th>
                        <%=rs2.getString(j)%>
                    </th>
                <%}%>
            <%}%>
        <%}%>
        </tr>
    </table>

</body>
</html>

<%rs.close();%>
