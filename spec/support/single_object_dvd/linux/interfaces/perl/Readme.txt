
Perl wrappers for IpLocator Object on Linux

************
INTRODUCTION
************

This file describes how to set up and use the perl wrapper code with Melissa DATA's IpLocator Object.


*************
PREREQUISITES
*************

To make use of the IpLocator Object perl wrapper you will need:

* An installation of a Perl. Wrapper tested with Perl 5.8 and Perl 5.10. 

* The Melissa DATA IpLocator Object library and data files installed.

You will need to know the location of these items in order to install and run the java wrapper.


*************
Installation
*************

Copy the entire folder that contains this readme.txt into a local directory on your computer.

*****
Setup
*****

Open CreateSharedObject.sh for editing. Put in the paths to the IpLocator object library
(libmdIpLocator.so) and the perl CORE directory. After the paths have been correctly set,
run CreateSharedObject.sh (sh CreateSharedObject.sh) and mdIpLocatorPerlWrapper.so will
be created. This step must be completed successfully to run the perl sample.

************
Dependencies
************

You will need to allow mdIpLocatorPerlWrapper.so to find libmdIpLocator.so. You can do this by:

	1. Set LD_LIBRARY_PATH to the directory containing libmdIpLocator.so. 
		ex: Export LD_LIBRARY_PATH=/DQT/Current

	or

	2. Copy libmdIpLocator.so into the directory with mdIpLocatorPerlWrapper.so.



**************************
Setting up the Sample Code
**************************

Open IpLocatorSample.pl for editing. You must set the a license string that you receive from your Melissa Data
sales representative:
	$addrObj->SetLicenseString('License Here');

and also the path to the IpLocator Object Data Files:
	$addrObj->SetPathToIpLocatorFiles('path');


***********************
Running the Sample Code
***********************

Navigate to the directory containing the perl wrapper using command line and type:
	'perl IpLocatorSample.pl'

*******
Updates
*******

The wrapper does not have to be rebuilt for updates. Simply replace IpLocator Object (libmdIpLocator.so) and the data files. However, if there is a new method, you will need to rebuild the wrapper to use it.


****
Note
****

Here are some general solutions if you run into problems:

Q. I get an error saying "libmdIpLocator.so: shared object cannot be opened ."
A. This means that mdIpLocatorPerlWrapper.so cannot link to libmdIpLocator.so. Please following one of the steps in the Setup section above.
 
COPYRIGHT NOTICE

(C) 2009 Melissa Data Corporation. All rights reserved.
