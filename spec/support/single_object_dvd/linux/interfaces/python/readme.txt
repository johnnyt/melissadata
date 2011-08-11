
Python wrappers for IpLocatorObject on Linux

************
INTRODUCTION
************

This file describes how to set up and use the Python wrapper code with Melissa DATA's IpLocatorObject.


*************
PREREQUISITES
*************

To make use of the IpLocatorObject Python wrapper you will need:

* An installation of a Python. This Wrapper tested with Python 2.3.4

* The Melissa DATA IpLocatorObject library and data files installed.

You will need to know the location of these items in order to install and run the Python wrapper.


*************
Installation
*************

Copy the entire folder that contains this readme.txt into a local directory on your computer.


*****
Setup
*****

Open CreateSharedObject.sh for editing. Put in the paths to the addr object library
(libmdIpLocator.so) and the Python include directory. After the paths have been correctly set,
run CreateSharedObject.sh (sh CreateSharedObject.sh) and _mdIpLocatorPythonWrapper.so will
be created. This step must be completed successfully to run the Python sample.


************
Dependencies
************

You will need to allow _mdIpLocatorPythonWrapper.so to find libmdIpLocator.so. You can do this by:

	1. Set LD_LIBRARY_PATH to the directory containing libmdIpLocator.so. 
		ex: export LD_LIBRARY_PATH=/DQT/Current

	or

	2. Copy libmdIpLocator.so into the directory with _mdIpLocatorPythonWrapper.so.



**************************
Setting up the Sample Code
**************************

Open IpLocatorSample.py for editing. You must set the a license string that you receive from your Melissa Data
sales representative:
	License = "License Here"

and also the path to the IpLocatorObject Data Files:
	DataPath = r"/DQT/Current"


***********************
Running the Sample Code
***********************

Navigate to the directory containing the python wrapper using command line and type:
	python IpLocatorSample.py

*******
Updates
*******

The wrapper does not need to be rebuilt for every update. Simply replace IpLocator Object (libmdIpLocator.so) and the data files. However, if there is a new method added, you will need to rebuild the wrapper to use that new method.

****
Note
****

Here are some general solutions if you run into problems:

Q. I get an error saying "libmdIpLocator.so: shared object cannot be opened ."
A. This means that _mdIpLocatorPythonWrapper.so cannot link to libmdIpLocator.so. Please following one of the steps in the Setup section above.

Q. I get a warning saying "_POSIX_C_SOURCE" has been redefined.
A. This warning does not affect the functionality of the wrapper. However, to
remove this warning, go into mdIpLocatorPythonWrapper.cpp and move
#include<Python.h> from the middle of the file (line 147) to the very top. 

COPYRIGHT NOTICE

(C) 2009 Melissa Data Corporation. All rights reserved.
