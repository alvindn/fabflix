## This example is the backend that supports login used to run the Android example

This example exposes login API to both frontend and Android, it's supposed to be a demo backend to work with project4-android-example to show you how to do login in Android.

This example is a combination of `project2-login-example`, `project3-recapthca-example`, and `HTTPS`.


### To run this example:
1. clone this repository using `git clone https://github.com/UCI-Chenli-teaching/project4-login-example.git`
2. Import the project to Eclipse and then deploy it on a tomcat with HTTPS enabled.
3. Follow the instructions on project 4 webpage and [project4-android-example](https://github.com/UCI-Chenli-teaching/project4-android-example) to register a new Android Recaptcha from Google.
4. Change the site key in `login.html` and two secret keys in `RecaptchaConstants.java`
5. You can run this project on a HTTPS tomcat server. For web login, the default username is `anteater` and password is `123456` .
6. You can run [project4-android-example](https://github.com/UCI-Chenli-teaching/project4-android-example) and try to login on Android.



### Explanations

This example combines recaptcha into the `LoginServlet` in `project2-login-example`, the frontend `login.js` will attach the `g-recaptcha-response` in to object sent with the POST request.

This example adds a new `AndroidLoginServlet.java` served at API `/api/android-login` besides the old `LoginServlet`. The reason being that Android Login Recaptcha Secret key and Web Login Recaptcha Secret key are different. If you did the frontend-backend separation in project 2, then other than login, you shouldn't need to duplicate any other Servlets. You Android app can simply call those servlet to get the data it needed.
