package kodestudios.safespace2;

import android.net.Uri;

import com.google.android.gms.location.places.Place;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.LatLngBounds;

import java.io.Serializable;
import java.util.List;
import java.util.Locale;

/**
 * Created by Brit on 12/2/2015.
 */
@SuppressWarnings("serial")
public class MyPlace implements Serializable, Place {
    String googleResultId = "";
    String googlePlaceId = "";
    String name = "";
    String type = "";
    Double dist = 0.0;
    Double rating = 0.0;

    String photoURL = "";

    Double lat = 0.0;
    Double lon = 0.0;

    boolean openNow = true;
    String hours = "";
    String phone = "";
    String website = "";
    String vicinity = "";

    Double googleRating = -1.0;
    int googlePriceLevel = -1;

    @Override
    public String getId() {
        return null;
    }

    @Override
    public List<Integer> getPlaceTypes() {
        return null;
    }

    @Override
    public CharSequence getAddress() {
        return null;
    }

    @Override
    public Locale getLocale() {
        return null;
    }

    @Override
    public CharSequence getName() {
        return null;
    }

    @Override
    public LatLng getLatLng() {
        return null;
    }

    @Override
    public LatLngBounds getViewport() {
        return null;
    }

    @Override
    public Uri getWebsiteUri() {
        return null;
    }

    @Override
    public CharSequence getPhoneNumber() {
        return null;
    }

    @Override
    public float getRating() {
        return 0;
    }

    @Override
    public int getPriceLevel() {
        return 0;
    }

    @Override
    public Place freeze() {
        return null;
    }

    @Override
    public boolean isDataValid() {
        return false;
    }
}
