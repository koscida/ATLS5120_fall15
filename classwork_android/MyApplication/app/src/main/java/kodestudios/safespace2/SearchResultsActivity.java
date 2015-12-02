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
import android.widget.Toast;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.location.places.Place;
import com.google.android.gms.location.places.ui.PlacePicker;
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

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;


/**
 * Created by Brittany on 11/29/2015.
 *
 * InputStream convert to json code from:
 * http://stackoverflow.com/questions/21753953/convert-input-stream-to-json-to-display
 */



public class SearchResultsActivity extends BaseActivity implements OnMapReadyCallback {

    private GoogleApiClient mGoogleApiClient;
    private String searchPlace;
    boolean isMapReady = false;
    boolean isNewLocationReady = false;
    boolean hasSetMapMarkers = false;
    MapFragment mapFragment;
    GoogleMap mMap;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //Log.d(TAG, "SearchResultsActivity - Begin");

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

    @Override
    public void onMapReady(GoogleMap map) {
        mMap = map;
        isMapReady = true;
        setCurrentMapMarker();
    }

    @Override
    public void handleNewLocation(Location location) {
        // from parent's handleNewLocation()
        currentLocation = location;
        currentLatitude = location.getLatitude();
        currentLongitude = location.getLongitude();

        // do our location thing
        String locLat = Double.valueOf(currentLatitude).toString();
        String locLong = new Double(currentLongitude).toString();
        final String http_call = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?" +
                "location=" + locLat + "," + locLong +
                "&radius=1000" +
                "&types=" + searchPlace +
                "&key=" + GOOGLE_PLACES_API_KEY;
        //Log.d(TAG, http_call);

        isNewLocationReady = true;
        setCurrentMapMarker();




        new Thread() {
            public void run() {
                JSONObject j = getHTTPData(http_call);
                //Log.d(TAG, j.toString());

                try {
                    final JSONArray results = j.getJSONArray("results");

                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            for (int i=results.length()-1; i>=0 ; i--) {

                                JSONObject result = null;
                                try {
                                    result = results.getJSONObject(i);

                                    // get place's id and name
                                    String id = result.getString("id");
                                    String name = result.getString("name");

                                    // get distance to place
                                    JSONObject placeGeo = result.getJSONObject("geometry");
                                    JSONObject placeLoc = placeGeo.getJSONObject("location");
                                    Double placeLat = placeLoc.getDouble("lat");
                                    Double placeLon = placeLoc.getDouble("lng");
                                    Double dist = calcDist(currentLatitude, currentLongitude, placeLat, placeLon);
                                    //Log.d(TAG, new Double(dist).toString());

                                    // get photo url
                                    JSONArray placePhotos = result.getJSONArray("photos");
                                    JSONObject placePhoto = placePhotos.getJSONObject(0);
                                    String ref = placePhoto.getString("photo_reference");
                                    String photoURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" + ref + "&key=" + GOOGLE_PLACES_API_KEY;
                                    //Log.d(TAG, photoURL);

                                    if(isMapReady) {
                                        // add place to google map
                                        mMap.addMarker(new MarkerOptions()
                                                .position(new LatLng(placeLat, placeLon))
                                                .title(name));
                                    }

                                    // add place to gridlist
                                    createListItem(id, name, 5, dist, photoURL);
                                } catch (JSONException e) {
                                    e.printStackTrace();
                                }


                            }
                        }
                    });


                } catch (JSONException e) {
                    e.printStackTrace();
                }

            }
        }.start();

    }

    private void setCurrentMapMarker() {
        if(isMapReady && isNewLocationReady) {
            CameraUpdate center = CameraUpdateFactory.newLatLng(new LatLng(currentLatitude, currentLongitude));
            mMap.moveCamera(center);

            CameraUpdate zoom= CameraUpdateFactory.zoomTo(15);
            mMap.animateCamera(zoom);
        }
    }


    private static JSONObject convertInputStreamToJSONObject(InputStream inputStream) {
        BufferedReader bufferedReader = new BufferedReader( new InputStreamReader(inputStream));
        String line = "";
        String result = "";
        try {
            while((line = bufferedReader.readLine()) != null)
                result += line;
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            JSONObject j = new JSONObject(result);
            Log.d(TAG, j.toString());
            return j;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    public JSONObject getHTTPData(String http_call) {
        URL url = null;
        try {
            url = new URL(http_call);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }

        HttpURLConnection urlConnection = null;
        try {
            urlConnection = (HttpURLConnection) url.openConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }

        InputStream in = null;
        JSONObject j = null;
        try {
            in = new BufferedInputStream(urlConnection.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            j = convertInputStreamToJSONObject(in);
            urlConnection.disconnect();
        }

        return j;
    }

    private void setUpMap() {
        //mMap.addMarker(new MarkerOptions().position(new LatLng(0, 0)).title("Marker"));
    }

    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        int PLACE_PICKER_REQUEST = 1;

        if (requestCode == PLACE_PICKER_REQUEST) {
            if (resultCode == RESULT_OK) {
                Place place = PlacePicker.getPlace(data, this);
                String toastMsg = String.format("Place: %s", place.getName());
                Toast.makeText(this, toastMsg, Toast.LENGTH_LONG).show();
            }
        }
    }



    void createListItem(String ID, String name, int rating, double dist, String imgURL) {
        LayoutInflater inflater = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        // get grid layout that we are going to add to
        LinearLayout grid = (LinearLayout) findViewById(R.id.search_results_grid);

        // create view and add to grid
        View contentView = inflater.inflate(R.layout.helper_search_results_item, null, false);
        grid.addView(contentView, 0);

        // set image
        try {
            UrlImageView imgView = (UrlImageView) findViewById(R.id.searchResults_image);
            imgView.setImageURL(new URL(imgURL));
            //imgView.cancelLoading();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }

        // set name
        TextView nameText = (TextView) findViewById(R.id.searchResults_name);
        nameText.setText(name);

        // set type
        TextView typeText = (TextView) findViewById(R.id.searchResults_type);
        typeText.setText("");

        // set distance
        TextView distText = (TextView) findViewById(R.id.searchResults_dist);
        String d = String.format("%1$,.2f", dist);
        d = d.concat(" mi");
        distText.setText(d);

    }

    double calcDist(double lat1, double lon1, double lat2, double lon2) {
        double Rmeters = 6371000; // metres
        double R = Rmeters /1609.34; // miles

        double φ1 = Math.toRadians(lat1);
        double φ2 = Math.toRadians(lat2);
        double Δφ = Math.toRadians(lat2-lat1);
        double Δλ = Math.toRadians(lon2-lon1);

        double a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
                Math.cos(φ1) * Math.cos(φ2) *
                        Math.sin(Δλ/2) * Math.sin(Δλ/2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

        double d = R * c;
        return d;
    }

}
