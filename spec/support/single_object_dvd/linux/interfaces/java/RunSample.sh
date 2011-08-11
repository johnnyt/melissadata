#!/bin/bash

#Set IpLocatorLibraryPath to directory of libmdIpLocator.so
IpLocatorLibraryPath=/DQT/Current/

export LD_LIBRARY_PATH=$IpLocatorLibraryPath
javac -classpath "mdIpLocator.jar" IpLocatorSample.java
java -Djava.library.path=.:$IpLocatorLibraryPath -classpath ".:mdIpLocator.jar" IpLocatorSample 
