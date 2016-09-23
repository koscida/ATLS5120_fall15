package com.example.brittany.proj3;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;

/**
 * Created by Brit on 12/14/2015.
 */
public class LineGroup {

    float[] pts;
    int totalPoints = 0;
    int maxPoints;

    Paint paintShape;

    public LineGroup(int w, int h) {
        maxPoints = (w*h)*2;
        pts = new float[maxPoints];

        for(int i=0; i<maxPoints; i++)
            pts[i] = 0;

        // create paint shape
        paintShape = new Paint();
        paintShape.setColor(Color.BLACK);
        paintShape.setDither(true);
        paintShape.setStyle(Paint.Style.STROKE);
        paintShape.setStrokeJoin(Paint.Join.ROUND);
        paintShape.setStrokeCap(Paint.Cap.ROUND);
        paintShape.setStrokeWidth(10);
    }

    public void setDotSize(int dotSize) {
        paintShape.setStrokeWidth(dotSize);
    }

    public void addPoint(float x, float y) {
        pts[totalPoints] = x;
        pts[totalPoints+1] = y;
        totalPoints+=2;
    }

    public void draw(Canvas canvas) {
        // loop through and draw all the points
        for(int i=0; i<totalPoints; i+=2) {
            canvas.drawPoint(pts[i], pts[i+1], paintShape);
        }
    }
}
