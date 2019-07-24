<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"
%>


<style type="text/css">
.arrow-up {
  width: 0; 
  height: 0; 
  border-left: 5px solid transparent;
  border-right: 5px solid transparent;
  
  border-bottom: 5px solid green;
}

.arrow-down {
  width: 0; 
  height: 0; 
  border-left: 5px solid transparent;
  border-right: 5px solid transparent;
  
  border-top: 5px solid red;
}

tab1 {
	padding-left: 2em;
}
</style>

	<div style="text-align:center">
		<a style="padding:5px" href="/Fablix/">Home</a>
		<a style="padding:5px" href="/Fablix/viewcart.jsp">View Cart/Checkout</a>
	

<%
	boolean loggedIn;
	try
	{
		loggedIn = (boolean)session.getAttribute("loggedIn");
	}
	catch(Exception E)
	{
		loggedIn = false;
	}
	if(!loggedIn)
	{
		%>
			<a style="padding:5px" href="/Fablix/login.jsp">Login</a>
			</div><br>
		<%
	}
	else
	{
		%>
			<a style="padding:5px" href="/Fablix/logout.jsp">Logout</a>
			</div><br>
		<%
	}
	//parameters from get request
	boolean doQuery = false;
	int andCounter = -1;

	String title = request.getParameter("title");
	String director = request.getParameter("director");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	int genre = -1;
	boolean querybygenre = false;
	int release = -1;
	int pageNumber;
	int resultsPerPage;
	int resultsTotal;
	int sort = 0;

	try
	{
		if(!request.getParameter("year").equals(""))
		{
			release = Integer.parseInt(request.getParameter("year"));	
		}
	}
	catch(Exception E)
	{
		release = -1;
	}
	try
	{
		if(!request.getParameter("sort").equals(""))
		{
			sort = Integer.parseInt(request.getParameter("sort"));
			if(sort > 4 || sort < 0)
				sort = 0;
		}
	}
	catch(Exception E)
	{
		sort = 1;
	}
	try
	{
		if(!request.getParameter("genre").equals(""))
		{
			genre = Integer.parseInt(request.getParameter("genre"));
		}
	}
	catch(Exception E)
	{
		genre = -1;
	}
	try
	{
		pageNumber = Integer.parseInt(request.getParameter("page"));
		resultsPerPage = Integer.parseInt(request.getParameter("rpp"));
	}
	catch(Exception E)
	{
		pageNumber = 1;
		resultsPerPage = 10;
	}
	
	if(title!=null && !title.equals(""))
		andCounter++;
	if(director!=null && !director.equals(""))
		andCounter++;
	if(firstName!=null && !firstName.equals(""))
		andCounter++;
	if(lastName!=null && !lastName.equals(""))
		andCounter++;
	if(release != -1)
		andCounter++;
	if(genre > 0)
	{
		querybygenre = true;
		doQuery = true;
	}
	if(andCounter >= 0)
		doQuery = true;
	
	
	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "root", "admin");
	Statement select = connection.createStatement();
	ResultSet results;
	
	if(doQuery)
	{		
		String query = "SELECT * FROM movies WHERE ";
		if(querybygenre)
		{
			query += " id IN (SELECT movie_id from genres_in_movies WHERE genre_id=\'" + genre + "\') ";
		}
		else if(title.length() == 1 && !title.equals(""))
		{
			query += " title LIKE \'" + title + "%\' ";
		}
		else
		{
			if(!title.equals(""))
			{
				query += "title LIKE \'%" + title + "%\'";
				if(andCounter > 0)
				{
					query += " AND ";
					andCounter--;
				}
			}
			if(release != -1)
			{
				query += "year=" + "\'" + release + "\'";
				if(andCounter > 0)
				{
					query += " AND ";
					andCounter--;
				}
			}
			if(!director.equals(""))
			{
				query += "director LIKE \'%" + director + "%\'";
				if(andCounter > 0)
				{
					query += " AND ";
					andCounter--;
				}
			}
			if(!firstName.equals("") && !lastName.equals(""))	//both first and last name entered
			{
			
				query += "movies.id IN (SELECT movie_id FROM stars_in_movies where star_id IN " +
					 	"(SELECT id FROM stars where first_name LIKE \'%" + firstName + "%\' AND last_name LIKE \'%" + lastName +"%\')) ";
			}
			else if(!firstName.equals("")) //if only first name is entered
			{
				query += "movies.id IN (SELECT movie_id FROM stars_in_movies where star_id IN " +
						 "(SELECT id FROM stars where first_name LIKE \'%" + firstName + "%\')) ";
			}
			else if(!lastName.equals(""))
			{
				query += "movies.id IN (SELECT movie_id FROM stars_in_movies where star_id IN " +
						 "(SELECT id FROM stars where last_name LIKE \'%" + lastName + "%\')) ";
			}
		}
		if(sort == 1)
			query += "ORDER BY movies.title ASC ";
		if(sort == 2)
			query += "ORDER BY movies.title DESC ";
		if(sort == 3)
			query += "ORDER BY movies.year ASC ";
		if(sort == 4)
			query += "ORDER BY movies.year DESC ";
		
		//get result count
		results = select.executeQuery(query);
		results.last();
		resultsTotal = results.getRow();
		
		query += "LIMIT " + resultsPerPage + " OFFSET " + ( (pageNumber-1) * resultsPerPage);
	
		results = select.executeQuery(query);
	
		boolean Noresult = true;
		
		Statement starquery = connection.createStatement();
		Statement genrequery = connection.createStatement();
		ResultSet starResults;
		ResultSet genreResults;
		
		//get full url minus '&sort=x'
		String fullUrl = request.getRequestURL().toString();
		fullUrl += "?title=" + title + "&year=" + release + "&director=" + director + "&firstName=" + firstName
				+ "&lastName=" + lastName + "&page=" + pageNumber + "&rpp=" + resultsPerPage + "&genre=" + genre + "&sort=";
		
		while(results.next())
		{
			if(Noresult)
			{
				if(sort == 1)
				{
					%>
						<center>
						<a href="<%=fullUrl + "2" %>">Title</a><i class="arrow-up"></i>
						<a href="<%=fullUrl + "3" %>">Year</a><br><br>
						</center>
					<%
				}
				if(sort == 2)
				{
					%>
						<center>
						<a href="<%=fullUrl + "1"%>">Title</a><i class="arrow-down"></i>
						<a href="<%=fullUrl + "3" %>">Year</a><br><br>
						</center>
					<%
				}
				if(sort == 3)
				{
					%>
						<center>
						<a href="<%=fullUrl + "1" %>">Title</a>
						<a href="<%=fullUrl + "4"%>">Year</a><i class="arrow-up"></i><br><br>
						</center>
					<%
				}
				if(sort == 4)
				{
					%>
						<center>
						<a href="<%=fullUrl + "1" %>">Title</a>
						<a href="<%=fullUrl + "3" %>">Year</a><i class="arrow-down"></i><br><br>
						</center>
					<%
				}
			}
			
			Noresult = false;
			String mid = results.getString("id");
			String mTitle = results.getString("title");
			String mYear = results.getString("year");
			String mDirector = results.getString("director");
			String movieUrl = "http://localhost:8080/Fablix/movie.jsp?movie=" + mid;

			starResults = starquery.executeQuery("SELECT * from stars WHERE stars.id IN (SELECT star_id FROM " +
				"stars_in_movies WHERE movie_id=\'"+ mid + "\')");
			
			genreResults = genrequery.executeQuery("SELECT * from genres WHERE id IN (SELECT genre_id FROM genres_in_movies WHERE movie_id=\'"+mid+"\')");
			
			%>
				<div style="text-align: center;">
					<div style="display: inline-block; text-align: left; width:250px;">
						<a href= <%=movieUrl%> ><%=mTitle%></a><br>
						Movie ID: <%=mid%><br>
						Released: <%=mYear%><br>
						Director: <%=mDirector%><br>
						Genres: 
						<% 
							while(genreResults.next())
							{
								%>
								<%=genreResults.getString(2) + "  "%>
								<%
							}
						%>
						<br>
						Stars: 
					<%
						while(starResults.next())
						{
							String starUrl = "http://localhost:8080/Fablix/star.jsp?star=" + starResults.getInt(1);
							String starName = starResults.getString(2) + " " + starResults.getString(3);
					%>
						<a href="<%=starUrl%>"> <%=starName %></a><br>
					<%
						}
					%>
					Price: $10.00
					<form method="get" target="_blank" action="http://localhost:8080/Fablix/addcart.jsp">
							<input type="hidden" name= "mid" value=<%=mid%>>
							<input type="submit" value="Add To Cart"></input>
							</form>
					<br>
					</div>
				</div>
					<%
		}
	
		if(Noresult)
		{
			%>
			<center>
			No Results Found
			<br>
			<a href="javascript:history.back()">Go Back</a>
			</center>
			<%
		}
	}
	else
	{
		String query = "SELECT * FROM movies ";
		
		if(sort == 1)
			query += "ORDER BY title ASC ";
		if(sort == 2)
			query += "ORDER BY title DESC ";
		if(sort == 3)
			query += "ORDER BY year ASC ";
		if(sort == 4)
			query += "ORDER BY year DESC ";
		
		results = select.executeQuery(query);
		results.last();
		resultsTotal = results.getRow();
		request.setAttribute("total", resultsTotal);
		
		query += "LIMIT " + resultsPerPage + " OFFSET " + ( (pageNumber-1) * resultsPerPage);
		results = select.executeQuery(query);
		boolean noResults = true;
		
		Statement starquery = connection.createStatement();
		Statement genrequery = connection.createStatement();
		ResultSet genreResults;
		ResultSet starResults;
		
		//get full url minus '&sort=x'
		String fullUrl = request.getRequestURL().toString();
		fullUrl += "?title=" + title + "&year=" + release + "&director=" + director + "&firstName=" + firstName
				+ "&lastName=" + lastName + "&page=" + pageNumber + "&genre=" + genre + "&rpp=" + resultsPerPage + "&sort=";
		while(results.next())
		{
			if(noResults)
			{
				if(sort == 1)
				{
					%>
						<center>
						<a href="<%=fullUrl + "2" %>">Title</a><i class="arrow-up"></i>
						<a href="<%=fullUrl + "3" %>">Year</a><br><br>
						</center>
					<%
				}
				if(sort == 2)
				{
					%>
						<center>
						<a href="<%=fullUrl + "1"%>">Title</a><i class="arrow-down"></i>
						<a href="<%=fullUrl + "3" %>">Year</a><br><br>
						</center>
					<%
				}
				if(sort == 3)
				{
					%>
						<center>
						<a href="<%=fullUrl + "1" %>">Title</a>
						<a href="<%=fullUrl + "4"%>">Year</a><i class="arrow-up"></i><br><br>
						</center>
					<%
				}
				if(sort == 4)
				{
					%>
						<center>
						<a href="<%=fullUrl + "1" %>">Title</a>
						<a href="<%=fullUrl + "3" %>">Year</a><i class="arrow-down"></i><br><br>
						</center>
					<%
				}
			}
			
			noResults = false;
			String mid = results.getString("id");
			String mTitle = results.getString("title");
			String mYear = results.getString("year");
			String mDirector = results.getString("director");
			String movieUrl = "http://localhost:8080/Fablix/movie.jsp?movie=" + mid;
		
			starResults = starquery.executeQuery("SELECT * from stars WHERE stars.id IN (SELECT star_id FROM " +
				"stars_in_movies WHERE movie_id=\'"+ mid + "\')");
			
			genreResults = genrequery.executeQuery("SELECT * from genres WHERE id IN (SELECT genre_id FROM genres_in_movies WHERE movie_id=\'"+mid+"\')");
			%>
					<div style="text-align: center;">
						<div style="display: inline-block; text-align: left; width:250px;">
							<a href=<%=movieUrl%>><%=mTitle%></a><br>
							Movie ID:    <%=mid%> <br>
							Released: <%=mYear%> <br>
							Director: <%=mDirector%> <br>
							Genres: <% 
							while(genreResults.next())
							{
								%>
								<%=genreResults.getString(2) + "   "%>
								<%
							}
						%>
						<br>
							Stars:
				
					<%
							while(starResults.next())
							{
								String starUrl = "http://localhost:8080/Fablix/star.jsp?star=" + starResults.getInt(1);
								String starName = starResults.getString(2) + " " + starResults.getString(3);
						%>
							<a href="<%=starUrl%>"> <%=starName %>	</a><br>
						
						<%
							}
						%>
						Price: $10.00
							<form method="get" target="_blank" action="http://localhost:8080/Fablix/addcart.jsp">
							<input type="hidden" name= "mid" value=<%=mid%>>
							<input type="submit" value="Add To Cart"></input>
							</form>
							<br>
						</div>
					</div>
				<%
		}
		if(noResults)
		{
			%>
			<center>
			No Results Found
			<br>
			<a href="javascript:history.back()">Go Back</a></center>
			<%
		}
	} 
	
	//PAGINATION
	int numPages = (int)Math.ceil((double)resultsTotal/resultsPerPage);
	StringBuffer url = request.getRequestURL();
	
	%>
	<br><br>
	<center>
	<form method="get" action=/Fablix/movielist.jsp>
		<input type=hidden name="title" value="<%=title%>">
		<input type=hidden name="year" value="<%=release%>">
		<input type=hidden name="director" value="<%=director%>">
		<input type=hidden name= "firstName" value="<%=firstName%>">
		<input type=hidden name="lastName" value="<%=lastName%>">
		<input type=hidden name="page" value="<%=pageNumber%>">
		<input type=hidden name="genre" value="">
		<input type="hidden" name="sort" value=<%=sort%> >
		Results Per Page:<select name="rpp">
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="25">25</option>
			<option value="50">50</option>
			<option value="100">100</option>
		</select>
		<input type="Submit" value="Submit">
	</form>
	
	<%
	for(int i = 1; i <= numPages; ++i)
	{
		url = request.getRequestURL();
		url.append("?title=" + title + "&year=" + release + "&director=" + director + "&firstName=" + firstName + "&lastName="
				+ lastName + "&page=" + i + "&rpp=" +resultsPerPage + "&genre=" + genre + "&sort=" + sort);
		%>
			<a href="<%=url%>"><%=i%>   </a>
		<%	
	}
	%></center>
	<%
	
	//PREVIOUS AND NEXT LINKS
	if(pageNumber - 1 > 0)
	{
		url = request.getRequestURL();
		url.append("?title=" + title + "&year=" + release + "&director=" + director + "&firstName=" + firstName + "&lastName="
				+ lastName + "&page=" + (pageNumber-1) + "&rpp=" +resultsPerPage + "&genre=" + genre + "&sort=" + sort);
		%>
			<center>
			<br><a href=<%=url%>>Previous  </a><br>
			</center>
		<% 
	}
	if(pageNumber + 1 <= numPages)
	{
		url = request.getRequestURL();
		url.append("?title=" + title + "&year=" + release + "&director=" + director + "&firstName=" + firstName + "&lastName="
				+ lastName + "&page=" + (pageNumber+1) + "&rpp=" +resultsPerPage + "&genre=" + genre + "&sort=" + sort);
		%>
			<center>
			<a href=<%=url%>>Next </a>
			</center>
		<%
	}
%>

</body>
</html>