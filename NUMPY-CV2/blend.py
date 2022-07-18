import cv2
import numpy as np
import PIL
#You can use OpenCV function addWeighted like:
def blend(arg1, arg2):
    img1 = np.float32(PIL.Image.open(arg1));
    img2 = np.float32(PIL.Image.open(arg2));
    result = cv2.addWeighted(img1,0.5,img2,0.5,0);
    return result
