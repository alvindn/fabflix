import com.google.gson.JsonObject;
import java.io.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

//
@WebServlet(name = "LoginServlet", urlPatterns = "/api/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	PrintWriter out = response.getWriter();
    	String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
        System.out.println("gRecaptchaResponse=" + gRecaptchaResponse);
        
        try {
            RecaptchaVerifyUtils.verify(gRecaptchaResponse);
        } catch (Exception e) {
            out.println("<html>");
            out.println("<head><title>Error</title></head>");
            out.println("<body>");
            out.println("<p>recaptcha verification error</p>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("</body>");
            out.println("</html>");
            
            out.close();
            return;
        }
    	
        String loginUser = "root";
        String loginPasswd = "password";
        String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

        String username = request.getParameter("username");
        String password = request.getParameter("password");


        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            // create database connection
            Connection connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
            // declare statement
            Statement statement = connection.createStatement();
            Statement statement2 = connection.createStatement();
            Statement statement3 = connection.createStatement();

            String query = String.format("SELECT * FROM customers WHERE customers.email = '%s' AND customers.password = '%s' ",username, password);
            String pwQuery = String.format("SELECT password FROM customers WHERE customers.password = '%s' ", password);
            String userQuery = String.format("SELECT email FROM customers WHERE customers.email = '%s' ",username);

            ResultSet rs = statement.executeQuery(query);
            ResultSet pwRs = statement2.executeQuery(pwQuery);
            ResultSet userRs = statement3.executeQuery(userQuery);


            if(!pwRs.first() && !userRs.first()) {
                JsonObject responseJsonObject = new JsonObject();
                responseJsonObject.addProperty("status", "fail");
                responseJsonObject.addProperty("message", "Username or Password Does Not Exist");

                response.getWriter().write(responseJsonObject.toString());
                username = request.getParameter("username");
                password = request.getParameter("password");
                rs = statement.executeQuery(query);
                pwRs = statement2.executeQuery(pwQuery);
                userRs = statement3.executeQuery(userQuery);
            }
            else if (!pwRs.first() && userRs.first() && !rs.first()) {
                JsonObject responseJsonObject = new JsonObject();
                responseJsonObject.addProperty("status", "fail");
                responseJsonObject.addProperty("message", "Username or Password Does Not Exist");
                response.getWriter().write(responseJsonObject.toString());
                username = request.getParameter("username");
                password = request.getParameter("password");
                rs = statement.executeQuery(query);
                pwRs = statement2.executeQuery(pwQuery);
                userRs = statement3.executeQuery(userQuery);
            }
            else if (pwRs.first() && !userRs.first() && !rs.first()) {
                JsonObject responseJsonObject = new JsonObject();
                responseJsonObject.addProperty("status", "fail");
                responseJsonObject.addProperty("message", "Username or Password Does Not Exist");
                response.getWriter().write(responseJsonObject.toString());
                username = request.getParameter("username");
                password = request.getParameter("password");
                rs = statement.executeQuery(query);
                pwRs = statement2.executeQuery(pwQuery);
                userRs = statement3.executeQuery(userQuery);
            }
            else {
                username = request.getParameter("username");
                password = request.getParameter("password");
                rs = statement.executeQuery(query);
                while (rs.next()) {
                    String email = rs.getString("email");
                    String pw = rs.getString("password");
                    LinkedHashMap<String,Integer> cart = new LinkedHashMap<>();
                    request.getSession().setAttribute("user", new User(username));
                    request.getSession().setAttribute("cart", cart);

                    JsonObject responseJsonObject = new JsonObject();
                    responseJsonObject.addProperty("status", "success");
                    responseJsonObject.addProperty("message", "Login Successful");
                    response.getWriter().write(responseJsonObject.toString());
                }
            }
            rs.close();
            statement.close();
            connection.close();

        } catch (Exception e) {
            /*
             * After you deploy the WAR file through tomcat manager webpage,
             *   there's no console to see the print messages.
             * Tomcat append all the print messages to the file: tomcat_directory/logs/catalina.out
             *
             * To view the last n lines (for example, 100 lines) of messages you can use:
             *   tail -100 catalina.out
             * This can help you debug your program after deploying it on AWS.
             */
            e.printStackTrace();
        }

//        /* This example only allows username/password to be test/test
//        /  in the real project, you should talk to the database to verify username/password
//        */
//        if (username.equals("abc") && password.equals("123")) {
//            // Login success:
//
//            // set this user into the session
//            request.getSession().setAttribute("user", new User(username));
//
//            JsonObject responseJsonObject = new JsonObject();
//            responseJsonObject.addProperty("status", "success");
//            responseJsonObject.addProperty("message", "success");
//
//            response.getWriter().write(responseJsonObject.toString());
//        } else {
//            // Login fail
//            JsonObject responseJsonObject = new JsonObject();
//            responseJsonObject.addProperty("status", "fail");
//            if (!username.equals("anteater")) {
//                responseJsonObject.addProperty("message", "user " + username + " doesn't exist");
//            } else if (!password.equals("123456")) {
//                responseJsonObject.addProperty("message", "incorrect password");
//            }
//            response.getWriter().write(responseJsonObject.toString());
//        }
    }
}