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
<%@ page import="java.math.BigDecimal" %>
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

    // Generate SQL String
    String getMax = "SELECT MAX(id) AS incID FROM stars";

//    String combine = "SELECT CONCAT('nm',@Var) AS newID";
    String query = "INSERT INTO stars(id,name,birthYear) VALUES(?,?,?)";

    String star = request.getParameter("star");
    String birth = request.getParameter("birth");

    Statement statement1 = connection.createStatement();

    ResultSet execMax = statement1.executeQuery(getMax);
    String inc = "";
    while(execMax.next()) {
        inc = execMax.getString("incID").substring(2,execMax.getString("incID").length());
    }
    int intInc = Integer.parseInt(inc);
    intInc++;
    String newInc = Integer.toString(intInc);
    String newID = "nm" + newInc;

    PreparedStatement statement = null;
    statement = connection.prepareStatement(query);

    // Retrieve parameter "name" from the http request, which refers to the value of <input name="name"> in index.html

    statement.setString(1,newID);
    statement.setString(2,star);
    if(birth.equals("")) {
        statement.setNull(3,java.sql.Types.INTEGER);
    }
    else {
        int year = Integer.parseInt(birth);
        statement.setInt(3,year);
    }
    statement.executeUpdate();

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
<div id="top20">
    <%=star%> Successfully Added!
</div>
    <table border="1">

    </table>
</div>
</body>
</html>

