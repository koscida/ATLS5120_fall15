package com.example.brittany.kos_lab_10;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    // this is an explicit intent
    public void goToActivity1(View view) {
        Intent i = new Intent(this, Other1Activity.class);
        startActivity(i);
        finish();
    }

    // this is an implicit intent
    public void goToGoogle(View view) {
        Intent i = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.google.com"));
        startActivity(i);
    }
}
