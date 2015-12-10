package kodestudios.safespace2;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.util.AttributeSet;
import android.util.Log;
import android.widget.ImageView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

/**
 * Created by kosba on 12/1/15.
 *
 * Copied directly from:
 * http://stackoverflow.com/questions/14332296/how-to-set-image-from-url-using-asynctask/15797963#15797963
 */
public class RatingImageView extends ImageView {

    public RatingImageView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    public RatingImageView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public RatingImageView(Context context) {
        super(context);
    }


    private static class UrlLoadingTask extends AsyncTask<URL, Void, JSONObject> {
        private final ImageView updateView;
        private boolean isCancelled = false;
        private InputStream urlInputStream;

        private UrlLoadingTask(ImageView updateView) {
            this.updateView = updateView;
        }

        @Override
        protected JSONObject doInBackground(URL... params) {
            try {
                URLConnection con = params[0].openConnection();
                // can use some more params, i.e. caching directory etc

                this.urlInputStream = new BufferedInputStream(con.getInputStream());
                //con.setUseCaches(true);
                this.urlInputStream = con.getInputStream();

                JSONObject j = Helper.convertInputStreamToJSONObject(this.urlInputStream);
                return j;
            } catch (IOException e) {
                Log.w("failed load json from " + params[0], e);
                return null;
            } finally {
                if (this.urlInputStream != null) {
                    try {
                        this.urlInputStream.close();
                    } catch (IOException e) {
                        ; // swallow
                    } finally {
                        this.urlInputStream = null;
                    }
                }
            }
        }

        @Override
        protected void onPostExecute(JSONObject result) {
            if (!this.isCancelled) {
                Double rating = -1.0;
                try {
                    JSONArray items = result.getJSONArray("item");
                    JSONObject item = items.getJSONObject(0);
                    rating = Double.parseDouble(item.getString("rating"));
                } catch (JSONException e) {
                    e.printStackTrace();
                }

                int r = (int)Math.round(rating);
                switch(r) {
                    case -1:
                    case 0: this.updateView.setImageResource(R.drawable.rating_0_sm); break;
                    case 1: this.updateView.setImageResource(R.drawable.rating_1_sm); break;
                    case 2: this.updateView.setImageResource(R.drawable.rating_2_sm); break;
                    case 3: this.updateView.setImageResource(R.drawable.rating_3_sm); break;
                    case 4: this.updateView.setImageResource(R.drawable.rating_4_sm); break;
                    case 5: this.updateView.setImageResource(R.drawable.rating_5_sm); break;
                }

            }
        }

        // just remember that we were cancelled, no synchronization necessary
        @Override
        protected void onCancelled() {
            this.isCancelled = true;
            try {
                if (this.urlInputStream != null) {
                    try {
                        this.urlInputStream.close();
                    } catch (IOException e) {
                        ;// swallow
                    } finally {
                        this.urlInputStream = null;
                    }
                }
            } finally {
                super.onCancelled();
            }
        }
    }

    // track loading task to cancel it
    private AsyncTask<URL, Void, JSONObject> currentLoadingTask;

    // just for sync
    private Object loadingMonitor = new Object();


    public void getAndSetRatings(String id) {
        String ratings_http_call = "http://creative.colorado.edu/~kosba/safespace/placesearch.php?key=coco&google_id=" + id;
        URL u = null;
        try {
            u = new URL(ratings_http_call);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        synchronized (loadingMonitor) {
            cancelLoading();
            this.currentLoadingTask = new UrlLoadingTask(this).execute(u);
        }


    }

    public void cancelLoading() {
        synchronized (loadingMonitor) {
            if (this.currentLoadingTask != null) {
                this.currentLoadingTask.cancel(true);
                this.currentLoadingTask = null;
            }
        }
    }



    @Override
    public void setImageBitmap(Bitmap bm) {
        cancelLoading();
        super.setImageBitmap(bm);
    }

    @Override
    public void setImageDrawable(Drawable drawable) {
        cancelLoading();
        super.setImageDrawable(drawable);
    }

    @Override
    public void setImageResource(int resId) {
        cancelLoading();
        super.setImageResource(resId);
    }

    @Override
    public void setImageURI(Uri uri) {
        cancelLoading();
        super.setImageURI(uri);
    }
}
