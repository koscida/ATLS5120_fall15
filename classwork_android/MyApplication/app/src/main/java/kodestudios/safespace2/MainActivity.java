package kodestudios.safespace2;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;

public class MainActivity extends BaseActivity {

    class ButtonOption
    {
        public String label;
        public int tag;
        public int img;
        public String searchTerm;
        ButtonOption(String l, int t, int i, String st) { label = l; tag = t; img = i; searchTerm = st; }
    };

    public ButtonOption[] btns;

    public void searchPreWritten(View view) {
        Intent intent = new Intent(this, SearchResultsActivity.class);
        String place = btns[(int)view.getTag()].searchTerm;
        intent.putExtra(RESERVED_SEARCH_PLACE, place);
        startActivity(intent);
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //Log.d(TAG, "MainActivity - Begin");

        LayoutInflater inflater = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View contentView = inflater.inflate(R.layout.activity_main, null, false);
        drawerLayout.addView(contentView, 0);

        // set the search buttons
        btns = new ButtonOption[6];
        btns[0] = new ButtonOption("Bar",               0, R.drawable.graph, "bar");
        btns[1] = new ButtonOption("Restaurant",        1, R.drawable.graph, "restaurant");
        btns[2] = new ButtonOption("Food",              2, R.drawable.graph, "food");
        btns[3] = new ButtonOption("Cafe",              3, R.drawable.graph, "cafe");
        btns[4] = new ButtonOption("Store",             4, R.drawable.graph, "store");
        btns[5] = new ButtonOption("Point of Interest", 5, R.drawable.graph, "point_of_interest");


        for(int i=btns.length-1; i>=0; i-=2) {
            LayoutInflater inflater2 = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

            // get grid layout that we are going to add to
            LinearLayout grid = (LinearLayout) findViewById(R.id.button_grid);

            // get search button view
            View searchButtonView = inflater2.inflate(R.layout.helper_search_button, null, false);
            grid.addView(searchButtonView, 0);


            // set image and tag
            ImageButton buttonImg1 = (ImageButton) findViewById(R.id.searchButton_image1);
            buttonImg1.setImageResource(btns[i].img);
            buttonImg1.setTag(btns[i].tag);

            // set text
            TextView typeText1 = (TextView) findViewById(R.id.searchButton_label1);
            typeText1.setText(btns[i].label);


            // set image and tag
            ImageButton buttonImg2 = (ImageButton) findViewById(R.id.searchButton_image2);
            buttonImg2.setImageResource(btns[i-1].img);
            buttonImg2.setTag(btns[i-1].tag);

            // set text
            TextView typeText2 = (TextView) findViewById(R.id.searchButton_label2);
            typeText2.setText(btns[i-1].label);


        }

        //Log.d(TAG, "MainActivity - End");
    }


}
