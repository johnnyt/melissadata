require 'mdIpLocatorRubyWrapper'

License = "License Here"
DataPath = "/DQT/Current"

ipObj = MdIpLocatorRubyWrapper::MdIpLocator.new() 

if(ipObj.SetLicenseString(License) == false)
  print "Invalid License.\n"

end

#Set Path and Initialize
ipObj.SetPathToIpLocatorFiles(DataPath)

if(ipObj.InitializeDataFiles() == false)
  print ipObj.GetInitializeErrorString()
  Process.exit
end

print "Build Number: "  + ipObj.GetBuildNumber()  + "\n"
print "Database Date: "  + ipObj.GetDatabaseDate()  + "\n"
print "Database Expiration Date: "  + ipObj.GetDatabaseExpirationDate()  + "\n"
print "License Expiration Date: "  + ipObj.GetLicenseStringExpirationDate()  + "\n"

print "Enter IP Address: "
temp = gets
ipaddress = temp.chomp

ipObj.LocateIpAddress(ipaddress)

if(ipObj.GetResults().include? 'IS01')
print "Latitude: " +ipObj.GetLatitude() + "\n";
print "Longitude: "+ ipObj.GetLongitude() + "\n";
print "City: " + ipObj.GetCity() + "\n";
print "Region: " + ipObj.GetRegion() + "\n";	
print "Zip: " + ipObj.GetZip() +"\n";
print "Country: " + ipObj.GetCountry() + "\n";
print "Country Abbreviation: " + ipObj.GetCountryAbbreviation() + "\n";
print "Domain Name: " + ipObj.GetDomainName() +"\n";
print "ISP: " + ipObj.GetISP() + "\n";
elsif (ipObj.GetResults().include? 'IS02')
print "IP Address not found \n";
elsif(ipObj.GetResults().include? 'IE01')
print "IP Address empty for not well formed \n";
end

print "===============================\n"
