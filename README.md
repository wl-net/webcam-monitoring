WLNet Webcam Monitoring
=================

Takes pictures from a webcam and copies to a remote location

Installation
------------

* Ensure that ImageMagick is installed and the `convert` utility is available.
* Install [camshot](http://code.google.com/p/camshot/). Follow the installation instructions on the page, and make sure that the second example works.
* Create a directory and place the camera-capture script in it.

Configuration
-------------

Change the `WORKING_DIRECTORY` variable in the camera-capture script to be the directory that the script is located in.

Usage
-----

Invoke the script, and ensure that pictures are being placed in the `$WORKING_DIRECTORY/data` directory.
