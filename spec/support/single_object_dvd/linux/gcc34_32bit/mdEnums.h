/*
 * Commonly used enumerations in both C++ and C forms
 * (c) 2005 Melissa Data
 *
 * PRELIMINARY VERSION SUBJECT TO CHANGES
 */
#ifndef MDENUMS_H
#define MDENUMS_H

#if defined(__cplusplus) && !defined(MDCFORCE) || defined(__midl)
/*
 * C++ version names have class scope and are not prefixed
 */
#define MDENUM(x)	enum x
#define MDINIT(x,y)	x = y
#define MDNEXT(x)	x
#else
/*
 * C version names have global scope and thus require prefix
 */
#define MDENUM(x)	enum md##x
#define MDINIT(x,y)	md##x = y
#define MDNEXT(x)	md##x
#endif

/*
 * Programming/installation/execution errors
 */
MDENUM(ProgramStatus) {
/* Common errors */
MDINIT(ErrorNone,0),
MDNEXT(ErrorOther),
MDNEXT(ErrorOutOfMemory),
MDNEXT(ErrorRequiredFileNotFound),
MDNEXT(ErrorFoundOldFile),
MDNEXT(ErrorDatabaseExpired),
MDNEXT(ErrorLicenseExpired)
};

/*
 * Backing data access modes
 */
MDENUM(AccessType) {
MDINIT(Local,0),
MDNEXT(Remote)
};

/*
 * Diacritics modes
 */
MDENUM(DiacriticsMode) {
MDINIT(Auto,0),
MDNEXT(On),
MDNEXT(Off)
};

/*
 * Presort codes
 */
MDENUM(SortationCode) {

MDINIT(FCM_LTR_AUTO_NONAUTO,1),
MDNEXT(FCM_LTR_AUTO),
MDNEXT(FCM_LTR_NONAUTO),
MDNEXT(FCM_LTR_NONMACH),

MDINIT(FCM_POSTCARD_AUTO_NONAUTO,41),
MDNEXT(FCM_POSTCARD_AUTO),
MDNEXT(FCM_POSTCARD_NONAUTO),

MDINIT(FCM_FLAT_COTRAY,51),
MDNEXT(FCM_FLAT_AUTO),
MDNEXT(FCM_FLAT_NONAUTO),
MDNEXT(FCM_FLAT_DISABLE_COTRAY),
MDNEXT(FCM_FLAT_COTRAY_FSM1000),
MDNEXT(FCM_FLAT_DISABLE_COTRAY_FSM1000),
MDNEXT(FCM_FLAT_AUTO_FSM1000),
MDNEXT(FCM_FLAT_NONAUTO_FSM1000),

MDINIT(STD_LTR_ECRRT_AUTO_NONAUTO,101),
MDNEXT(STD_LTR_ECRRT_NONAUTO),
MDNEXT(STD_LTR_AUTO_NONAUTO),
MDNEXT(STD_LTR_AUTO),
MDNEXT(STD_LTR_NONAUTO),
MDNEXT(STD_LTR_NONMACH),
MDNEXT(STD_LTR_ECRRT_NONMACH),

MDINIT(STD_FLAT_ECRRT_COSACK,151),
MDNEXT(STD_FLAT_ECRRT_DISABLE_COSACK),
MDNEXT(STD_FLAT_COSACK),
MDNEXT(STD_FLAT_DISABLE_COSACK),
MDNEXT(STD_FLAT_AUTO),
MDNEXT(STD_FLAT_NONAUTO),
MDNEXT(STD_FLAT_ECRRT_AUTO),
MDNEXT(STD_FLAT_ECRRT_NONAUTO),

MDINIT(RESIDUALS_LEFT,999)
};

#undef MDENUM
#undef MDINIT
#undef MDNEXT

#endif
