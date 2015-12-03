package com.example.brittany.kos_lab_10;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

public class Other1Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_other1);
    }

    // this is an explicit intent
    public void goToMain(View view) {
        Intent i = new Intent(this, MainActivity.class);
        startActivity(i);
        finish();
    }

    // this is an implicit intent
    public void goToGoogle(View view) {
        Intent i = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.google.com"));
        startActivity(i);
    }

}
