package com.example.brittany.proj3;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.Log;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

/**
 * Created by Brittany on 12/3/2015.
 *
 */
public class MainGamePanel
        extends SurfaceView
        implements SurfaceHolder.Callback {

    private static final String TAG = "----------" + MainGamePanel.class.getSimpleName();

    private MainThread thread;

    public int screenPadding = 0;
    public int screenWidth;
    public int screenHeight;

    public int canvasWidth;
    public int canvasHeight;
    public int canvasX;
    public int canvasY;

    public ToolBar toolbar;
    public int toolBarHeight = 100;

    private LineGroup lg;
    private Slider sliderLR;
    private Slider sliderUD;
    Paint currentPointPaintShape;

    Paint whitePaintShape;
    Paint grayPaintShape;
    Paint bluePaintShape;

    //In this test, handle maximum of 2 pointer
    final int MAX_POINT_CNT = 2;

    public MainGamePanel(Context context) {
        super(context);

        // adding the callback (this) to the surface holder to intercept events
        getHolder().addCallback(this);

        // create the game loop thread
        thread = new MainThread(getHolder(), this);

        // make the GamePanel focusable so it can handle events
        setFocusable(true);

        // set the white paint shape
        // used with canvas and tool bar arrow
        whitePaintShape = new Paint();
        whitePaintShape.setColor(Color.WHITE);
        whitePaintShape.setStyle(Paint.Style.FILL);

        // set the current point's paint shape
        currentPointPaintShape = new Paint();
        currentPointPaintShape.setColor(Color.RED);
        currentPointPaintShape.setDither(true);
        currentPointPaintShape.setStyle(Paint.Style.STROKE);
        currentPointPaintShape.setStrokeJoin(Paint.Join.ROUND);
        currentPointPaintShape.setStrokeCap(Paint.Cap.ROUND);


        // set the slider back
        grayPaintShape = new Paint();
        grayPaintShape.setColor(Color.GRAY);

        // set toolbar paint shape
        bluePaintShape = new Paint();
        bluePaintShape.setColor(Color.BLUE);
        bluePaintShape.setStyle(Paint.Style.FILL);
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
    }

    @Override
    public void surfaceCreated(SurfaceHolder holder) {

        // load the bitmaps
        Bitmap droidBitmap = BitmapFactory.decodeResource(getResources(), R.drawable.droid_1);
        Bitmap sliderBitmap = BitmapFactory.decodeResource(getResources(), R.drawable.slider_30x30);

        // get screen width and height
        screenWidth = this.getWidth();
        screenHeight = this.getHeight();
        canvasWidth = screenWidth - (3*screenPadding) - sliderBitmap.getWidth();
        canvasHeight = screenHeight - (3*screenPadding) - sliderBitmap.getHeight() - toolBarHeight;
        canvasX = (2*screenPadding) + sliderBitmap.getWidth();
        canvasY = screenPadding;
        int centerCanvasX = ((canvasWidth/2)+canvasX);
        int centerCanvasY = ((canvasHeight/2)+canvasY);
        //Log.d(TAG, "screenWidth: " + String.valueOf(screenWidth) + " -- screenHeight: " + String.valueOf(screenHeight) );
        //Log.d(TAG, "sliderBitmap.getWidth(): " + String.valueOf(sliderBitmap.getWidth()) + " -- sliderBitmap.getHeight(): " + String.valueOf(sliderBitmap.getHeight()) );
        //Log.d(TAG, "canvasWidth: " + String.valueOf(canvasWidth) + " -- canvasHeight: " + String.valueOf(canvasHeight) + " -- canvasX: " + String.valueOf(canvasX) + " -- canvasY: " + String.valueOf(canvasY));

        // create droid and load bitmap
        //droid = new Droid( droidBitmap, centerCanvasX, centerCanvasY );
        lg = new LineGroup(canvasWidth, canvasHeight);
        lg.addPoint(centerCanvasX, centerCanvasY);

        // create new left-right slider
        sliderLR = new Slider( sliderBitmap, centerCanvasX, (canvasHeight + (2*screenPadding) + (sliderBitmap.getHeight()/2)) );

        // create new up-down slider
        sliderUD = new Slider( sliderBitmap, (screenPadding + (sliderBitmap.getWidth()/2)), centerCanvasY );

        // create toolbar
        toolbar = new ToolBar(toolBarHeight, screenWidth, screenHeight);

        // at this point the surface is created and we can safely start the game loop
        thread.setRunning(true);
        thread.start();
    }

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) {
        Log.d(TAG, "Surface is being destroyed");
        // tell the thread to shut down and wait for it to finish
        // this is a clean shutdown
        boolean retry = true;
        while (retry) {
            try {
                thread.join();
                retry = false;
            } catch (InterruptedException e) {
                // try again shutting down the thread
            }
        }
        Log.d(TAG, "Thread was shut down cleanly");
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        //Log.d(TAG, event.toString());
        int pointerIndex = ((event.getAction() & MotionEvent.ACTION_POINTER_INDEX_MASK) >> MotionEvent.ACTION_POINTER_INDEX_SHIFT);
        int pointerId = event.getPointerId(pointerIndex);
        int action = (event.getAction() & MotionEvent.ACTION_MASK);
        int pointCnt = event.getPointerCount();
        //Log.d(TAG, "pointerIndex: " + pointerIndex + " -- pointerId: " + pointerId + " -- action: " + action + " -- pointCnt: " + pointCnt);

        switch (action){
            // first down press
            case MotionEvent.ACTION_DOWN:
            // second down press
            case MotionEvent.ACTION_POINTER_DOWN:
                for (int i = 0; i < pointCnt; i++) {
                    sliderLR.handleActionDown((int) event.getX(i), (int) event.getY(i));
                    sliderUD.handleActionDown((int) event.getX(i), (int) event.getY(i));
                    toolbar.handleActionDown((int) event.getX(i), (int) event.getY(i));
                }
                //Log.d(TAG, "DOWN -- sliderUD.isTouched(): " + sliderUD.isTouched() + " -- sliderLR.isTouched(): " + sliderLR.isTouched());
                break;

            // any of the pressed moved
            case MotionEvent.ACTION_MOVE:
                for (int i = 0; i < pointCnt; i++) {
                    // get left right slider
                    if (sliderLR.isTouched()) {
                        //Log.d(TAG, "move sliderLR");
                        // if within confines of possible dragging space
                        if ( (int) event.getX(i) >= ((2 * screenPadding) + (1.5 * sliderLR.getWidth())) && (int) event.getX(i) <= (screenWidth - screenPadding - (sliderLR.getWidth() / 2)) ) {
                            // lr slider is being dragged
                            sliderLR.setX((int) event.getX(i));
                            lg.addPoint(event.getX(i), sliderUD.getY());
                        }
                    }

                    // get up down slider
                    if (sliderUD.isTouched()) {
                        //Log.d(TAG, "move sliderUD");
                        // if within confines of possible dragging space
                        if ((int) event.getY(i) >= (screenPadding + (sliderUD.getHeight() / 2)) && (int) event.getY(i) <= (canvasHeight + screenPadding - (sliderUD.getHeight()/2))  ) {
                            // ud slider is being dragged
                            sliderUD.setY((int) event.getY(i));
                            lg.addPoint(sliderLR.getX(), event.getY(i));
                        }
                    }
                }
                break;

            // a pressed was released
            case MotionEvent.ACTION_POINTER_UP:
            // final pressed released
            case MotionEvent.ACTION_UP:
                if(sliderLR.isTouched())
                    sliderLR.setTouched(false);
                if(sliderUD.isTouched())
                    sliderUD.setTouched(false);
                //Log.d(TAG, "UP -- sliderUD.isTouched(): " + sliderUD.isTouched() + " -- sliderLR.isTouched(): " + sliderLR.isTouched());
                break;
        } // end switch statement

        return true;
    }

    @Override
    protected void onDraw(Canvas canvas) {
        // fills the canvas with grey
        canvas.drawColor(Color.WHITE);

        // draw the left-right slider
        Rect rLR = new Rect(canvasX, (canvasHeight + (screenPadding * 2)), (screenWidth - screenPadding), (canvasHeight + (2 * screenPadding) + sliderLR.getHeight()));
        canvas.drawRect(rLR, grayPaintShape);
        sliderLR.draw(canvas);

        // draw the up-down slider
        canvas.drawRect(screenPadding, screenPadding, (screenPadding + sliderUD.getWidth()), (canvasHeight + screenPadding), grayPaintShape);
        sliderUD.draw(canvas);

        // draw the canvas
        canvas.drawRect(canvasX, canvasY, (canvasWidth + canvasX), (canvasHeight + canvasY), whitePaintShape);

        // draw the line group
        lg.setDotSize(toolbar.getDotSize());
        lg.draw(canvas);

        // draw the current point
        currentPointPaintShape.setStrokeWidth(toolbar.getDotSize());
        canvas.drawPoint(sliderLR.getX(), sliderUD.getY(), currentPointPaintShape);

        // draw the toolbar
        toolbar.draw(canvas);
    }
}