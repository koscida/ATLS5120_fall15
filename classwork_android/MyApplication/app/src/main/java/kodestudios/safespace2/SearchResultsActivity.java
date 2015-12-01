package kodestudios.safespace2;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

public class SearchResultsActivity extends BaseActivity {



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        LayoutInflater inflater = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View contentView = inflater.inflate(R.layout.activity_search_results, null, false);
        drawerLayout.addView(contentView, 0);


        String[] testName = {"AAA", "BBB", "CCC", "DDD", "EEE"};
        int[] testRating = {4, 3, 5, 3, 4};
        double[] testDist = {0.3, 0.7, 0.9, 1.2, 1.4};
        String[] testType = {"aaa", "bbb", "ccc", "ddd", "eee"};
        String[] testImg = {"", "", "", "", ""};
        int[] testID = {1, 2, 3, 4, 5};

        for(int i=0; i<testName.length; i++) {
            createListItem(testID[i], testName[i], testRating[i], testDist[i], testType[i], testImg[i]);
        }

    }

    void createListItem(int ID, String name, int rating, double dist, String type, String img) {
        float density = getResources().getDisplayMetrics().density;

        // get grid to add to
        LinearLayout srg = (LinearLayout) findViewById(R.id.search_results_grid);

        // initial horizontal layout
        LinearLayout ll_item = new LinearLayout(this);
        ll_item.setOrientation(LinearLayout.HORIZONTAL);
        ll_item.setBackgroundResource(R.drawable.grid_item_border);
        int padding = (int) (R.dimen.activity_horizontal_margin * density + 0.5f);
        ll_item.setPadding(padding, padding, padding, padding);

        // left image

        // right info layout
        LinearLayout ll_info = new LinearLayout(this);
        ll_info.setOrientation(LinearLayout.VERTICAL);

        // name
        TextView nameText = new TextView(this);
        nameText.setText(name);
        ll_info.addView(nameText);

        // rating
        TextView ratingText = new TextView(this);
        ratingText.setText(rating);
        ll_info.addView(ratingText);

        // dist
        TextView distText = new TextView(this);
        distText.setText(Double.toString(dist));
        ll_info.addView(distText);

        // type
        TextView typeText = new TextView(this);
        typeText.setText(type);
        ll_info.addView(typeText);

        // add info layout to the item layout
        ll_item.addView(ll_info);

        // add item layout
        srg.addView(ll_item);
    }

}
