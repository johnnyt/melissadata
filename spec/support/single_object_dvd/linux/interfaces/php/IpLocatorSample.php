
<?php

#********************************************************************************
#If you should have any comments, suggestions or improvements to these samples,
#we welcome you to contact us at SampleCode@melissadata.com also please visit our
#developers bulletin board at forum.melissadata.com.
#********************************************************************************

#! /usr/bin/php


include './mdIpLocatorPHPWrapper.php';

#Put License and Directory of IpLocator Object Data Files here

//********************** LICENSE STRINGS ***********************
//*     To unlock the functionality of IpLocator Object,      *
//*     	     You must have a license string.           	*
//* Please call a sales representative at 1-800-MELISSA ext. 3 *
//*         (1-800-635-4772 x3) for a license string.          *
//**************************************************************/

$License = "License Here";
$DataPath = "/DQT/Current";

#Create New Object
$ipObj = new mdIpLocator();

#Set License String
$ipObj->SetLicenseString($License);

#Set Data Path and Initialize
$ipObj->SetPathToIpLocatorFiles($DataPath);

if($ipObj->InitializeDataFiles() != 0)
{
	print "Cannot Initialize: ".$ipObj->GetInitializeErrorString()."\n";
	exit;
}

# Print Initialized Information
print "Build:".$ipObj->GetBuildNumber()."\n";
print "Database Date: ".$ipObj->GetDatabaseDate()."\n";
print "Database Expiration Date: ".$ipObj->GetDatabaseExpirationDate()."\n";
print "License Expiration Date: ".$ipObj->GetLicenseStringExpirationDate()."\n";

#Get Input
print "Enter IP Address: ";
$ipaddress = trim(fgets(STDIN));

$ipObj->LocateIpAddress($ipaddress);

if(strpos($ipObj->GetResults(),"IS01") !== false)
{
	print "Latitude: " . $ipObj->GetLatitude() . "\n";
	print "Longitude: ". $ipObj->GetLongitude() . "\n";
	print "City: " . $ipObj->GetCity() . "\n";
	print "Region: " . $ipObj->GetRegion() . "\n";	
	print "Zip: " . $ipObj->GetZip() . "\n";
      print "Country: " . $ipObj->GetCountry() . "\n";
      print "Country Abbreviation: " . $ipObj->GetCountryAbbreviation() . "\n";
 	print "Domain Name: " . $ipObj->GetDomainName() . "\n";
	print "ISP: " . $ipObj->GetISP() . "\n";
}
elseif(strpos($ipObj->GetResults(),"IS02") !== false)
{
	# Display results
	print "IP Address not found. \n";
}
elseif(strpos($ipObj->GetResults(),"IE01") !== false)
{
	# Display results
	print "IP Address empty or not well formed. \n";
}

?>
