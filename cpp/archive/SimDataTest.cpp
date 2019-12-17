/*
 * SimData.c
 * 
 * This example demonstrates how to interact with X-Plane by reading and writing
 * data.  This example creates menus items that change the nav-1 radio frequency.
 * 
 */

#include <stdio.h>
#include <string.h>
#include "SDK/CHeaders/XPLM/XPLMDataAccess.h"
#include "SDK/CHeaders/XPLM/XPLMMenus.h"

void beepboop ();

/* We keep our data ref globally since only one is used for the whole plugin. */
static XPLMDataRef		gDataRef = NULL;

void	MyMenuHandlerCallback(
                                   void *               inMenuRef,    
                                   void *               inItemRef);    

PLUGIN_API int XPluginStart(
						char *		outName,
						char *		outSig,
						char *		outDesc)
{

	/* Provide our plugin's profile to the plugin system. */
	strcpy(outName, "SimData");
	strcpy(outSig, "xplanesdk.examples.simdata");
	strcpy(outDesc, "A plugin that changes sim data.");

    beepboop();
	
	/* Look up our data ref.  You find the string name of the data ref
	 * in the master list of data refs, including in HTML form in the 
	 * plugin SDK.  In this case, we want the nav1 frequency. */
	gDataRef = XPLMFindDataRef("sim/cockpit/radios/nav1_freq_hz");
	
	/* Only return that we initialized correctly if we found the data ref. */
	return (gDataRef != NULL) ? 1 : 0;
}

PLUGIN_API void	XPluginStop(void)
{
}

PLUGIN_API void XPluginDisable(void)
{
}

PLUGIN_API int XPluginEnable(void)
{
	return 1;
}

PLUGIN_API void XPluginReceiveMessage(
					XPLMPluginID	inFromWho,
					int				inMessage,
					void *			inParam)
{
}

void	MyMenuHandlerCallback(
                                   void *               inMenuRef,    
                                   void *               inItemRef)
{
	/* This is our handler for the menu item.  Our inItemRef is the refcon
	 * we registered in our XPLMAppendMenuItem calls.  It is either +1000 or
	 * -1000 depending on which menu item is picked. */
	if (gDataRef != NULL)
	{
		/* We read the data ref, add the increment and set it again.
		 * This changes the nav frequency. */
		XPLMSetDatai(gDataRef, XPLMGetDatai(gDataRef) + (int)(size_t) inItemRef);
	}
}
