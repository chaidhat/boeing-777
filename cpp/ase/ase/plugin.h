#include <XPLMPlugin.h>
namespace ASE
{
    // plugin interface
    class PluginBehaviour
    {
    public:
        PluginBehaviour(const char* name, const char* sig, const char* desc);
        virtual ~PluginBehaviour();

        const char* name;
        const char* sig;
        const char* desc;

        virtual void Start();
        virtual void Stop();
        virtual void Update();

        virtual void Enable();
        virtual void Disable();
    };

    namespace PluginManager
    {
        void DeregisterPlugin(PluginBehaviour* plugin);

        // defined by CLIENT
        PluginBehaviour* RegisterPlugin();
    }
}
