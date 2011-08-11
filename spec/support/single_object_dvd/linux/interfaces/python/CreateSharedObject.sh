#!/bin/bash

#Put path of IpLocator Object (libmdIpLocator.so) and Python Include Path. 
mdIpLocatorPath=/DQT/Current
PythonIncludePath='/usr/include/python2.3'

g++ -fpic -c mdIpLocatorPythonWrapper.cpp -I$mdIpLocatorPath -I$PythonIncludePath
g++ -shared mdIpLocatorPythonWrapper.o -o _mdIpLocatorPythonWrapper.so -L$mdIpLocatorPath -lmdIpLocator -pthread

rm mdIpLocatorPythonWrapper.o
