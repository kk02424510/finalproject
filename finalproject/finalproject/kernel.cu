#include <stdio.h>
#include <stdlib.h>
#include <cv.h>

#include <opencv2/core/core.hpp>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>

int main()
{

	IplImage* img1 = cvLoadImage("1.jpg");
	IplImage* img2 = cvLoadImage("2.jpg");

	int i, j, k,a = 0,b = 0, index ,index2;
	int height, width, step, channels;
	int height2, width2, step2, channels2;
	int flag = false ;

	uchar* data1, * data2;


	// get the image data
	height = img1->height;
	width = img1->width;
	step = img1->widthStep;
	height2 = img2->height;
	width2 = img2->width;
	step2 = img2->widthStep;
	channels = img1->nChannels;
	channels2 = img2->nChannels;
	data1 = (uchar*)img1->imageData;
	data2 = (uchar*)img2->imageData;

	printf("Processing a %dx%d image with %d channels, and %d steps.\n", height, width, channels, step);


	// create a window
	cvNamedWindow("mainWin", CV_WINDOW_AUTOSIZE);
	cvMoveWindow("mainWin", 100, 100);

	// mix the image
	for (i = 0; i < height; i++)
	{
		for (j = 0; j < width; j++)
		{
			for (k = 0; k < channels; k++)
			{
				index = i * step + j * channels + k;

				if (k % 3 == 0)
				{
					if (data1[index] < 30 && data1[index + 1] < 30 && data1[index + 2] < 30)
					{	
						
						index2 = a * step2 + b * channels2;
						data1[index] = data2[index2];
						data1[index+1] = data2[index2+1];
						data1[index+2] = data2[index2+2];
						b ++ ;
						flag = true;
					}
				}
			}			
			
		}
		if (flag)
		{
			b = 0, a++;
			flag = false;
		}
		

	}

	// show the image
	cvShowImage("mainWin", img1);

	// wait for a key
	cvWaitKey(0);

	// release the image
	cvReleaseImage(&img1);

	return 0;
}