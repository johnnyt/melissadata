#!/bin/bash

#Set Path to IpLocator Object Library (libmdIpLocator.so) and Perl CORE directory
mdIpLocatorPath=/DQT/Current
PerlIncludePath=/usr/lib/perl5/5.8.5/i386-linux-thread-multi/CORE

g++ -fpic -c -I$mdIpLocatorPath -I$PerlIncludePath -DHAS_BOOL mdIpLocatorPerlWrapper.cpp
g++ -shared -o libmdIpLocatorPerlWrapper.so -L$mdIpLocatorPath -lmdIpLocator -pthread mdIpLocatorPerlWrapper.o

rm mdIpLocatorPerlWrapper.o
