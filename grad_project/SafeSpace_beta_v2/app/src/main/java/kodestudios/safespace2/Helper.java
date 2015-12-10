package kodestudios.safespace2;

import android.util.Log;
import android.widget.ImageView;

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
 * Created by Brit on 12/2/2015.
 */
public class Helper {

    public final static String TAG = Helper.class.getSimpleName() + " ----------";

    public static JSONObject getHTTPData(String http_call) {
        Log.d(TAG, http_call);

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
            j = Helper.convertInputStreamToJSONObject(in);
            urlConnection.disconnect();
        }

        return j;
    }

    public static JSONObject convertInputStreamToJSONObject(InputStream inputStream) {
        Log.d(TAG, inputStream.toString());
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
            //Log.d(TAG, j.toString());
            return j;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }


    static double calcDist(double lat1, double lon1, double lat2, double lon2) {
        double Rmeters = 6371000; // metres
        double R = Rmeters / 1609.34; // miles

        double lat1Rad = Math.toRadians(lat1);
        double lat2Rad = Math.toRadians(lat2);
        double latDiffRad = Math.toRadians(lat2-lat1);
        double lonDiffRad = Math.toRadians(lon2-lon1);

        double a = Math.sin(latDiffRad/2) * Math.sin(latDiffRad/2) +
                Math.cos(lat1Rad) * Math.cos(lat2Rad) *
                        Math.sin(lonDiffRad/2) * Math.sin(lonDiffRad/2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

        double d = R * c;
        return d;
    }

    static public void setRating(Double rating, ImageView ratingImage) {
        int r = (int)Math.ceil(rating);
        switch (r) {
            case -1:
            case 0: ratingImage.setImageResource(R.drawable.rating_0_sm); break;
            case 1: ratingImage.setImageResource(R.drawable.rating_1_sm); break;
            case 2: ratingImage.setImageResource(R.drawable.rating_2_sm); break;
            case 3: ratingImage.setImageResource(R.drawable.rating_3_sm); break;
            case 4: ratingImage.setImageResource(R.drawable.rating_4_sm); break;
            case 5:case 6: ratingImage.setImageResource(R.drawable.rating_5_sm); break;

        }
    }

}
