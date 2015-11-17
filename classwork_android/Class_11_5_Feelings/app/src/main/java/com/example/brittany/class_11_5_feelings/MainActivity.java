package com.example.brittany.class_11_5_feelings;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void findMood(View view) {
        // textview
        TextView feeling = (TextView) findViewById(R.id.feelingText);

        // spinner
        Spinner moodSpinner = (Spinner) findViewById(R.id.spinner);
        String moodValue = String.valueOf(moodSpinner.getSelectedItem());

        // edit text
        EditText name = (EditText) findViewById(R.id.name_editText);
        String nameValue = name.getText().toString();

        // toggle
        ToggleButton toggle = (ToggleButton) findViewById(R.id.energy_toggle);
        boolean energy = toggle.isChecked();
        String energyString = ((energy) ? R.string.toggle_on : R.string.toggle_off);

        // radio
        RadioGroup yoga = (RadioGroup) findViewById(R.id.yoga_type);
        String yogaType;
        int yogaId = yoga.getCheckedRadioButtonId();
        switch(yogaId) {
            case R.id.radioButton1:
                yogaType = R.string.yoga1_radio;
                break;
            case R.id.radioButton2:
                yogaType = R.string.yoga2_radio;
                break;
            case R.id.radioButton3:
                yogaType = R.string.yoga3_radio;
                break;
            case -1:
            default:
                yogaType = "no";
        }

        //check
        String checkbox_string = "";

        Checkbox check1 = (Checkbox) findViewById(R.id.checkBox1);
        checkbox_string += ( (check1.isChecked()) ? R.string.sarcastic_check : "" );
    }
}
