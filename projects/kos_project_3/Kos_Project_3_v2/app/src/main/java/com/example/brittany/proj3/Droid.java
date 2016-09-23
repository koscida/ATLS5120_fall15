package com.example.brittany.proj3;

import android.graphics.Bitmap;
import android.graphics.Canvas;

/**
 * Created by Brittany on 12/3/2015.
 */
public class Droid {

    private Bitmap bitmap;      // the actual bitmap
    private int x;              // the X coordinate
    private int y;              // the Y coordinate
    private int width;          // the width of the bitmap
    private int height;         // the height of the bitmap
    private boolean touched;    // if droid is touched/picked up

    public Droid(Bitmap bitmap, int x, int y) {
        this.bitmap = bitmap;
        this.x = x;
        this.y = y;
        this.width = bitmap.getWidth();
        this.height = bitmap.getHeight();
    }

    public int getWidth() { return this.bitmap.getWidth(); }
    public int getHeight() { return this.bitmap.getHeight(); }

    public Bitmap getBitmap() {
        return bitmap;
    }
    public void setBitmap(Bitmap bitmap) {
        this.bitmap = bitmap;
    }

    public int getX() {
        return x;
    }
    public void setX(int x) {
        this.x = x;
    }

    public int getY() {
        return y;
    }
    public void setY(int y) {
        this.y = y;
    }

    public boolean isTouched() {
        return touched;
    }
    public void setTouched(boolean touched) {
        this.touched = touched;
    }

    public void draw(Canvas canvas) {
        // draw in the center
        canvas.drawBitmap(bitmap, x - (bitmap.getWidth() / 2), y - (bitmap.getHeight() / 2), null);
    }

    public void handleActionDown(int eventX, int eventY) {
        if ( eventX >= (x - bitmap.getWidth()  / 2) && eventX <= (x + bitmap.getWidth()  / 2) &&
                eventY >= (y - bitmap.getHeight() / 2) && eventY <= (y + bitmap.getHeight() / 2) ) {
            // slider touched
            setTouched(true);
        } else {
            setTouched(false);
        }

    }
}
