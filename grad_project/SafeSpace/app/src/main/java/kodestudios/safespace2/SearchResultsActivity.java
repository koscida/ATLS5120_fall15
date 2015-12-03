package kodestudios.safespace2;

import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

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

import java.net.MalformedURLException;
import java.net.URL;


/**
 * Created by Brittany on 11/29/2015.
 *
 * InputStream convert to json code from:
 * http://stackoverflow.com/questions/21753953/convert-input-stream-to-json-to-display
 */



public class SearchResultsActivity extends BaseActivity implements OnMapReadyCallback {

    private String searchPlace;

    boolean isMapReady = false;
    boolean isNewLocationReady = false;

    boolean loadedGooglePlaceHttpCall = false;
    boolean loadedGoogleImageHttpCall = false;
    boolean loadedRatingsHttpCall = false;

    MapFragment mapFragment;
    GoogleMap mMap;

    MyPlace[] places;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //Log.d(TAG, "SearchResultsActivity - Begin");

        // get intent that was sent to us
        Intent intent = getIntent();
        searchPlace = intent.getStringExtra(RESERVED_SEARCH_PLACE);

        // set layout view
        LayoutInflater inflater = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View contentView = inflater.inflate(R.layout.activity_search_results, null, false);
        drawerLayout.addView(contentView, 0);

        // map stuff
        mapFragment = (MapFragment) getFragmentManager().findFragmentById(R.id.search_results_map);
        mapFragment.getMapAsync(this);

        //Log.d(TAG, "SearchResultsActivity - End");
    }

    public void goToPlace(View view) {
        Intent intent = new Intent(this, PlaceActivity.class);
        MyPlace clickedPlace = (MyPlace) places[(int) view.getTag()];
        intent.putExtra(RESERVED_PLACE_MYPLACE, clickedPlace);
        startActivity(intent);
    }

    @Override
    public void onMapReady(GoogleMap map) {
        mMap = map;
        isMapReady = true;
        setCurrentMapLocation();
    }

    @Override
    public void handleNewLocation(Location location) {
        // from parent's handleNewLocation()
        currentLocation = location;
        currentLatitude = location.getLatitude();
        currentLongitude = location.getLongitude();

        // do our location thing
        String locLat = Double.valueOf(currentLatitude).toString();
        String locLong = Double.toString(currentLongitude);
        final String http_call = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?" +
                "location=" + locLat + "," + locLong +
                "&radius=1000" +
                "&types=" + searchPlace +
                "&key=" + GOOGLE_PLACES_API_KEY;
        Log.d(TAG, http_call);

        isNewLocationReady = true;
        setCurrentMapLocation();




        new Thread() {
            public void run() {

                JSONObject j = Helper.getHTTPData(http_call);
                //Log.d(TAG, j.toString());

                try {
                    final JSONArray results = j.getJSONArray("results");
                    places = new MyPlace[results.length()];

                    for (int i=results.length()-1; i>=0 ; i--) {
                        // single result object
                        JSONObject result;
                        try {
                            // get single result object
                            result = results.getJSONObject(i);

                            // create new place object
                            places[i] = new MyPlace();

                            // get place's id and name
                            places[i].googleResultId = result.getString("id");
                            places[i].googlePlaceId = result.getString("place_id");
                            places[i].name = result.getString("name");
                            JSONArray types = result.getJSONArray("types");
                            places[i].type = types.getString(0);

                            // get distance to place
                            JSONObject placeGeo = result.getJSONObject("geometry");
                            JSONObject placeLoc = placeGeo.getJSONObject("location");
                            places[i].lat = placeLoc.getDouble("lat");
                            places[i].lon = placeLoc.getDouble("lng");
                            places[i].dist = Helper.calcDist(currentLatitude, currentLongitude, places[i].lat, places[i].lon);
                            //Log.d(TAG, new Double(dist).toString());

                            // get photo url
                            JSONArray placePhotos = result.getJSONArray("photos");
                            JSONObject placePhoto = placePhotos.getJSONObject(0);
                            String ref = placePhoto.getString("photo_reference");
                            places[i].photoURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" + ref + "&key=" + GOOGLE_PLACES_API_KEY;
                            //Log.d(TAG, photoURL);

                            // get open now
                            JSONObject opening_hours = result.getJSONObject("opening_hours");
                            places[i].openNow = opening_hours.getBoolean("open_now");

                            // get vicinity
                            places[i].vicinity = result.getString("vicinity");

                            // get google rating
                            places[i].googleRating = result.getDouble("rating");

                            // get google price level
                            places[i].googlePriceLevel = result.getInt("price_level");

                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }

                    // we've finished loading the initial places http call
                    loadedGooglePlaceHttpCall = true;

                } catch (JSONException e) {
                    e.printStackTrace();
                }

                // bad placement, but call the load here
                // (don't wait to load the images and ratings)
                loadAllItemsToScreen();

            }
        }.start();

    }

    public void setCurrentMapLocation() {
        if(isMapReady && isNewLocationReady) {
            CameraUpdate center = CameraUpdateFactory.newLatLng(new LatLng(currentLatitude, currentLongitude));
            mMap.moveCamera(center);

            CameraUpdate zoom = CameraUpdateFactory.zoomTo(14);
            mMap.animateCamera(zoom);
        }
    }

    public void loadAllItemsToScreen() {
        if(loadedGooglePlaceHttpCall && !loadedGoogleImageHttpCall && !loadedRatingsHttpCall) {

            runOnUiThread(new Runnable() {
                @Override
                public void run() {

                    for (int i = 0; i < places.length; i++) {

                        // add place to map
                        if (isMapReady) {
                            // add place to google map
                            mMap.addMarker(new MarkerOptions()
                                    .position(new LatLng(places[i].lat, places[i].lon))
                                    .title(places[i].name));
                        }

                        // add place to gridlist
                        createListItem(places[i].googlePlaceId, places[i].name, places[i].type, places[i].dist, places[i].photoURL, i);
                    }
                }
            });
        }
    }


    void createListItem(String id, String name, String type, double dist, String imgURL, int i) {
        LayoutInflater inflater = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        // get grid layout that we are going to add to
        LinearLayout grid = (LinearLayout) findViewById(R.id.search_results_grid);

        // create view and add to grid
        View contentView = inflater.inflate(R.layout.helper_search_results_item, null, false);
        grid.addView(contentView, 0);

        // set image
        UrlImageView imgView = (UrlImageView) findViewById(R.id.searchResults_image);
        if(imgURL.isEmpty()) {
            imgView.setImageResource(R.drawable.no_img);
        } else {
            URL u = null;
            try {
                u = new URL(imgURL);
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }
            imgView.setImageURL(u);
        }

        // set rating
        RatingImageView ratingLayout = (RatingImageView) findViewById(R.id.searchResults_rating);
        ratingLayout.getAndSetRatings(id);


        // set tag
        LinearLayout itemLayout = (LinearLayout) findViewById(R.id.searchResults_item);
        itemLayout.setTag(i);

        // set name
        TextView nameText = (TextView) findViewById(R.id.searchResults_name);
        nameText.setText(name);

        // set type
        TextView typeText = (TextView) findViewById(R.id.searchResults_type);
        typeText.setText(type);

        // set distance
        TextView distText = (TextView) findViewById(R.id.searchResults_dist);
        String d = String.format("%1$,.2f", dist);
        d = d.concat(" mi");
        distText.setText(d);
    }
}
