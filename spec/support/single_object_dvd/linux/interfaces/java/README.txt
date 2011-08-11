Java wrappers for IpLocator Object on Linux

************
INTRODUCTION
************

This file describes how to set up and use the java wrapper code with Melissa DATA's IpLocator Object.


*************
PREREQUISITES
*************

To make use of the IpLocator Object java wrapper you will need:

* An installation of a Java Developer's Kit 1.4.2 or later or an equivalent product.

* The Melissa DATA IpLocator Object library and data files installed.

	Library = libmdIpLocator.so
	Data Files = mdIpLocator.dat

  These files are installed automatically if you run setup.sh. 

You will need to know the location of these items in order to install and run the java wrapper.


*************
Installation
*************

Copy the entire folder that contains this readme.txt into a local directory on your computer.


*****
Setup
*****

Open BuildWrapper.sh. Put the path of the installed IpLocator Object library files into mdIpLocatorPath.
Then, put the paths of the include and include/linux directories from your Java JDK.
	
	ex: mdIpLocatorPath=/DQT/Current
	JavaIncludeDirectory1=/usr/java/jdk1.6.0_06/include
	JavaIncludeDirectory2=/usr/java/jdk1.6.0_06/include/linux

Open RunSample.sh. Put the path of the directory containing libmdIpLocator.so into IpLocatorLibraryPath.

	ex: IpLocatorLibraryPath=/DQT/Current

Also, set the IpLocator Object License string that you receive from your Melissa Data sales representative as 
well as the directory of the IpLocator Object data files in the sample java code IpLocatorSample.java.
	ex: LicenseString="LICENSE"
	DataPath="/DQT/Current"


*******************
Running the Scripts
*******************

1. Execute BuildWrapper.sh (sh BuildWrapper.sh). This should create a file name libmdIpLocatorJavaWrapper.so and mdIpLocator.jar. These files must be created successfully to proceed.

2. Execute RunSample.sh (sh RunSample.sh). This will compile IpLocatorSample.java and ParseZipStreetSample.java.


***********
Sample Code
***********

IpLocatorSample.java contains sample code for using IpLocator Object.
If you make changes to IpLocatorSample.java, you must execute RunSample.sh again to recompile the code.

Now you can build your program, set your environment variables and command lines 
(using the shell scripts as a guideline) and you're ready to go.

*******
Updates
*******

libmdIpLocatorJavaWrapper.so and mdIpLocator.jar build by BuildWrapper.sh do not need to be re-built for every single update. For normal updates, simply replacing libmdIpLocator.so and the data files are enough. However, if there is a change in libmdIpLocator.so like a new method, you will need to rebuild the wrapper to use the new method. 

COPYRIGHT NOTICE

(C) 2009 Melissa Data Corporation. All rights reserved.
