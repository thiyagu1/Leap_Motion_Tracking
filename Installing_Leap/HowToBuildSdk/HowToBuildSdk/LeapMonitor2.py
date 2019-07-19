#
# Get Leap Motion camera images 
#
# https://developer.leapmotion.com/documentation/python/devguide/Leap_Images.html

import os, sys
import cv2, Leap, math, ctypes
import numpy as np

def make_npimage(image):
    #wrap image data in numpy array
    i_address = int(image.data.cast().__int__())
    ctype_array_def = ctypes.c_ubyte * image.height * image.width
    # as ctypes array
    as_ctype_array = ctype_array_def.from_address(i_address)
    # as numpy array
    as_numpy_array = np.ctypeslib.as_array(as_ctype_array)
    img = np.reshape(as_numpy_array, (image.height, image.width))
    
    return img


def run(controller):

    while(True):
        frame = controller.frame()
        image = frame.images[0]
        if image.is_valid:
            #display images
            cv2.imshow('Left Camera', make_npimage(frame.images[0]))
            cv2.imshow('Right Camera', make_npimage(frame.images[1]))

            if cv2.waitKey(1) & 0xFF == ord('q'):
                break


def main():
    controller = Leap.Controller()
    controller.set_policy_flags(Leap.Controller.POLICY_IMAGES)
    try:
        run(controller)
    except KeyboardInterrupt:
        sys.exit(0)
        
if __name__ == '__main__':
    main()