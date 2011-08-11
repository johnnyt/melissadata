/********************************************************************************
If you should have any comments, suggestions or improvements to these samples,
we welcome you to contact us at SampleCode@melissadata.com also please visit our
developers bulletin board at forum.melissadata.com.
********************************************************************************/

import com.melissadata.*;
import java.io.*;

public class IpLocatorSample {

  public static String the_license = "License Here";
  public static String datafile_dir = "/DQT/Current";

  public static void main(String args[]) throws IOException 
  {
		Boolean i;

		mdIpLocator ip = new mdIpLocator();

		// ************************************************************//
		// To unlock the full functionality of IpLocator Object,
		// please call a sales representative at 1-800-MELISSA ext. 3
		// You will need a valid license string to use IpLocator Object
		// outside.
		// ************************************************************//

		/* Set License and Datafile path */
		ip.SetLicenseString(the_license);
		ip.SetPathToIpLocatorFiles(datafile_dir);

		//Initialize Data Files
		mdIpLocator.ProgramStatus result = ip.InitializeDataFiles();

		//Print Initialization Status Results
		System.out.println("*****  Initialization Info  *****");
		System.out.println("Build number: " + ip.GetBuildNumber());
		System.out.println("Database Date: " + ip.GetDatabaseDate());
		System.out.println("Database Expiration Date: " + ip.GetDatabaseExpirationDate());
		System.out.println("License Expiration Date: " + ip.GetLicenseStringExpirationDate());

		if (result != mdIpLocator.ProgramStatus.ErrorNone)
		{
			//Problem during initialization
			System.out.println("Initialization Error: " + ip.GetInitializeErrorString());
			return;
		}
		
		String input = "";
		BufferedReader stdin = new BufferedReader( new InputStreamReader( System.in ) );
		while (!input.equals("X"))
		{

			//Get Input
			System.out.print("Enter IP Address: ");
			ip.LocateIpAddress(stdin.readLine());

			if (ip.GetResults().contains("IS01"))
                {
                    System.out.println("Latitude: " + ip.GetLatitude());
                    System.out.println("Longitude: " + ip.GetLongitude());
                    System.out.println("City: " + ip.GetCity());
                    System.out.println("Region: " + ip.GetRegion());
                    System.out.println("Zip: " + ip.GetZip());
                    System.out.println("Country: " + ip.GetCountry());
                    System.out.println("Country Abbreviation: " + ip.GetCountryAbbreviation());
                    System.out.println("Domain Name: " + ip.GetDomainName());
                    System.out.println("ISP: " + ip.GetISP());
                }
                else
                {
                    if(ip.GetResults().contains("IS02"))
			  {
			  	System.out.println("IP Address Unknown");
			  }	
			  else if(ip.GetResults().contains("IE01"))
			  {
			  	System.out.println("IP Address Empty or Not Well Formed");
			  }
                }


			System.out.print("\nPress Enter to Continue, X to quit:");
			input = stdin.readLine();
		}	
		ip.delete();
  }
}
