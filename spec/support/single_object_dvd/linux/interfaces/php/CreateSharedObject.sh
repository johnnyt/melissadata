#!/bin/bash

mdIpLocatorPath=/DQT/Current
PHPIncludePath1=/usr/include/php-5.2.6/Zend
PHPIncludePath2=/usr/include/php-5.2.6/main
PHPIncludePath3=/usr/include/php-5.2.6
PHPIncludePath4=/usr/include/php-5.2.6/TSRM

g++ -fpic -c mdIpLocatorPHPWrapper.cpp -I$mdIpLocatorPath -I$PHPIncludePath1 -I$PHPIncludePath2 -I$PHPIncludePath3 -I$PHPIncludePath4
g++ -shared mdIpLocatorPHPWrapper.o -o mdIpLocatorPHPWrapper.so -L$mdIpLocatorPath -lmdIpLocator -pthread

rm mdIpLocatorPHPWrapper.o
