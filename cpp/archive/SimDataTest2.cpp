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

void	MyMenuHandlerCallback(
                                   void *               inMenuRef,    
                                   void *               inItemRef);    

void beepboop ()
{
    XPLMMenuID	myMenu;
    int			mySubMenuItem;
	/* First we put a new menu item into the plugin menu.
	 * This menu item will contain a submenu for us. */
	mySubMenuItem = XPLMAppendMenuItem(
						XPLMFindPluginsMenu(),	/* Put in plugins menu */
						"Sim Data",				/* Item Title */
						0,						/* Item Ref */
						1);						/* Force English */
	
	/* Now create a submenu attached to our menu item. */
	myMenu = XPLMCreateMenu(
						"Sim Data", 
						XPLMFindPluginsMenu(), 
						mySubMenuItem, 			/* Menu Item to attach to. */
						MyMenuHandlerCallback,	/* The handler */
						0);						/* Handler Ref */
						
	/* Append a few menu items to our submenu.  We will use the refcon to
	 * store the amount we want to change the radio by. */
	XPLMAppendMenuItem(
						myMenu,
						"Decrement Nav1",
						(void *) -1000,
						1);
	XPLMAppendMenuItem(
						myMenu,
						"Increment Nav1 2nd 3rd",
						(void *) +1000,
						1);
}
