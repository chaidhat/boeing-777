#include <string>

#include <XPLMProcessing.h>

static ASE::PluginBehaviour* plugin;

static float handleFlCallback (
                                   float                inElapsedSinceLastCall,    
                                   float                inElapsedTimeSinceLastFlightLoop,    
                                   int                  inCounter,    
                                   void *               inRefcon)
{

    plugin->Update();

    /* Return 0.01 to indicate that we want to be called again in 1 ms. */
    return 0.01;
}    

PLUGIN_API int XPluginStart(
						char *		outName,
						char *		outSig,
						char *		outDesc)
{
    plugin = ASE::PluginManager::RegisterPlugin();

	strcpy(outName, plugin->name);
	strcpy(outSig, plugin->sig);
	strcpy(outDesc, plugin->desc);

    plugin->Start();

    XPLMRegisterFlightLoopCallback(		
            handleFlCallback,	/* Callback */
            0.01,					/* Interval */
            NULL);	
					
	return 1;
}

PLUGIN_API void	XPluginStop()
{
    plugin->Stop();
    free(plugin);
}

PLUGIN_API int XPluginEnable()
{
    plugin->Enable();
	return 1;
}

PLUGIN_API void XPluginDisable()
{
    plugin->Disable();
}


PLUGIN_API void XPluginReceiveMessage(
					XPLMPluginID	inFromWho,
					long			inMessage,
					void *			inParam)
{
}
