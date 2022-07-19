showme.cpp
//#include </usr/include/opencv4/opencv.hpp>
//#include <cv.h>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui.hpp>
#include <iostream>
using namespace cv;
using namespace std;
int main(int argc,char **argv)
{
   Mat image;
   image = imread(argv[1],1);

   if(argc != 2 || !image.data)
   {
       cout << "No image data\n";
       return -1;
   }

   namedWindow("Image Viewer",CV_WINDOW_AUTOSIZE);
   imshow("Image Viewer",image);
   waitKey(0);
   return 0;
}
