<%--
  Created by IntelliJ IDEA.
  User: alvindn
  Date: 4/13/18
  Time: 6:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.*" %>
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
    Your Shopping Cart
</div>
<div id="movieTable">
    <table border="1">
        <tr>
            <th>Movie</th>
            <th>Current Quantity</th>
            <th>Change Quantity</th>
            <th>Remove From Cart</th>
        </tr>
        <%for(Map.Entry<String,Integer> entry : ((Map<String,Integer>)request.getAttribute("userCart")).entrySet()) { %>
            <tr>
                <th>
                    <%=entry.getKey()%>
                </th>
                <th>
                    Qty: <%=entry.getValue()%>
                </th>
                <th>
                    <form action="checkout" method="get">
                        <label for="add">Enter quantity: </label>
                        <input type="number" name="quantity" id="add" maxlength="2" required="[1-9]" min="1" max="99">
                        <input type="hidden" name="movie" value="<%=entry.getKey()%>">
                        <input type="hidden" name="remove" value="">
                        <input type="image" name="addCart" src="add.gif" alt="Add to Cart">
                        <img alt="" width="1" height="1" src="add.gif">
                    </form>
                </th>
                <th>
                    <form action="checkout" method="get">
                        <input type="hidden" name="quantity" value="0">
                        <input type="hidden" name="movie" value="<%=entry.getKey()%>">
                        <input type="submit" name="remove" value="Remove">
                    </form>
                </th>
            </tr>
        <%}%>
    </table>
    <button onclick="location.href='./customerID'" type="button" class="checkoutButton">Checkout</button>
</div>
</body>
</html>
