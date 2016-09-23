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
    private int dotColor;

    public boolean toolBarOpen = false;

    Paint whitePaintShape;
    Paint bluePaintShape;
    Paint yellowPaintShape;
    Paint blackPaintShape;

    int sizesX, colorsX;
    int sizesY, colorsY;
    int sizesWidth = 100, colorsWidth = 200;
    int sizesHeight = 100, colorsHeight = 100;
    int sizeTitle = 50, colorTitle = 50;

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
        //bluePaintShape.setARGB(1, 100, 150, 255);
        bluePaintShape.setColor(0xff4488ff);
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
        dotColor = Color.BLACK;

        //Log.d(TAG, "toolBarMinHeight: " + toolBarMinHeight + " -- toolBarCurrentHeight: " + toolBarCurrentHeight + " -- toolBarMaxHeight: " + toolBarMaxHeight);
        //Log.d(TAG, "screenWidth: " + screenWidth + " -- screenHeight: " + screenHeight);
        //Log.d(TAG, "toolBarX: " + toolBarX + " -- toolBarY: " + toolBarY);
    }

    public int getDotSize() { return dotSize; }
    public int getDotColor() { return dotColor; }

    public void handleActionDown(int eventX, int eventY) {
        if (!animating) {
            if (toolBarOpen) {
                // test if closing toolbar
                if (eventX >= toolBarX && eventX <= (toolBarX + toolBarWidth) && eventY >= toolBarY && eventY <= (toolBarY + toolBarMinHeight)) {
                    toolBarOpen = false;
                }

                // update the size positions
                sizesX = toolBarX + toolBarPadding;
                sizesY = (toolBarY + toolBarMinHeight + toolBarPadding) + sizeTitle;

                // test if pressed different size
                if(eventX >= sizesX + (0*sizesWidth) + (0*toolBarPadding) && eventX <= sizesX + (1*sizesWidth) + (0*toolBarPadding) && eventY >= sizesY && eventY <= sizesY + sizesHeight) {
                    dotSize = SIZE_1;
                }
                if(eventX >= sizesX + (1*sizesWidth) + (1*toolBarPadding) && eventX <= sizesX + (2*sizesWidth) + (1*toolBarPadding) && eventY >= sizesY && eventY <= sizesY + sizesHeight) {
                    dotSize = SIZE_2;
                }
                if(eventX >= sizesX + (2*sizesWidth) + (2*toolBarPadding) && eventX <= sizesX + (3*sizesWidth) + (2*toolBarPadding) && eventY >= sizesY && eventY <= sizesY + sizesHeight) {
                    dotSize = SIZE_3;
                }
                if(eventX >= sizesX + (3*sizesWidth) + (3*toolBarPadding) && eventX <= sizesX + (4*sizesWidth) + (3*toolBarPadding) && eventY >= sizesY && eventY <= sizesY + sizesHeight) {
                    dotSize = SIZE_4;
                }

                // update the color positions
                colorsX = toolBarX + toolBarPadding;
                colorsY = (sizesY + sizesHeight + (2*toolBarPadding) + colorTitle) + colorTitle;

                // test if pressed different size
                if(eventX >= sizesX + (0*colorsWidth) + (0*toolBarPadding) && eventX <= colorsX + (1*colorsWidth) + (0*toolBarPadding) && eventY >= colorsY && eventY <= colorsY + colorsHeight) {
                    dotColor = Color.BLACK;
                }
                if(eventX >= sizesX + (1*colorsWidth) + (1*toolBarPadding) && eventX <= colorsX + (2*colorsWidth) + (1*toolBarPadding) && eventY >= colorsY && eventY <= colorsY + colorsHeight) {
                    dotColor = Color.BLUE;
                }
                if(eventX >= sizesX + (2*colorsWidth) + (2*toolBarPadding) && eventX <= colorsX + (3*colorsWidth) + (2*toolBarPadding) && eventY >= colorsY && eventY <= colorsY + colorsHeight) {
                    dotColor = Color.RED;
                }
                if(eventX >= sizesX + (3*colorsWidth) + (3*toolBarPadding) && eventX <= colorsX + (4*colorsWidth) + (3*toolBarPadding) && eventY >= colorsY && eventY <= colorsY + colorsHeight) {
                    dotColor = Color.GREEN;
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
        canvas.drawText(String.valueOf(SIZE_1), sizesX + (sizesWidth*(float)0.25) + (0*sizesWidth) + (0*toolBarPadding), sizesY + (sizesHeight*(float)0.65), blackPaintShape);
        canvas.drawText(String.valueOf(SIZE_2), sizesX + (sizesWidth*(float)0.25) + (1*sizesWidth) + (1*toolBarPadding), sizesY + (sizesHeight*(float)0.65), blackPaintShape);
        canvas.drawText(String.valueOf(SIZE_3), sizesX + (sizesWidth*(float)0.25) + (2*sizesWidth) + (2*toolBarPadding), sizesY + (sizesHeight*(float)0.65), blackPaintShape);
        canvas.drawText(String.valueOf(SIZE_4), sizesX + (sizesWidth*(float)0.25) + (3*sizesWidth) + (3*toolBarPadding), sizesY + (sizesHeight*(float)0.65), blackPaintShape);

        // draw colors
        colorsX = toolBarX + toolBarPadding;
        colorsY = sizesY + sizesHeight + (2*toolBarPadding) + colorTitle;
        canvas.drawText("Colors", colorsX, colorsY, whitePaintShape);
        colorsY += colorTitle;
        if(dotColor == Color.BLACK) {
            canvas.drawRect(colorsX + (0*colorsWidth) + (0*toolBarPadding), colorsY, colorsX + (1*colorsWidth) + (0*toolBarPadding), colorsY + colorsHeight, yellowPaintShape);
        } else if (dotColor == Color.BLUE){
            canvas.drawRect(colorsX + (1*colorsWidth) + (1*toolBarPadding), colorsY, colorsX + (2*colorsWidth) + (1*toolBarPadding), colorsY + colorsHeight, yellowPaintShape);
        } else if (dotColor == Color.RED) {
            canvas.drawRect(colorsX + (2*colorsWidth) + (2*toolBarPadding), colorsY, colorsX + (3*colorsWidth) + (2*toolBarPadding), colorsY + colorsHeight, yellowPaintShape);
        } else if (dotColor == Color.GREEN){
            canvas.drawRect(colorsX + (3*colorsWidth) + (3*toolBarPadding), colorsY, colorsX + (4*colorsWidth) + (3*toolBarPadding), colorsY + colorsHeight, yellowPaintShape);
        }
        canvas.drawText("Black", colorsX + (colorsWidth*(float)0.25) + (0*colorsWidth) + (0*toolBarPadding), colorsY + (colorsHeight*(float)0.65), blackPaintShape);
        canvas.drawText("Blue",  colorsX + (colorsWidth*(float)0.25) + (1*colorsWidth) + (1*toolBarPadding), colorsY + (colorsHeight*(float)0.65), blackPaintShape);
        canvas.drawText("Red",   colorsX + (colorsWidth*(float)0.25) + (2*colorsWidth) + (2*toolBarPadding), colorsY + (colorsHeight*(float)0.65), blackPaintShape);
        canvas.drawText("Green", colorsX + (colorsWidth*(float)0.25) + (3*colorsWidth) + (3*toolBarPadding), colorsY + (colorsHeight*(float)0.65), blackPaintShape);

        // draw btn
        canvas.drawText("Close", (toolBarWidth / 2), (toolBarY + (toolBarMinHeight / 2) + 5), whitePaintShape);
    }


}
