package com.example.test.fablix;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.View;


import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

//import com.android.volley.Request;
//import com.android.volley.RequestQueue;
//import com.android.volley.Response;
//import com.android.volley.VolleyError;
//import com.android.volley.toolbox.StringRequest;
//import com.google.android.gms.common.api.ApiException;
//import com.google.android.gms.common.api.CommonStatusCodes;
//import com.google.android.gms.safetynet.SafetyNet;
//import com.google.android.gms.safetynet.SafetyNetApi;
//import com.google.android.gms.tasks.OnFailureListener;
//import com.google.android.gms.tasks.OnSuccessListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static android.Manifest.permission.READ_CONTACTS;

/**
 * A login screen that offers login via email/password.
 */
public class LoginActivity extends Activity {
    Button login_button;
    EditText email_field, password_field;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);  //R.layout.activity_login -> res/layout/actvity_login.xml

        login_button = (Button)(findViewById(R.id.login_button));
        email_field = (EditText)(findViewById(R.id.email_field));
        password_field = (EditText)(findViewById(R.id.password_field));

        login_button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(password_field.getText().equals("password")) {
                    Toast.makeText(getApplicationContext(), "Login success", Toast.LENGTH_SHORT).show();
                }
                else {
                    Toast.makeText(getApplicationContext(), "Login failed", Toast.LENGTH_SHORT).show();
                }
            }
        });

//    public void connectToTomcat(View view) {
//
//        // Post request form data
//        final Map<String, String> params = new HashMap<String, String>();
//        params.put("username", "anteater");
//        params.put("password", "123456");
//
//        // no user is logged in, so we must connect to the server
//
//        // Use the same network queue across our application
//        final RequestQueue queue = NetworkManager.sharedManager(this).queue;
//
//        // 10.0.2.2 is the host machine when running the android emulator
//        final StringRequest afterLoginRequest = new StringRequest(Request.Method.GET, "https://10.0.2.2:8443/cs122b-spring18-team-44/index",
//                new Response.Listener<String>() {
//                    @Override
//                    public void onResponse(String response) {
//
//                        Log.d("response2", response);
//                        ((TextView) findViewById(R.id.http_response)).setText(response);
//                    }
//                },
//                new Response.ErrorListener() {
//                    @Override
//                    public void onErrorResponse(VolleyError error) {
//                        // error
//                        Log.d("security.error", error.toString());
//                    }
//                }
//        );
//
//
//        final StringRequest loginRequest = new StringRequest(Request.Method.POST, "https://10.0.2.2:8443/cs122b-spring18-team-44/login",
//                new Response.Listener<String>() {
//                    @Override
//                    public void onResponse(String response) {
//
//                        Log.d("response", response);
//                        ((TextView) findViewById(R.id.http_response)).setText(response);
//                        // Add the request to the RequestQueue.
//                        queue.add(afterLoginRequest);
//                    }
//                },
//                new Response.ErrorListener() {
//                    @Override
//                    public void onErrorResponse(VolleyError error) {
//                        // error
//                        Log.d("security.error", error.toString());
//                    }
//                }
//        ) {
//            @Override
//            protected Map<String, String> getParams() {
//                return params;
//            }  // HTTP POST Form Data
//        };
    }
}





