package kodestudios.safespace2;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.android.gms.common.api.ResultCallback;
import com.google.android.gms.location.places.Place;
import com.google.android.gms.location.places.PlaceBuffer;
import com.google.android.gms.location.places.Places;
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by Brit on 12/2/2015.
 */
public class PlaceActivity extends BaseActivity implements OnMapReadyCallback {

    MyPlace myPlace;
    Place pl;

    SafeSpaceReview[] reviews;

    boolean isMapReady = false;
    MapFragment mapFragment;
    GoogleMap mMap;

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

        // map stuff
        mapFragment = (MapFragment) getFragmentManager().findFragmentById(R.id.place_map);
        mapFragment.getMapAsync(this);

        //Log.d(TAG, "PlaceActivity - End");
    }

    public void goToReview(View view) {
        Intent intent = new Intent(this, PlaceReviewActivity.class);
        intent.putExtra(RESERVED_PLACE_MYPLACE, myPlace);
        startActivity(intent);
        finish();
    }




    @Override
    public void handleOnConnection() {

        // Google Places Android API call
        Places.GeoDataApi.getPlaceById(mGoogleApiClient, myPlace.googlePlaceId)
                .setResultCallback(new ResultCallback<PlaceBuffer>() {
                    @Override
                    public void onResult(PlaceBuffer places) {
                        if (places.getStatus().isSuccess() && places.getCount() > 0) {
                            pl = (Place) places.get(0);
                            Log.d(TAG, "Place found: " + pl.getName());
                            // have data, load to screen
                            loadScreen();
                        } else {
                            Log.d(TAG, "Place not found");
                        }
                        places.release();
                    }
                });
    }

    @Override
    public void onMapReady(GoogleMap map) {
        mMap = map;
        setCurrentMapLocation();
    }

    public void setCurrentMapLocation() {
        // add place to google map
        mMap.addMarker(new MarkerOptions()
                .position(new LatLng(myPlace.lat, myPlace.lon))
                .title(myPlace.name));

        CameraUpdate center = CameraUpdateFactory.newLatLng(new LatLng(myPlace.lat, myPlace.lon));
        mMap.moveCamera(center);

        CameraUpdate zoom = CameraUpdateFactory.zoomTo(14);
        mMap.animateCamera(zoom);
    }




    // this sets all the info on the page, after we have it from the api call
    void loadScreen() {
        /* *********************** */
        /*    Top Info Section     */
        /* *********************** */
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
        Helper.setRating(myPlace.rating, (ImageView) findViewById(R.id.placeView_rating));


        /* ************************** */
        /*    Bottom Info Section     */
        /* ************************** */
        // bottom info group
        LinearLayout bll = (LinearLayout) findViewById(R.id.placeView_bottomInfo);

        // set open
        TextView openText = (TextView) findViewById(R.id.placeView_open);
        String o = "Status: " + ( (myPlace.openNow) ? "Open Now" : "Closed" );
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



        /* ************************* */
        /*  Google reviews Section   */
        /* ************************* */
        // set google rating
        TextView googleRatingText = (TextView) findViewById(R.id.placeView_googleRating);
        String gr = "Rating: " + ( (pl.getRating() != -1) ? Float.toString((pl.getRating()*10)) : "(No info available)" );
        //String gr = "Rating: " + ( (myPlace.rating != -1) ? Double.toString(myPlace.googleRating) : "(No info available)" );
        googleRatingText.setText(gr);

        // set google price
        TextView googlePriceText = (TextView) findViewById(R.id.placeView_googlePrice);
        String gp = "Price: " + ( (pl.getPriceLevel() != -1) ? pl.getPriceLevel() + "/4" : "(No info available)"  );
        googlePriceText.setText(gp);



        /* **************************** */
        /*  SafeSpace reviews Section   */
        /* **************************** */
        new Thread() {
            public void run() {

                String http_call = "http://creative.colorado.edu/~kosba/safespace/getreviews.php?" +
                        "key=coco" +
                        "&google_id=" + myPlace.googlePlaceId;
                Log.d(TAG, http_call);

                JSONObject j = Helper.getHTTPData(http_call);
                Log.d(TAG, j.toString());

                try {
                    final JSONArray results = j.getJSONArray("results");
                    reviews = new SafeSpaceReview[ results.length() ];

                    for (int i = results.length() - 1; i >= 0; i--) {
                        // single result object
                        JSONObject result;
                        try {
                            // get single result object
                            result = results.getJSONObject(i);

                            // create new review object
                            reviews[i] = new SafeSpaceReview();

                            // get name of reviewer
                            reviews[i].name = result.getString("name");

                            // get rating
                            reviews[i].rating = result.getDouble("rating");

                            // get comment
                            reviews[i].comment = result.getString("comment");

                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }


                // bad placement, but call the load here
                // (don't wait to load the images and ratings)
                loadSafespaceReviewsToScreen();


            } // end of public void run()
        }.start(); // end of new Thread()
    }

    public void loadSafespaceReviewsToScreen() {

        runOnUiThread(new Runnable() {
            @Override
            public void run() {

                // get grid layout that we are going to add to
                LinearLayout grid = (LinearLayout) findViewById(R.id.placeView_safeSpaceReviews);

                // remove children if there are any
                Log.d( TAG, "Children: " + String.valueOf(((LinearLayout) grid).getChildCount()) );
                if(((LinearLayout) grid).getChildCount() > 0)
                    ((LinearLayout) grid).removeAllViews();

                // loop through all the places
                if(reviews != null) {
                    for (int i = 0; i < reviews.length; i++) {
                        createSafeSpaceReviewItem(reviews[i].name, reviews[i].rating, reviews[i].comment, i);
                    }
                }
            }
        });
    }

    public void createSafeSpaceReviewItem(String name, Double rating, String comment, int i) {
        // create the inflater
        LayoutInflater inflater = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        // get grid layout that we are going to add to
        LinearLayout grid = (LinearLayout) findViewById(R.id.placeView_safeSpaceReviews);

        // create view and add to grid
        View contentView = inflater.inflate(R.layout.helper_safespace_review_item, null, false);
        grid.addView(contentView, 0);

        // set name
        TextView nameText = (TextView) findViewById(R.id.safeSpaceReview_name);
        nameText.setText("Reviewed by: " +  name);

        // set comment
        TextView commentText = (TextView) findViewById(R.id.safeSpaceReview_comment);
        commentText.setText(comment);

        // set rating
        Helper.setRating(rating, (ImageView) findViewById(R.id.safeSpaceReview_rating));
    }

}
