# ********************************************************************************
# If you should have any comments, suggestions or improvements to these samples, 
# we welcome you to contact us at SampleCode@melissadata.com also please visit our 
# developers bulletin board at forum.melissadata.com.
# ********************************************************************************

import mdIpLocatorPythonWrapper

#/********************** LICENSE STRINGS **********************
#*     To unlock the full functionality of IpLocator Object,    *
#* please call a sales representative at 1-800-MELISSA ext. 3 *
#*         (1-800-635-4772 x3) for a license string.          *
#*  IpLocator Object will not function without a valid *
#*      			  license string 			          *
#**************************************************************/

# Put your License String and Path to IpLocator Object Data Files here
License = r"License Here"
DataPath = r"/DQT/Current"


# Create IpLocator Object
ipObj = mdIpLocatorPythonWrapper.mdIpLocator()

# Set License String
ipObj.SetLicenseString(License)
    
# Initialize Data Files
ipObj.SetPathToIpLocatorFiles(DataPath)

result = ipObj.InitializeDataFiles()

if result != 0:
    print "Initialize Error: ", ipObj.GetInitializeErrorString()
    exit()

print "======================================"
print "BuildNumber: ", ipObj.GetBuildNumber() 
print "Database Date: ", ipObj.GetDatabaseDate()
print "Database Expiration Date: ", ipObj.GetDatabaseExpirationDate()
print "License Expiration Date: ", ipObj.GetLicenseStringExpirationDate()
print "======================================\n"

while(1):
    ipaddress = raw_input("Enter IP Addres: ")
    
    ipObj.LocateIpAddress(ipaddress)

    if ipObj.GetResults().find('IS01') != -1:
        print "Latitude: " , ipObj.GetLatitude()
        print "Longitude: " , ipObj.GetLongitude()
        print "City: " , ipObj.GetCity()
        print "Region: " , ipObj.GetRegion()
	print "Zip: " , ipObj.GetZip()
        print "Country: " , ipObj.GetCountry()
        print "Country Abbreviation: " , ipObj.GetCountryAbbreviation()
	print "Domain Name: " , ipObj.GetDomainName()
        print "ISP: " ,ipObj.GetISP()
        print "\n"
    elif ipObj.GetResults().find('IS02') != -1:
        print "IP Address not found"
    elif ipObj.GetResults().find('IE01') != -1:
        print "IP Address empty or not well formed"
       
        print "\n"


