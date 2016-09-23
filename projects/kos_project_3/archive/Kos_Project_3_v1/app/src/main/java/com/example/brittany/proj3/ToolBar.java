package com.example.brittany.proj3;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;

/**
 * Created by Brit on 12/15/2015.
 */
public class ToolBar {

    private static final String TAG = "----------" + MainGamePanel.class.getSimpleName();

    private static final int SIZE_1 = 10;
    private static final int SIZE_2 = 25;
    private static final int SIZE_3 = 50;
    private static final int SIZE_4 = 100;

    private int toolBarMinHeight;
    private int toolBarMaxHeight = 600;
    private int toolBarCurrentHeight;
    private int toolBarWidth;
    private int toolBarX;
    private int toolBarY;
    private int screenWidth;
    private int screenHeight;
    private int toolBarPadding = 20;

    private int speed = 10;
    private boolean animating = false;

    private int dotSize;

    public boolean toolBarOpen = false;

    Paint whitePaintShape;
    Paint bluePaintShape;
    Paint yellowPaintShape;
    Paint blackPaintShape;

    int sizesX;
    int sizesY;
    int sizesWidth = 100;
    int sizesHeight = 100;
    int sizeTitle = 50;

    ToolBar(int tHeight, int cWidth, int cHeight) {
        whitePaintShape = new Paint();
        whitePaintShape.setColor(Color.WHITE);
        whitePaintShape.setTextSize(48f);

        blackPaintShape = new Paint();
        blackPaintShape.setColor(Color.BLACK);
        blackPaintShape.setTextSize(48f);

        yellowPaintShape = new Paint();
        yellowPaintShape.setColor(Color.YELLOW);
        yellowPaintShape.setTextSize(48f);

        bluePaintShape = new Paint();
        bluePaintShape.setColor(Color.BLUE);
        bluePaintShape.setStyle(Paint.Style.FILL);
        bluePaintShape.setTextSize(48f);

        screenWidth = cWidth;
        screenHeight = cHeight;
        toolBarMinHeight = tHeight;
        toolBarCurrentHeight = toolBarMinHeight;
        toolBarWidth = screenWidth;
        toolBarX = 0;
        toolBarY = screenHeight - toolBarMinHeight;

        dotSize = SIZE_1;

        //Log.d(TAG, "toolBarMinHeight: " + toolBarMinHeight + " -- toolBarCurrentHeight: " + toolBarCurrentHeight + " -- toolBarMaxHeight: " + toolBarMaxHeight);
        //Log.d(TAG, "screenWidth: " + screenWidth + " -- screenHeight: " + screenHeight);
        //Log.d(TAG, "toolBarX: " + toolBarX + " -- toolBarY: " + toolBarY);
    }

    public int getDotSize() { return dotSize;}

    public void handleActionDown(int eventX, int eventY) {
        if (!animating) {
            if (toolBarOpen) {
                sizesX = toolBarX + toolBarPadding;
                sizesY = toolBarY + toolBarMinHeight + toolBarPadding;

                if (eventX >= toolBarX && eventX <= (toolBarX + toolBarWidth) && eventY >= toolBarY && eventY <= (toolBarY + toolBarMinHeight)) {
                    toolBarOpen = false;
                }
                if(eventX >= sizesX + (0*sizesWidth) + (0*toolBarPadding) && eventX <= sizesX + (1*sizesWidth) + (0*toolBarPadding) && eventY >= sizesY + sizeTitle && eventY <= sizesY + sizeTitle + sizesHeight) {
                    dotSize = SIZE_1;
                }
                if(eventX >= sizesX + (1*sizesWidth) + (1*toolBarPadding) && eventX <= sizesX + (2*sizesWidth) + (1*toolBarPadding) && eventY >= sizesY + sizeTitle && eventY <= sizesY + sizeTitle + sizesHeight) {
                    dotSize = SIZE_2;
                }
                if(eventX >= sizesX + (2*sizesWidth) + (2*toolBarPadding) && eventX <= sizesX + (3*sizesWidth) + (2*toolBarPadding) && eventY >= sizesY + sizeTitle && eventY <= sizesY + sizeTitle + sizesHeight) {
                    dotSize = SIZE_3;
                }
                if(eventX >= sizesX + (3*sizesWidth) + (3*toolBarPadding) && eventX <= sizesX + (4*sizesWidth) + (3*toolBarPadding) && eventY >= sizesY + sizeTitle && eventY <= sizesY + sizeTitle + sizesHeight) {
                    dotSize = SIZE_4;
                }
            } else {

                if (eventX >= toolBarX && eventX <= (toolBarX + toolBarWidth) && eventY >= toolBarY && eventY <= screenHeight) {
                    toolBarOpen = true;
                }
            }
        }
    }

    public void draw(Canvas canvas) {
        if(toolBarOpen) {
            // animation
            if(toolBarMaxHeight > toolBarCurrentHeight) {
                toolBarY-=speed;
                toolBarCurrentHeight+=speed;
                animating = true;
            } else { animating = false; }
            drawOpen(canvas);
        } else {
            // animation
            if(toolBarMinHeight < toolBarCurrentHeight) {
                toolBarY+=speed;
                toolBarCurrentHeight-=speed;
                animating = true;
                drawOpen(canvas);
            } else {
                animating = false;
                drawClose(canvas);
            }
        }
    }

    private void drawClose(Canvas canvas) {
        // draw background
        canvas.drawRect(toolBarX, toolBarY, screenWidth, (toolBarY + toolBarMinHeight), bluePaintShape);

        // draw btn
        canvas.drawText("Open", (toolBarWidth / 2), (toolBarY + (toolBarMinHeight / 2) + 5), whitePaintShape);
    }

    private void drawOpen(Canvas canvas) {
        // draw background
        canvas.drawRect(toolBarX, toolBarY, screenWidth, (toolBarY+toolBarMaxHeight), bluePaintShape);

        // draw sizes
        sizesX = toolBarX + toolBarPadding;
        sizesY = toolBarY + toolBarMinHeight + toolBarPadding;
        canvas.drawText("Sizes", sizesX, sizesY, whitePaintShape);
        sizesY += sizeTitle;
        if(dotSize == SIZE_1) {
            canvas.drawRect(sizesX + (0*sizesWidth) + (0*toolBarPadding), sizesY, sizesX + (1*sizesWidth) + (0*toolBarPadding), sizesY + sizesHeight, yellowPaintShape);
        } else if (dotSize == SIZE_2){
            canvas.drawRect(sizesX + (1*sizesWidth) + (1*toolBarPadding), sizesY, sizesX + (2*sizesWidth) + (1*toolBarPadding), sizesY + sizesHeight, yellowPaintShape);
        } else if (dotSize == SIZE_3) {
            canvas.drawRect(sizesX + (2*sizesWidth) + (2*toolBarPadding), sizesY, sizesX + (3*sizesWidth) + (2*toolBarPadding), sizesY + sizesHeight, yellowPaintShape);
        } else if (dotSize == SIZE_4){
            canvas.drawRect(sizesX + (3*sizesWidth) + (3*toolBarPadding), sizesY, sizesX + (4*sizesWidth) + (3*toolBarPadding), sizesY + sizesHeight, yellowPaintShape);
        }
        canvas.drawText(String.valueOf(SIZE_1), sizesX + (sizesWidth*(float)0.25) + (0*sizesWidth) + (0*toolBarPadding), sizesY + (sizesWidth*(float)0.65), blackPaintShape);
        canvas.drawText(String.valueOf(SIZE_2), sizesX + (sizesWidth*(float)0.25) + (1*sizesWidth) + (1*toolBarPadding), sizesY + (sizesWidth*(float)0.65), blackPaintShape);
        canvas.drawText(String.valueOf(SIZE_3), sizesX + (sizesWidth*(float)0.25) + (2*sizesWidth) + (2*toolBarPadding), sizesY + (sizesWidth*(float)0.65), blackPaintShape);
        canvas.drawText(String.valueOf(SIZE_4), sizesX + (sizesWidth*(float)0.25) + (3*sizesWidth) + (3*toolBarPadding), sizesY + (sizesWidth*(float)0.65), blackPaintShape);

        // draw btn
        canvas.drawText("Close", (toolBarWidth / 2), (toolBarY + (toolBarMinHeight / 2) + 5), whitePaintShape);
    }


}
