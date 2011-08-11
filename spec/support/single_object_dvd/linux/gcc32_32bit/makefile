#
# Melissa Data IpLocator Object for Linux
#
# sample makefile for customers
#
# This assumes that the object file and header files are in the directory
# that we are invoking this makefile from.  If they are not, just change
# where the "DIR" variable below points to.
DIR=.

CXX=g++
CXXFLAGS=-g -O -Wall -I$(DIR) -pthread
LDLIBS=-L$(DIR) -Wl,-rpath,$(DIR)

all: iplocator_sample

iplocator_sample:	iplocator_sample.cpp $(DIR)/mdIpLocator.h $(DIR)/mdEnums.h
	$(CXX) $(CXXFLAGS) iplocator_sample.cpp -o $@ $(LDLIBS) -lmdIpLocator

clean:
	$(RM) iplocator_sample

