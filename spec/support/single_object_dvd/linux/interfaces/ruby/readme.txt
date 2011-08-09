
Ruby wrappers for IpLocator Object on Linux

************
INTRODUCTION
************

This file describes how to set up and use the Ruby wrapper code with Melissa DATA's IpLocator Object.


*************
PREREQUISITES
*************

To make use of the IpLocator Object Ruby wrapper you will need:

* An installation of a Ruby. This Wrapper tested with Ruby 1.8.1

* The Melissa DATA IpLocator Object library and data files installed.

You will need to know the location of these items in order to install and run the Ruby wrapper.


*************
Installation
*************

Copy the entire folder that contains this readme.txt into a local directory on your computer.


*****
Setup
*****

Open CreateSharedObject.sh for editing. Put in the paths to the IpLocator object library
(libmdIpLocator.so) and the Ruby include directory. After the paths have been correctly set,
run CreateSharedObject.sh (sh CreateSharedObject.sh) and mdIpLocatorRubyWrapper.so will
be created. This step must be completed successfully to run the Ruby sample.


************
Dependencies
************

You will need to allow mdIpLocatorRubyWrapper.so to find libmdIpLocator.so. You can do this by:

	1. Set LD_LIBRARY_PATH to the directory containing libmdIpLocator.so. 
		ex: export LD_LIBRARY_PATH=/DQT/Current

	or

	2. Copy libmdIpLocator.so into the directory with _mdIpLocatorRubyWrapper.so.



**************************
Setting up the Sample Code
**************************

Open IpLocatorSample.py for editing. You must set the a license string that you receive from your Melissa Data sales representative and the path to the addr data files:
License = "License Here"
DataPath = "/DQT/Current"


***********************
Running the Sample Code
***********************

Navigate to the directory containing the ruby wrapper using command line and type:
	ruby IpLocatorSample.rb

*******
Updates
*******

The wrapper does not need to be rebuilt for updates. Simply replace the IpLocator Object (libmdIpLocator.so and data files. However, if there is a new method added, you will need to rebuild the wrapper to use that new method.

****
Note
****

Here are some general solutions if you run into problems:

Q. I get an error saying "libmdIpLocator.so: shared object cannot be opened ."
A. This means that mdIpLocatorRubyWrapper.so cannot link to libmdIpLocator.so. Please following one of the steps in the Setup section above.



COPYRIGHT NOTICE

(C) 2009 Melissa Data Corporation. All rights reserved.
