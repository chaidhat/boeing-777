#include "plugin.h"

namespace ASE
{
    PluginBehaviour::PluginBehaviour(const char* name, const char* sig, const char* desc) : name(name), sig(sig),
    desc(desc)
    {
    }
    PluginBehaviour::~PluginBehaviour()
    {
    }

    void PluginBehaviour::Start()
    {
    }

    void PluginBehaviour::Stop()
    {
    }

    void PluginBehaviour::Update()
    {
    }

    void PluginBehaviour::Enable()
    {
    }

    void PluginBehaviour::Disable()
    {
    }

    namespace PluginManager
    {
        void DeregisterPlugin(PluginBehaviour* plugin)
        {
            XPLMDisablePlugin(XPLMGetMyID());
        }

        // defined by CLIENT
        PluginBehaviour* RegisterPlugin();
    }
}

