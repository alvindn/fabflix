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

    String genreQuery = "SELECT name FROM genres WHERE id IN (SELECT genreId FROM genres_in_movies,movies WHERE genres_in_movies.movieId = movies.id)";

    // execute query
    ResultSet rs = statement.executeQuery(genreQuery);

    ResultSetMetaData metadata = rs.getMetaData();
//
//    ArrayList<String> allGenres = new ArrayList<>();
//
//    while (rs.next()) {
//        String genres = rs.getString("name");
//        allGenres.add(genres);
//    }


    String[] alpha = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
    String[] nums = {"0","1","2","3","4","5","6","7","8","9"};


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
    Genre Search
</div>
<div id="movieTable">
    <table>
        <%while(rs.next()){%>
        <tr>
            <%for(int i=1; i<= metadata.getColumnCount();i++) {%>
            <th>
                <a href="./form?title=&year=&director=&star=&pages=10&sort=ta&initial=0&genre=<%=rs.getString(i)%>&char="><%=rs.getString(i)%></a>
            </th>
            <%}%>
            <%}%>
        </tr>
        <%--<%}%>--%>
    </table>
</br>
</div>
<div id="top20">
    Title Search
</div>
<div id="movieTable">
    <table>
        <tr>
            <%for(int i=0;i<alpha.length;i++) {%>
                <th>
                    <a href="./form?title=&year=&director=&star=&pages=10&sort=ta&initial=0&genre=&char=<%=alpha[i]%>"><%=alpha[i]%></a>
                </th>
            <%}%>
            <%for(int i=0;i<nums.length;i++) {%>
                <th>
                    <a href="./form?title=&year=&director=&star=&pages=10&sort=ta&initial=0&genre=&char=<%=nums[i]%>"><%=nums[i]%></a>
                </th>
            <%}%>
        </tr>
    </table>
</div>
</body>
</html>
<%rs.close();%>