package com.example.brittany.kos_final;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    String gluten;
    String crust;
    boolean generatedPizza = false;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void generatePizza(View view) {

        generatedPizza = true;

        // get name
        String name = ((EditText) findViewById(R.id.pizza_name)).getText().toString();

        // get sauce
        String sauce = (((ToggleButton) findViewById(R.id.sauce)).isChecked()) ? getString(R.string.sauce_white) : getString(R.string.sauce_red);

        // get crust
        RadioGroup c = (RadioGroup) findViewById(R.id.crust);
        int selectedId = c.getCheckedRadioButtonId();
        crust = ((RadioButton) findViewById(selectedId)).getText().toString();

        // get toppings
        String toppings = "";
        int meat = 0;
        int veggie = 0;
        if(( (CheckBox) findViewById(R.id.topping_pepperoni) ).isChecked()) {
            toppings += (getString(R.string.pepperoni) + "");
            meat++;
        }
        if(( (CheckBox) findViewById(R.id.topping_mushrooms) ).isChecked()) {
            toppings += (getString(R.string.mushrooms) + "");
            veggie++;
        }
        if(( (CheckBox) findViewById(R.id.topping_onions) ).isChecked()) {
            toppings += (getString(R.string.onions) + "");
            veggie++;
        }
        if(( (CheckBox) findViewById(R.id.topping_sausage) ).isChecked()) {
            toppings += (getString(R.string.sausage) + "");
            meat++;
        }

        // get size
        String size = ((Spinner) findViewById(R.id.size)).getSelectedItem().toString();

        // get gluten
        gluten = ((Switch) findViewById(R.id.gluten)).isChecked() ? getString(R.string.gluten) : getString(R.string.hasGluten);


        // build pizza string
        String pizzaType = "The " + name + " pizza is a " + size + " " + crust + " crust " + gluten + " pizza with " +
                sauce + " sauce and " + toppings + "!";

        // set the pizza type text
        ((TextView) findViewById(R.id.pizza_type)).setText(pizzaType);

        // set the picture
        if(meat == 0 && veggie == 0) {
            ((ImageView) findViewById(R.id.pizza_image)).setImageResource(R.drawable.pizza_cheese);
        } else if (meat > veggie) {
            ((ImageView) findViewById(R.id.pizza_image)).setImageResource(R.drawable.pizza_meat);
        } else if (veggie > meat) {
            ((ImageView) findViewById(R.id.pizza_image)).setImageResource(R.drawable.pizza_veggie);
        } else {
            ((ImageView) findViewById(R.id.pizza_image)).setImageResource(R.drawable.pizza_supreme);
        }

        // set the intent

    }

    public void findPizza(View view) {
        if(generatedPizza) {
            Intent intent = new Intent(this, FindPizzaActivity.class);
            String place_name;
            String place_url;

            if(gluten == getString(R.string.gluten)) {
                place_name = "Beau Jo’s";
                place_url = "http://www.beaujos.com/";
            } else if(crust == getString(R.string.crust_thick)) {
                place_name = "Old Chicago";
                place_url = "http://www.oldchicago.com/";
            } else {
                place_name = "Pizzeria Locale";
                place_url = "http://localeboulder.com/";
            }

            intent.putExtra("PLACE_NAME", place_name);
            intent.putExtra("PLACE_URL", place_url);
            startActivity(intent);
        }

    }
}
