package kodestudios.safespace2;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;

public class MainActivity extends BaseActivity {

    public void searchPreWritten(View view) {
        Log.i("MyActivity", "in search PreWritten");

        Intent intent = new Intent(this, SearchResultsActivity.class);
        String message = "";
        switch(view.getId()) {
            case R.id.buttonRestaurants :
                message = "rest";
                break;
            case R.id.buttonBars :
                message = "bar";
                break;
        }
        intent.putExtra(EXTRA_MESSAGE, message);
        startActivity(intent);
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        LayoutInflater inflater = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View contentView = inflater.inflate(R.layout.activity_main, null, false);
        drawerLayout.addView(contentView, 0);





    }

}
