DIR=/opt/melissadata/lib
RUBYDIR=/usr/local/rvm/rubies/ruby-1.8.7-p352/lib/ruby/1.8/x86_64-linux
# RUBYDIR=/usr/lib/ruby/1.8/x86_64-linux
CXX=g++
LDLIBS=-L$(DIR) -Wl,-rpath,$(DIR)
FLAGS=-g -O -Wall -pthread -m64
CXXFLAGS=$(FLAGS) -fpic -c $(LDLIBS) -I$(DIR) -I$(RUBYDIR)
LDFLAGS=$(COMMONFLAGS) $(LDLIBS)

all: addr email geo ip name phone

addr: mdAddrRubyWrapper.cpp mdAddr.h mdEnums.h
	$(CXX) $(CXXFLAGS) mdAddrRubyWrapper.cpp
	$(CXX) $(LDFLAGS) -lmdAddr -shared mdAddrRubyWrapper.o -o $(DIR)/mdAddrRubyWrapper.so
	$(RM) mdAddrRubyWrapper.o

email: mdEmailRubyWrapper.cpp mdEmail.h mdEnums.h
	$(CXX) $(CXXFLAGS) mdEmailRubyWrapper.cpp
	$(CXX) $(LDFLAGS) -lmdEmail -shared mdEmailRubyWrapper.o -o $(DIR)/mdEmailRubyWrapper.so
	$(RM) mdEmailRubyWrapper.o

geo: mdGeoRubyWrapper.cpp mdGeo.h mdEnums.h
	$(CXX) $(CXXFLAGS) mdGeoRubyWrapper.cpp
	$(CXX) $(LDFLAGS) -lmdGeo -shared mdGeoRubyWrapper.o -o $(DIR)/mdGeoRubyWrapper.so
	$(RM) mdGeoRubyWrapper.o

ip: mdIpLocatorRubyWrapper.cpp mdIpLocator.h mdEnums.h
	$(CXX) $(CXXFLAGS) mdIpLocatorRubyWrapper.cpp
	$(CXX) $(LDFLAGS) -lmdIpLocator -shared mdIpLocatorRubyWrapper.o -o $(DIR)/mdIpLocatorRubyWrapper.so
	$(RM) mdIpLocatorRubyWrapper.o

name: mdNameRubyWrapper.cpp mdName.h mdEnums.h
	$(CXX) $(CXXFLAGS) mdNameRubyWrapper.cpp
	$(CXX) $(LDFLAGS) -lmdName -shared mdNameRubyWrapper.o -o $(DIR)/mdNameRubyWrapper.so
	$(RM) mdNameRubyWrapper.o

phone: mdPhoneRubyWrapper.cpp mdPhone.h mdEnums.h
	$(CXX) $(CXXFLAGS) mdPhoneRubyWrapper.cpp
	$(CXX) $(LDFLAGS) -lmdPhone -shared mdPhoneRubyWrapper.o -o $(DIR)/mdPhoneRubyWrapper.so
	$(RM) mdPhoneRubyWrapper.o
