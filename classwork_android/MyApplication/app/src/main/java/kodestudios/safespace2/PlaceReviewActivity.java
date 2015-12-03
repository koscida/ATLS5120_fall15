package kodestudios.safespace2;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import android.widget.RatingBar;
import android.widget.Toast;

import org.json.JSONObject;

/**
 * Created by Brit on 12/2/2015.
 */
public class PlaceReviewActivity extends BaseActivity {

    MyPlace myPlace;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //Log.d(TAG, "PlaceReviewActivity - Begin");

        // get intent that was sent to us
        Intent intent = getIntent();
        myPlace = (MyPlace) intent.getSerializableExtra(RESERVED_PLACE_MYPLACE);

        // set layout view
        LayoutInflater inflater = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View contentView = inflater.inflate(R.layout.activity_place_review, null, false);
        drawerLayout.addView(contentView, 0);

        //Log.d(TAG, "PlaceReviewActivity - End");
    }

    public void submitReview(View view) {
        // get review
        RatingBar reviewRating = (RatingBar) findViewById(R.id.placeReview_ratingBar);
        final int rating = (int) reviewRating.getRating();
        EditText reviewName = (EditText) findViewById(R.id.placeReview_name);
        String name = reviewName.getText().toString();
        EditText reviewEmail = (EditText) findViewById(R.id.placeReview_email);
        String email = reviewEmail.getText().toString();
        EditText reviewComment = (EditText) findViewById(R.id.placeReview_comment);
        String comment = reviewComment.getText().toString();

        // test is filled everything out
        // test name
        if(name == null || name.equals("") || name.equals(" ")) {
            Toast.makeText(getApplicationContext(), "Error: Missing name", Toast.LENGTH_SHORT).show();
        }

        // test email
        if(email == null || email.equals("") || email.equals(" ")) {
            Toast.makeText(getApplicationContext(), "Error: Missing email", Toast.LENGTH_SHORT).show();
        }

        // test comment
        if(comment == null || comment.equals("") || comment.equals(" ")) {
            Toast.makeText(getApplicationContext(), "Error: Missing comment", Toast.LENGTH_SHORT).show();
        }


        // have to start intent outside of new thread
        final Intent intent = new Intent(this, PlaceActivity.class);

        new Thread() {
            public void run() {

                String ratingString = String.valueOf(rating);
                String http_call = "http://creative.colorado.edu/~kosba/safespace/submitreview.php?key=coco&google_id=" + myPlace.googlePlaceId + "&rating=" + ratingString;
                Log.d(TAG, http_call);

                JSONObject j = Helper.getHTTPData(http_call);

                // once thread is finished, then start on intent stuff
                intent.putExtra(RESERVED_PLACE_MYPLACE, myPlace);
                startActivity(intent);
            }
        }.start();
    }


    @Override
    public void handleOnConnection() {

    }


}
