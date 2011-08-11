#!/bin/bash

#Set Path to IpLocator Object Library Files
mdIpLocatorPath=/DQT/Current

#Set Path to Java JDK include directories
JavaIncludeDirectory1=/usr/java/jdk1.6.0_06/include
JavaIncludeDirectory2=/usr/java/jdk1.6.0_06/include/linux

gcc -fpic -c -I$mdIpLocatorPath -I$JavaIncludeDirectory1 -I$JavaIncludeDirectory2 mdIpLocatorJavaWrapper.cpp
gcc -g -shared mdIpLocatorJavaWrapper.o -o libmdIpLocatorJavaWrapper.so -L$mdIpLocatorPath -lmdIpLocator -pthread

rm mdIpLocatorJavaWrapper.o


#Build Jar File
cd com/melissadata
javac *.java
cd ../..
jar cf mdIpLocator.jar com
