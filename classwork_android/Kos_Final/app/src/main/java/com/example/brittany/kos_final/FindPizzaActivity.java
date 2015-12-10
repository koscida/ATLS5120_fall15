package com.example.brittany.kos_final;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.TextView;

public class FindPizzaActivity extends AppCompatActivity {

    String place_url;
    String place_name;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_find_pizza);

        Intent intent = getIntent();
        Bundle extras = intent.getExtras();
        place_name = extras.getString("PLACE_NAME");
        place_url = extras.getString("PLACE_URL");

        ((TextView) findViewById(R.id.pizzaPlace_name)).setText(place_name);
    }

    public void goToPizzaPlace(View view) {
        Intent i = new Intent(Intent.ACTION_VIEW);
        i.setData(Uri.parse(place_url));
        startActivity(i);
    }
}
