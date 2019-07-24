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


    PreparedStatement statement = null;

    // Retrieve parameter "name" from the http request, which refers to the value of <input name="name"> in index.html
    String title = request.getParameter("title");
    String[] parts = title.split(" ");
    String combined = "";
    for(int i = 0; i < parts.length;i++) {
        combined += "+" + parts[i] + "* ";
    }
    double tempMatch = Math.floorDiv(title.length(),3);
    int match = (int) tempMatch;


    String sort = request.getParameter("sort");
    String genre = request.getParameter("genre");
    String firstChar = request.getParameter("char");
    String y = request.getParameter("year");
    int year = 0;
    String initial = request.getParameter("initial");
    int initialPage = Integer.parseInt(initial);
    int ini = initialPage;
    if(y!="")
    {
        year = Integer.parseInt(y);
    }
    String director = request.getParameter("director");
    String star = request.getParameter("star");
    String pages = request.getParameter("pages");
    int pageNum = Integer.parseInt(pages);
    String qtitle = "%" + title + "%";
    String qdirector = "%" + director + "%";
    String qstar = "%" + star + "%";
    String qgenre = "%" + genre + "%";
    String qFirstChar = firstChar + "%";
    if(!firstChar.equals(""))
    {
        qtitle = qFirstChar;
    }
    initialPage=initialPage*pageNum;

    // Generate a SQL query
    String query = "";
    if(y.equals(""))
    {
        if(genre.equals("")) {
            if (sort.equals("ta")) {

                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \',\') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \',\') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.director LIKE ? AND stars.name LIKE ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY movies.title " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2,title);
                statement.setInt(3,match);
                statement.setString(4,"%" + director + "%");
                statement.setString(5,"%" + star + "%");
                statement.setInt(6,pageNum);
                statement.setInt(7, initialPage);

            } else if (sort.equals("td")) {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.director LIKE ? AND stars.name LIKE ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY movies.title DESC " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2,title);
                statement.setInt(3,match);
                statement.setString(4,"%" + director + "%");
                statement.setString(5,"%" + star + "%");
                statement.setInt(6,pageNum);
                statement.setInt(7, initialPage);

            } else if (sort.equals("ra")) {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.director LIKE ? AND stars.name LIKE ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY ratings.rating " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2,title);
                statement.setInt(3,match);
                statement.setString(4,"%" + director + "%");
                statement.setString(5,"%" + star + "%");
                statement.setInt(6,pageNum);
                statement.setInt(7, initialPage);


            } else if (sort.equals("rd")) {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.director LIKE ? AND stars.name LIKE ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY ratings.rating DESC " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2,title);
                statement.setInt(3,match);
                statement.setString(4,"%" + director + "%");
                statement.setString(5,"%" + star + "%");
                statement.setInt(6,pageNum);
                statement.setInt(7, initialPage);
            }
        }
        else {
            if (sort.equals("ta")) {
                //                query = String.format("SELECT * FROM movies WHERE movies.title LIKE '%s'AND movies.director LIKE '%s'", title,director);
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.director LIKE ? AND stars.name LIKE ? AND genres.name = ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY movies.title " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2,title);
                statement.setInt(3,match);
                statement.setString(4,"%" + director + "%");
                statement.setString(5,"%" + star + "%");
                statement.setInt(6,pageNum);
                statement.setInt(7, initialPage);
                statement.setString(8,genre);

            } else if (sort.equals("td")) {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.director LIKE ? AND stars.name LIKE ? AND genres.name = ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY movies.title DESC " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2,title);
                statement.setInt(3,match);
                statement.setString(4,"%" + director + "%");
                statement.setString(5,"%" + star + "%");
                statement.setInt(6,pageNum);
                statement.setInt(7, initialPage);
                statement.setString(8,genre);

            } else if (sort.equals("ra")) {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.director LIKE ? AND stars.name LIKE ? AND genres.name = ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY ratings.rating " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2,title);
                statement.setInt(3,match);
                statement.setString(4,"%" + director + "%");
                statement.setString(5,"%" + star + "%");
                statement.setInt(6,pageNum);
                statement.setInt(7, initialPage);
                statement.setString(8,genre);

            } else if (sort.equals("rd")) {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.director LIKE ? AND stars.name LIKE ? AND genres.name = ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY ratings.rating DESC " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2,title);
                statement.setInt(3,match);
                statement.setString(4,"%" + director + "%");
                statement.setString(5,"%" + star + "%");
                statement.setInt(6,pageNum);
                statement.setInt(7, initialPage);
                statement.setString(8,genre);
            }
        }
    }
    else
    {
        if(genre.equals("")) {
            if(sort.equals("ta"))
            {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.year = ? AND movies.director LIKE ? AND stars.name LIKE ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY movies.title " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2, title);
                statement.setInt(3, match);
                statement.setInt(4, year);
                statement.setString(5,"%" + director + "%");
                statement.setString(6,"%" + star + "%");
                statement.setInt(7,pageNum);
                statement.setInt(8, initialPage);
            }
            else if(sort.equals("td"))
            {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.year = ? AND movies.director LIKE ? AND stars.name LIKE ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY movies.title DESC " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2, title);
                statement.setInt(3, match);
                statement.setInt(4, year);
                statement.setString(5,"%" + director + "%");
                statement.setString(6,"%" + star + "%");
                statement.setInt(7,pageNum);
                statement.setInt(8, initialPage);
            }
            else if(sort.equals("ra"))
            {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.year = ? AND movies.director LIKE ? AND stars.name LIKE ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY ratings.rating " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2, title);
                statement.setInt(3, match);
                statement.setInt(4, year);
                statement.setString(5,"%" + director + "%");
                statement.setString(6,"%" + star + "%");
                statement.setInt(7,pageNum);
                statement.setInt(8, initialPage);
            }
            else if(sort.equals("rd"))
            {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.year = ? AND movies.director LIKE ? AND stars.name LIKE ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY ratings.rating DESC " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2, title);
                statement.setInt(3, match);
                statement.setInt(4, year);
                statement.setString(5,"%" + director + "%");
                statement.setString(6,"%" + star + "%");
                statement.setInt(7,pageNum);
                statement.setInt(8, initialPage);
            }
        }
        else {
            if(sort.equals("ta"))
            {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.year = ? AND movies.director LIKE ? AND stars.name LIKE ? AND genres.name = ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY movies.title " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2, title);
                statement.setInt(3, match);
                statement.setInt(4, year);
                statement.setString(5,"%" + director + "%");
                statement.setString(6,"%" + star + "%");
                statement.setString(7, genre);
                statement.setInt(8,pageNum);
                statement.setInt(9, initialPage);
            }
            else if(sort.equals("td"))
            {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.year = ? AND movies.director LIKE ? AND stars.name LIKE ? AND genres.name = ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY movies.title DESC " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2, title);
                statement.setInt(3, match);
                statement.setInt(4, year);
                statement.setString(5,"%" + director + "%");
                statement.setString(6,"%" + star + "%");
                statement.setString(7, genre);
                statement.setInt(8,pageNum);
                statement.setInt(9, initialPage);
            }
            else if(sort.equals("ra"))
            {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.year = ? AND movies.director LIKE ? AND stars.name LIKE ? AND genres.name = ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY ratings.rating " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2, title);
                statement.setInt(3, match);
                statement.setInt(4, year);
                statement.setString(5,"%" + director + "%");
                statement.setString(6,"%" + star + "%");
                statement.setString(7, genre);
                statement.setInt(8,pageNum);
                statement.setInt(9, initialPage);
            }
            else if(sort.equals("rd"))
            {
                query = "SELECT DISTINCT movies.id AS ID, rating AS rating, title AS title, year AS year, director AS director, GROUP_CONCAT(DISTINCT stars.name SEPARATOR \', \') AS stars, GROUP_CONCAT(DISTINCT genres.name SEPARATOR \', \') AS genres " +
                        "FROM movies " +
                        "INNER JOIN stars_in_movies ON stars_in_movies.movieId = movies.id " +
                        "INNER JOIN stars ON stars.id = stars_in_movies.starId " +
                        "INNER JOIN genres_in_movies ON genres_in_movies.movieId = movies.id " +
                        "INNER JOIN genres ON genres.id = genres_in_movies.genreId " +
                        "LEFT JOIN ratings ON ratings.movieId = movies.id " +
                        "WHERE (MATCH (title) AGAINST (? IN BOOLEAN MODE) OR movies.title IN (SELECT movies.title FROM movies WHERE (SELECT edth(LOWER(?), LOWER(movies.title), ? )) = 1)) AND movies.year = ? AND movies.director LIKE ? AND stars.name LIKE ? AND genres.name = ? " +
                        "GROUP BY movies.id, rating, title, year, director " +
                        "ORDER BY ratings.rating DESC " +
                        "LIMIT ? OFFSET ?";

                statement = connection.prepareStatement(query);
                statement.setString(1,combined);
                statement.setString(2, title);
                statement.setInt(3, match);
                statement.setInt(4, year);
                statement.setString(5,"%" + director + "%");
                statement.setString(6,"%" + star + "%");
                statement.setString(7, genre);
                statement.setInt(8,pageNum);
                statement.setInt(9, initialPage);
            }
        }
    }

    ResultSet rs = statement.executeQuery();
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
    Search Results
</div>
<div id="movieTable">
    <table border="1">
        <div class="dropdown-content">
            <a href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=<%=pageNum%>&sort=td&initial=<%=(ini)%>&genre=<%=genre%>&char=<%=firstChar%>">Title Descending</a>
            <a href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=<%=pageNum%>&sort=ta&initial=<%=(ini)%>&genre=<%=genre%>&char=<%=firstChar%>">Title Ascending</a>
            <a href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=<%=pageNum%>&sort=rd&initial=<%=(ini)%>&genre=<%=genre%>&char=<%=firstChar%>">Rating Descending</a>
            <a href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=<%=pageNum%>&sort=ra&initial=<%=(ini)%>&genre=<%=genre%>&char=<%=firstChar%>">Rating Ascending</a>
        </div>
        <div class="dropdown-content">
            <a href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=10&sort=<%=sort%>&initial=<%=(ini)%>&genre=<%=genre%>&char=<%=firstChar%>">10</a>
            <a href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=25&sort=<%=sort%>&initial=<%=(ini)%>&genre=<%=genre%>&char=<%=firstChar%>">25</a>
            <a href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=50&sort=<%=sort%>&initial=<%=(ini)%>&genre=<%=genre%>&char=<%=firstChar%>">50</a>
            <a href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=100&sort=<%=sort%>&initial=<%=(ini)%>&genre=<%=genre%>&char=<%=firstChar%>">100</a>
        </div>
        <tr>
            <% for(int i = 1; i <= metadata.getColumnCount(); i++) {%>
                <th>
                    <%=metadata.getColumnName(i)%>
                </th>
            <%}%>
            <th>
                Add to Cart
            </th>
        </tr>
        <%while(rs.next()){%>
        <tr>
            <%for(int i=1; i<= metadata.getColumnCount();i++) {%>
            <%if(i==3) { String movie = rs.getString(i); int tempYear = rs.getInt("year"); String yearr = Integer.toString(tempYear); String tempDir = rs.getString("director");
            %><th><a href="./form?title=<%=movie%>&year=<%=yearr%>&director=<%=tempDir%>&star=&pages=10&sort=<%=sort%>&initial=0&genre=&char="><%=movie%></a></th>
            <%} else if (i==6){
                String s = rs.getString(i);
                String [] star_values = s.split(",");
                ArrayList<String> sep_stars = new ArrayList<String>(Arrays.asList(star_values));%><th>
                <%for(int j=0; j< sep_stars.size();j++) {
                        String temp = sep_stars.get(j).trim();%>
                        <a href="./star?title=&year=&director=&star=<%=temp%>&pages=<%=pageNum%>&sort=<%=sort%>&initial=0&genre=&char="><%=temp%></a>
                <%}%></th>
            <%} else if(i==7) {
                String g = rs.getString(i);
                String [] genre_values = g.split(",");
                ArrayList<String> sep_genres = new ArrayList<String>(Arrays.asList(genre_values));%><th>
                <%for(int j=0; j < sep_genres.size();j++) {
                    String temp = sep_genres.get(j).replace(" ","");%>
                    <a href="./form?title=&year=&director=&star=&pages=<%=pageNum%>&sort=<%=sort%>&initial=0&genre=<%=temp%>&char="><%=temp%></a>
                <%}%></th>
            <%}else {%>
            <th>
                <%=rs.getString(i)%>
            </th>
            <%}%>
            <%}%>
            <th>
                <form action="checkout" method="get">
                    <label for="add">Enter quantity: </label>
                    <input type="number" name="quantity" id="add" maxlength="2" required="[1-9]" min="1" max="99">
                    <input type="hidden" name="movie" value="<%=rs.getString("title")%>">
                    <input type="hidden" name="remove" value="">
                    <input type="image" name="addCart" src="add.gif" alt="Add to Cart">
                    <img alt="" width="1" height="1" src="add.gif">
                </form>
            </th>
        </tr>
        <%}%>
    </table>
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <li class="page-item"><a class="page-link" href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=<%=pageNum%>&sort=<%=sort%>&initial=<%=(ini-1)%>&genre=<%=genre%>&char=<%=firstChar%>">Previous</a></li>
            <li class="page-item"><a class="page-link" href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=<%=pageNum%>&sort=<%=sort%>&initial=<%=(ini)%>&genre=<%=genre%>&char=<%=firstChar%>"><%=ini+1%></a></li>
            <li class="page-item"><a class="page-link" href="./form?title=<%=title%>&year=<%=y%>&director=<%=director%>&star=<%=star%>&pages=<%=pageNum%>&sort=<%=sort%>&initial=<%=(ini+1)%>&genre=<%=genre%>&char=<%=firstChar%>">Next</a></li>
        </ul>

    </nav>
</div>
</body>
</html>

<%rs.close();%>