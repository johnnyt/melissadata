#!/bin/bash

#Insert Path to IpLocator Object Library (libmdIpLocator.so) and Ruby Include Path
mdIpLocatorPath=/DQT/Current
RubyIncludePath=/usr/lib/ruby/1.8/i386-linux-gnu

g++ -fpic -c -I$mdIpLocatorPath -I$RubyIncludePath mdIpLocatorRubyWrapper.cpp 
g++ -shared mdIpLocatorRubyWrapper.o -o mdIpLocatorRubyWrapper.so -L$mdIpLocatorPath -lmdIpLocator -pthread

rm mdIpLocatorRubyWrapper.o
