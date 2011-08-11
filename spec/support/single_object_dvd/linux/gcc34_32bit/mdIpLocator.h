/*
* Melissa Data IpLocator Object for Windows/Linux/Solaris
* Copyright 1999-2009 Melissa Data Corporation.
*
* Public interface
*
* PRELIMINARY VERSION SUBJECT TO CHANGES
*/
#ifndef MDIPLOCATOR_H
#define MDIPLOCATOR_H

#ifndef MDAPI
#if defined(_WIN32) || defined(_WIN64)
#define MDAPI __declspec(dllimport)
#else
#define MDAPI
#endif
#endif

/*
* C++ version of interface
*/
#if defined(__cplusplus) && !defined(MDCFORCE)

//
// IpLocator Interface
//
class MDAPI mdIpLocator
{
protected:
	struct mdIpLocator_ *I;
private:	/* disable implicit constructor and assignment */
	mdIpLocator(mdIpLocator &x);
	mdIpLocator& operator=(mdIpLocator &x);
public:
#undef MDENUMS_H
#include "mdEnums.h"
	mdIpLocator();
	~mdIpLocator();

	/* Setup methods */
	enum ProgramStatus InitializeDataFiles();
	void SetPathToIpLocatorFiles(const char*);
	const char* GetInitializeErrorString();
	bool        SetLicenseString(const char*);
	const char* GetBuildNumber();
	const char* GetDatabaseDate();
	const char* GetDatabaseExpirationDate();
	const char* GetLicenseStringExpirationDate();

	/* Processing method */
	bool        LocateIpAddress(const char*);

	/* Output data */
	const char* GetCity();
	const char* GetCountry();
	const char* GetCountryAbbreviation();
	const char* GetDomainName();
	const char* GetISP();
	const char* GetLongitude();
	const char* GetLatitude();
	const char* GetRegion();
	const char* GetZip();

	/* Errors and status */
	const char* GetResults();
};

#else

/*
* C version of interface
*/
#include "mdEnums.h"

typedef struct mdIpLocator_ *mdIpLocator;
MDAPI mdIpLocator         mdIpLocatorCreate(void);
MDAPI void            mdIpLocatorDestroy(mdIpLocator);




/* Setup methods */
MDAPI enum mdProgramStatus mdIpLocatorInitializeDataFiles(mdIpLocator);
MDAPI void		  mdIpLocatorSetPathToIpLocatorFiles(mdIpLocator, const char*);
MDAPI const char* mdIpLocatorGetInitializeErrorString(mdIpLocator);
MDAPI int        mdIpLocatorSetLicenseString(mdIpLocator, const char*);
MDAPI const char* mdIpLocatorGetBuildNumber(mdIpLocator);
MDAPI const char* mdIpLocatorGetDatabaseDate(mdIpLocator);
MDAPI const char* mdIpLocatorGetDatabaseExpirationDate(mdIpLocator);
MDAPI const char* mdIpLocatorGetLicenseStringExpirationDate(mdIpLocator);

/* Processing method */
MDAPI int        mdIpLocatorLocateIpAddress(mdIpLocator, const char*);

/* Output data */
MDAPI const char* mdIpLocatorGetCity(mdIpLocator);
MDAPI const char* mdIpLocatorGetCountry(mdIpLocator);
MDAPI const char* mdIpLocatorGetCountryAbbreviation(mdIpLocator);
MDAPI const char* mdIpLocatorGetDomainName(mdIpLocator);
MDAPI const char* mdIpLocatorGetISP(mdIpLocator);
MDAPI const char* mdIpLocatorGetLongitude(mdIpLocator);
MDAPI const char* mdIpLocatorGetLatitude(mdIpLocator);
MDAPI const char* mdIpLocatorGetRegion(mdIpLocator);
MDAPI const char* mdIpLocatorGetZip(mdIpLocator);

/* Errors and status */
MDAPI const char* mdIpLocatorGetResults(mdIpLocator);


#endif /* __cplusplus && (!MDCFORCE) */

#endif /* MDIPLOCATOR_H */
