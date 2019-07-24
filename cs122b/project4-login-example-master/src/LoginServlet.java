import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class Login
 */
@WebServlet(name = "LoginServlet", urlPatterns = "/api/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

        
        // verify recaptcha first
        try {
            RecaptchaVerifyUtils.verify(gRecaptchaResponse, RecaptchaConstants.WEB_SECRET_KEY);
        } catch (Exception e) {
            JsonObject responseJsonObject = new JsonObject();
            responseJsonObject.addProperty("status", "fail");
            responseJsonObject.addProperty("message", e.getMessage());
            response.getWriter().write(responseJsonObject.toString());
            return;
        }

        // then verify username / password
        JsonObject loginResult = LoginVerifyUtils.verifyUsernamePassword(username, password);
        
        if (loginResult.get("status").getAsString().equals("success")) {
            // login success
            request.getSession().setAttribute("user", new User(username));
            response.getWriter().write(loginResult.toString());
        } else {
            response.getWriter().write(loginResult.toString());
        }
    }

}
