package kodestudios.safespace2;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.android.gms.common.api.ResultCallback;
import com.google.android.gms.location.places.Place;
import com.google.android.gms.location.places.PlaceBuffer;
import com.google.android.gms.location.places.Places;

/**
 * Created by Brit on 12/2/2015.
 */
public class PlaceActivity extends BaseActivity {

    MyPlace myPlace;
    Place pl;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //Log.d(TAG, "PlaceActivity - Begin");

        // get intent that was sent to us
        Intent intent = getIntent();
        myPlace = (MyPlace) intent.getSerializableExtra(RESERVED_PLACE_MYPLACE);

        // set layout view
        LayoutInflater inflater = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View contentView = inflater.inflate(R.layout.activity_place, null, false);
        drawerLayout.addView(contentView, 0);

        //Log.d(TAG, "PlaceActivity - End");
    }

    public void goToReview(View view) {
        Intent intent = new Intent(this, PlaceReviewActivity.class);
        intent.putExtra(RESERVED_PLACE_MYPLACE, myPlace);
        startActivity(intent);
    }


    @Override
    public void handleOnConnection() {

        Places.GeoDataApi.getPlaceById(mGoogleApiClient, myPlace.googlePlaceId)
                .setResultCallback(new ResultCallback<PlaceBuffer>() {
                    @Override
                    public void onResult(PlaceBuffer places) {
                        if (places.getStatus().isSuccess() && places.getCount() > 0) {
                            pl = (Place) places.get(0);
                            Log.d(TAG, "Place found: " + pl.getName());
                            loadScreenfromClass();
                        } else {
                            Log.d(TAG, "Place not found");
                        }
                        places.release();
                    }
                });



    }



    void loadScreenfromClass() {
        // set name
        TextView nameText = (TextView) findViewById(R.id.placeView_name);
        nameText.setText(pl.getName());

        // set type
        TextView typeText = (TextView) findViewById(R.id.placeView_type);
        typeText.setText(myPlace.type);

        // set distance
        TextView distText = (TextView) findViewById(R.id.placeView_dist);
        String d = String.format("%1$,.2f", myPlace.dist);
        d = d.concat(" mi");
        distText.setText(d);

        // set rating
        RatingImageView ratingLayout = (RatingImageView) findViewById(R.id.placeView_rating);
        ratingLayout.getAndSetRatings(myPlace.googlePlaceId);



        // bottom info group
        LinearLayout bll = (LinearLayout) findViewById(R.id.placeView_bottomInfo);

        // set open
        TextView openText = (TextView) findViewById(R.id.placeView_open);
        String o = "Open: " + ( (myPlace.openNow) ? "Open Now" : "Closed" );
        openText.setText(o);

        // set phone
        TextView phoneText = (TextView) findViewById(R.id.placeView_phone);
        String pt = "Phone: " + ( (pl.getPhoneNumber() != null) ? pl.getPhoneNumber() : "(No info available)" );
        phoneText.setText(pt);

        // set website
        TextView websiteText = (TextView) findViewById(R.id.placeView_website);
        String wt = "Website: " + ( (pl.getWebsiteUri() != null) ? pl.getWebsiteUri().toString() : "(No info available)" );
        websiteText.setText(wt);

        // set vicinity
        TextView vicinityText = (TextView) findViewById(R.id.placeView_vicinity);
        String vt = "Vicinity: " + ( (myPlace.vicinity.equals("")) ? myPlace.vicinity : "(No info available)" );
        vicinityText.setText(vt);





        // set google rating
        TextView googleRatingText = (TextView) findViewById(R.id.placeView_googleRating);
        String gr = "Rating: " + ( (pl.getRating() != -1) ? Float.toString((pl.getRating()*10)) : "(No info available)" );
        //String gr = "Rating: " + ( (myPlace.rating != -1) ? Double.toString(myPlace.googleRating) : "(No info available)" );
        googleRatingText.setText(gr);

        // set google price
        TextView googlePriceText = (TextView) findViewById(R.id.placeView_googlePrice);
        String gp = "Price: " + ( (pl.getPriceLevel() != -1) ? pl.getPriceLevel() + "/4" : "(No info available)"  );
        googlePriceText.setText(gp);
    }
}
