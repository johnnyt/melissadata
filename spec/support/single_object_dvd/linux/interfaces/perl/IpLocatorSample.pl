
#********************************************************************************
#If you should have any comments, suggestions or improvements to these samples, 
#we welcome you to contact us at SampleCode@melissadata.com also please visit our 
#developers bulletin board at forum.melissadata.com.
#********************************************************************************

use mdIpLocatorPerlWrapper;


my $LICENSE = "License Here";
my $FILELOC = "/DQT/Current";

#.................................................................................


$ipObj = new mdIpLocatorPerlWrapper::mdIpLocator();

# ********************** LICENSE STRINGS ***********************
# *     To unlock the full functionality of IpLocator Object,    *
# * please call a sales representative at 1-800-MELISSA ext. 3 * 
# *         (1-800-635-4772 x3) for a license string.          *
# *      Without a valid license string, IpLocatorCheck will     *
# *                	not function.      		         *
# **************************************************************
        
# Set the License String 
$ipObj->SetLicenseString($LICENSE);


# Set paths for data files in Initialize method
$ipObj->SetPathToIpLocatorFiles($FILELOC);

my $InitResult = $ipObj->InitializeDataFiles();
if ($InitResult != 0)
{
	printf $ipObj->GetInitializeErrorString(), "\n";
	die "Cannot Initialize IpLocator Object";	
}

#.................................................................................

# Get the Build number and DB Date

print "========================================================================\n";
print "Build Number: ", $ipObj->GetBuildNumber(), "\n";
print "Initialize Status: ", $ipObj->GetInitializeErrorString(), "\n";
print "========================================================================\n";

print "Database Date: ", $ipObj->GetDatabaseDate(), "\n";
print "Database Expiration Date: ", $ipObj->GetDatabaseExpirationDate(), "\n";
print "License Expiration Date: ", $ipObj->GetLicenseStringExpirationDate(), "\n";

#.................................................................................
$ipaddress = "";
while(substr($ipaddress,0,1) ne "X")
{
	print "Enter IP Address (X to quit):";
	$ipaddress = <>;
	$ipObj->LocateIpAddress($ipaddress);

	if(index($ipObj->GetResults(),"IS01")> -1)
	{

		print "Latitude: " , $ipObj->GetLatitude() , "\n";
		print "Longitude: ", $ipObj->GetLongitude() , "\n";
		print "City: " , $ipObj->GetCity() , "\n";
		print "Region: " , $ipObj->GetRegion() , "\n";	
		print "Zip: " , $ipObj->GetZip() , "\n";
      	print "Country: " , $ipObj->GetCountry() , "\n";
      	print "Country Abbreviation: " , $ipObj->GetCountryAbbreviation() , "\n";
 	     print "Domain Name: " , $ipObj->GetDomainName() , "\n";
		print "ISP: " , $ipObj->GetISP() , "\n";
		}
	elsif(index($ipObj->GetResults(),"IS02")> -1)
	{
		print "IP Address Unknown. \n";
	}
	elsif(index($ipObj->GetResults(),"IE01")> -1)
	{
		print "IP Address Empty or Not Well Formed. \n";
	}

	print "========================================================================\n";
}

