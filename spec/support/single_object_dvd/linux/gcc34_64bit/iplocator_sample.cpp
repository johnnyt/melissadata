/*********************************************************************************
                       IPLocator OBJECT C++ SAMPLE
  If you should have any comments, suggestions or improvements to these samples, 
  we welcome you to contact us at SampleCode@melissadata.com also please visit our 
  developer’s bulletin board at forum.melissadata.com.
 ********************************************************************************/


#include <iostream>
#include <string>
#include "mdIpLocator.h"

using namespace std;

void put_iplocator(mdIpLocator *il);
void prompt_user(const char* const prompt, string& outval);

int main(int argc, char * argv[])
{
  //instantiate the object
  mdIpLocator * iplocator = new mdIpLocator;
  mdIpLocator::ProgramStatus program_status;

  string ip_address;
  const char* resultsString;

  
  /************************ DATA FILE PATH  ***********************
   File location path is set to the default Data File location. 
   Change this value if you installed the data files to a       
   different folder. The Data Files Directory must contain      
   the following file: mdIpLocator.dat.
  *****************************************************************/
  iplocator->SetPathToIpLocatorFiles("C:\\Program Files\\Melissa Data\\DQT\\Data");
  
  /************************ LICENSE STRINGS ***********************
         To unlock the functionality of IPLocator Object,     
    please call a sales representative at 1-800-MELISSA ext. 3 
          (1-800-635-4772 x3) for a demo license string.        
          Without a valid license string, you will not be       
                 able to use the IPLocator Sample.                    
              REPLACE "DEMO" with your LICENSE STRING                    

   SetLicenseString will also check for a valid license in the 
   MDIPLOCATOR_LICENSE(Environment) variable. This allows you   
   to modify the license without recompiling the project
******************************************************************/
  iplocator->SetLicenseString("DEMO");
  
  //initialize
  program_status = iplocator->InitializeDataFiles();
  if(program_status != mdIpLocator::ErrorNone)
  {
    cout << iplocator->GetInitializeErrorString();
    getchar();
    return 1;
  }
  
  cout << "==========================================" << endl;
  cout << "     IPLocator Object C++ Sample   " << endl;
  cout << "         BuildNumber: " << iplocator->GetBuildNumber() << endl;
  cout << "       Database Date: " << iplocator->GetDatabaseDate() << endl;
  cout << " Database Expiration: " << iplocator->GetDatabaseExpirationDate() << endl;
  cout << "==========================================" << endl << endl;
  
  while(ip_address != "x" && ip_address != "X")
  { 
    prompt_user("\nEnter an IP address or 'x' to quit: ", ip_address);
    
        
    //perform the lookup
    iplocator->LocateIpAddress(ip_address.c_str());
    
    // results are returned as a delimited string, so we parse here... 
    resultsString = iplocator->GetResults();
    cout << endl << " Results: " << resultsString << " : ";
      
    if(strstr(resultsString,"IS01")!=0)
    {
      cout << "The IP Address " << ip_address << " was found.\n";
      // the IP was verified. display the results. 
      put_iplocator(iplocator);
    }
    else
    {
      //if not successful then find out why
      if (strstr(resultsString,"IE01")!=0)
        cout << "The IP Address " << ip_address << " was empty or was formatted incorrectly.\n";
      if (strstr(resultsString,"IS02")!=0)
        cout << "The IP Address " << ip_address << " was not found.\n";
      if (strstr(resultsString,"IE02")!=0)
        cout << "The IPLocator was not initialized, or is in demo mode.\n";
    }
    cout << endl << endl;
  }
  return 0;
}

void put_iplocator(mdIpLocator *il)
{
    cout << " Domain Name          : " << il->GetDomainName() << endl;
    cout << " ISP                  : " << il->GetISP() << endl;
    cout << " Latitude             : " << il->GetLatitude() << endl;
    cout << " Longitude            : " << il->GetLongitude() << endl;
    cout << " Region               : " << il->GetRegion() << endl;
    cout << " Zip                  : " << il->GetZip() << endl;
    cout << " City                 : " << il->GetCity() << endl;
    cout << " Country              : " << il->GetCountry() << endl;
    cout << " Country Abbreviation : " << il->GetCountryAbbreviation() << endl;
}

void prompt_user(const char* const prompt, string& outval)
{
    if (prompt)
    {
        if (strlen(prompt) > 0)
            cout << prompt;
        else
            cout << "? ";
    }

    getline(cin, outval);
    string::size_type gpos = outval.find_first_not_of(" \t\r\n");
    if (gpos == string::npos)
    {
        outval.erase();
    }
    else
    {
        outval.erase(0, gpos);
        gpos = outval.find_last_not_of(" \t\r\n");
        outval.erase(gpos + 1);
    }
    return;
}

