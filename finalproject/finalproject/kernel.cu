#include <stdio.h>
#include <stdlib.h>
#include <cv.h>

#include <opencv2/core/core.hpp>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>

uchar blue[700][825];
uchar green[700][825];
uchar red[700][825];

int main()
{

	IplImage* img1 = cvLoadImage("1.jpg");
	IplImage* img2 = cvLoadImage("2.jpg");

	int i, j, index;
	int flag = false;
	int x = 0, y = 0;
	int height, width, step, channels;
	uchar* data1, * data2;
	

	// get the image data
	height = img1->height;
	width = img1->width;
	step = img1->widthStep;
	channels = img1->nChannels;
	data1 = (uchar*)img1->imageData;
	data2 = (uchar*)img2->imageData;

	printf("Processing a %dx%d image with %d channels, and %d steps.\n", height, width, channels, step);


	// create a window
	cvNamedWindow("img1", CV_WINDOW_AUTOSIZE);
	cvNamedWindow("img2", CV_WINDOW_AUTOSIZE);
	cvMoveWindow("mainWin", 100, 100);

	// load rgb
	for (i = 0; i < height; i++)
	{
		for (j = 0; j < step; j=j+3)
		{
			blue[i][(int)(j / 3)] = img1->imageData[i * img1->widthStep + j];
			green[i][(int)(j / 3)] = img1->imageData[i * img1->widthStep + j + 1];
			red[i][(int)(j / 3)] = img1->imageData[i * img1->widthStep + j + 2];					
		}
	}

	for (i = 0; i < height; i++)
	{
		for (j = 0; j < step; j = j + 3)
		{
			if (blue[i][(int)(j / 3)] < 30 && green[i][(int)(j / 3)] <30 && red[i][(int)(j / 3)] <30)
			{		
				if (x < img2->height && y < img2->widthStep)
				{
					data1[i * img1->widthStep + j] = data2[x * img2->widthStep + y];
					data1[i * img1->widthStep + j + 1] = data2[x * img2->widthStep + y + 1];
					data1[i * img1->widthStep + j + 2] = data2[x * img2->widthStep + y + 2];
					y = y + 3;
					flag = true;
				}
			}
		}
		if (flag) {
			y = 0;
			x = x + 1;
			flag = false;
		}
	}

	// show the image
	cvShowImage("img1", img1);
	cvShowImage("img2", img2);


	// wait for a key
	cvWaitKey(0);

	// release the image
	cvReleaseImage(&img1);

	return 0;
}