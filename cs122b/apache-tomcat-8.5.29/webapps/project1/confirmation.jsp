<%--
  Created by IntelliJ IDEA.
  User: alvindn
  Date: 4/13/18
  Time: 6:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%// Create a new connection to database
    Context initCtx = new InitialContext();
    Context envCtx = (Context) initCtx.lookup("java:comp/env");
    DataSource ds = (DataSource) envCtx.lookup("jdbc/moviedb");

    Connection connection = ds.getConnection();


    // Generate SQL String
    String query = "SELECT customers.id AS customerID, customers.firstName AS firstName, customers.lastName AS lastName, " +
                    "customers.ccId AS ccID, creditcards.expiration AS expDate " +
                    "FROM customers " +
                    "INNER JOIN creditcards ON creditcards.id = customers.ccID " +
                    "WHERE customers.firstName = ? AND customers.lastName = ? AND creditcards.id = ? AND creditcards.expiration = ?";

//            Statement statement = dbCon.createStatement();
    PreparedStatement statement = connection.prepareStatement(query);
    Statement statement2 = connection.createStatement();
    Statement statement3 = connection.createStatement();
    Statement statement4 = connection.createStatement();

    // Retrieve parameter "name" from the http request, which refers to the value of <input name="name"> in index.html
    String first = request.getParameter("firstName");
    String last = request.getParameter("lastName");
    String cc = request.getParameter("cc");
    String exp = request.getParameter("exp");

    statement.setString(1,first);
    statement.setString(2,last);
    statement.setString(3,cc);
    statement.setString(4,exp);


//    ((Map<String,Integer>)request.getAttribute("userCart")).remove(title);
    ResultSet rs = statement.executeQuery();
    ResultSetMetaData metadata = rs.getMetaData();
    Date today = new Date();
    SimpleDateFormat dtf = new SimpleDateFormat("yyyy-MM-dd");
    int cusId = 0;



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
    Confirmation Page
</div>
<%if(!rs.first()) {%>
    <h1>Information invalid. Please try again.</h1>
    <button onclick="location.href='./customerID'" type="button">Back</button>
<%} else {%>
    <%rs = statement.executeQuery();
    while(rs.next()) {
        cusId = rs.getInt("customerID");
    }
    LinkedHashMap<String,String> movieIds = new LinkedHashMap<>();
    for(Map.Entry<String,Integer> entry : ((Map<String,Integer>)request.getAttribute("userCart")).entrySet()) {
            String movieId = String.format("SELECT movies.id AS id, movies.title AS title " +
                    "FROM movies " +
                    "WHERE movies.title = '%s' ", entry.getKey());
            ResultSet tempRs = statement3.executeQuery(movieId);
            while(tempRs.next()) {
                movieIds.put(tempRs.getString("id"),tempRs.getString("title"));
            }
    }
    for(Map.Entry<String,String> entry : movieIds.entrySet()) {
        String insertion = String.format("INSERT INTO sales(id,customerId,movieId,saleDate) VALUES (%d, %d, '%s', '%s')",0,cusId,entry.getKey(),dtf.format(today));
        for(int j = 1; j <= ((LinkedHashMap<String,Integer>)request.getAttribute("userCart")).get(entry.getValue()); j++) {
            int i = statement2.executeUpdate(insertion);
            }
        }
    }%>
<div id="movieTable">
    <table border="1">
        <tr>
            <th>Sale ID</th>
            <th>Movie</th>
            <th>Quantity</th>
            <th>Confirmation</th>
        </tr>
        <%String finalCollection = String.format("SELECT sales.id AS sid, sales.movieId AS mid, movies.title AS title " +
                    "FROM sales " +
                    "INNER JOIN movies ON movies.id = sales.movieId " +
                    "WHERE sales.saleDate = '%s' " +
                    "ORDER BY sales.id", dtf.format(today));
            ResultSet collectRs = statement4.executeQuery(finalCollection);
            while(collectRs.next()) {%>
                <tr>
                    <th>
                        <%=collectRs.getInt("sid")%>
                    </th>
                    <th>
                        <%=collectRs.getString("title")%>
                    </th>
                        <%if(((LinkedHashMap<String,Integer>)request.getAttribute("userCart")).containsKey(collectRs.getString("title"))) {
                            int mq = ((LinkedHashMap<String,Integer>)request.getAttribute("userCart")).get(collectRs.getString("title"));
                        %><th><%=mq%></th><%
                        }%>
                    <th>
                        <img src="check.png" height="25" width="25">
                    </th>
                </tr>
            <%}%>
    </table>
</div>
</body>
</html>

<%rs.close();%>
