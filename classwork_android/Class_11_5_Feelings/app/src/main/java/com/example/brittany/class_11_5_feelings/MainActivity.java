    package com.example.brittany.class_11_5_feelings;

    import android.support.v7.app.AppCompatActivity;
    import android.os.Bundle;
    import android.view.View;
    import android.widget.CheckBox;
    import android.widget.EditText;
    import android.widget.ImageView;
    import android.widget.RadioGroup;
    import android.widget.Spinner;
    import android.widget.Switch;
    import android.widget.TextView;
    import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void findMood(View view) {
        // spinner
        Spinner moodSpinner = (Spinner) findViewById(R.id.spinner);
        String moodValue = String.valueOf(moodSpinner.getSelectedItem());

        // edit text
        EditText name = (EditText) findViewById(R.id.name_editText);
        String nameValue = name.getText().toString();

        // toggle
        ToggleButton toggle = (ToggleButton) findViewById(R.id.energy_toggle);
        boolean energy = toggle.isChecked();
        String energyString = ((energy) ? getString(R.string.toggle_on) : getString(R.string.toggle_off));

        // radio
        RadioGroup yoga = (RadioGroup) findViewById(R.id.yoga_type);
        String yogaType;
        int yogaId = yoga.getCheckedRadioButtonId();
        switch(yogaId) {
            case R.id.radioButton1:
                yogaType = getString(R.string.yoga1_radio);
                break;
            case R.id.radioButton2:
                yogaType = getString(R.string.yoga2_radio);
                break;
            case R.id.radioButton3:
                yogaType = getString(R.string.yoga3_radio);
                break;
            case -1:
            default:
                yogaType = "no";
        }

        //checks
        String checkbox_string = "";

        CheckBox check1 = (CheckBox) findViewById(R.id.checkBox1);
        checkbox_string += ( (check1.isChecked()) ? getString(R.string.sarcastic_check) : "" );

        CheckBox check2 = (CheckBox) findViewById(R.id.checkBox2);
        checkbox_string += ( (check2.isChecked()) ? getString(R.string.conservative_check) : "" );

        CheckBox check3 = (CheckBox) findViewById(R.id.checkBox3);
        checkbox_string += ( (check3.isChecked()) ? getString(R.string.secretive_check) : "" );

        CheckBox check4 = (CheckBox) findViewById(R.id.checkBox4);
        checkbox_string += ( (check4.isChecked()) ? getString(R.string.enlightened_check) : "" );

        // switch
        Switch meditate_switch = (Switch) findViewById(R.id.switch1);
        String meditate_string = ((meditate_switch.isChecked()) ? " and meditates" : "");

        // textview
        TextView feeling = (TextView) findViewById(R.id.feelingText);
        feeling.setText(nameValue + " is a " + energyString + checkbox_string + " person" + " that does " + yogaType + " yoga" + meditate_string);

        // image
        /*
        ImageView emotion = (ImageView) findViewById(R.id.imageView);
        int image;
        if (moodValue.equals("happy")) {
            image = R.drawable.feeling1;
        } else if (moodValue.equals("sad")) {
            image = R.drawable.feeling2;
        } else if (moodValue.equals("confused")) {
            image = R.drawable.feeling3;
        } else if (moodValue.equals("angry")) {
            image = R.drawable.feeling4;
        } else image = R.drawable.feeling1;
        emotion.setImageResource(image);
        */
    }
}
