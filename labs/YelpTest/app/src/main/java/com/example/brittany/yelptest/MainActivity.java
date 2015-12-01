package com.example.brittany.yelptest;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;


public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        String urlStr = "https://api.yelp.com/v2/search?term=food&location=San+Francisco";


        URL url;
        HttpURLConnection urlConnection = null;
        System.out.println("--------------");
        try {
            //url = new URL("http://www.mysite.se/index.asp?data=99");
            url = new URL(urlStr);

            urlConnection = (HttpURLConnection) url
                    .openConnection();

            InputStream in = urlConnection.getInputStream();

            InputStreamReader isw = new InputStreamReader(in);

            int data = isw.read();
            System.out.println("--------------");
            while (data != -1) {
                char current = (char) data;
                data = isw.read();
                System.out.println("--------------");
                System.out.print(current);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                urlConnection.disconnect();
            } catch (Exception e) {
                e.printStackTrace(); //If you want further info on failure...
            }
        }

    }
}
