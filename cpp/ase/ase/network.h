#include "curl/curl.h"

namespace ASE
{
    class Network
    {
    public:
        Network(const char* url);
        ~Network();

        const char* url;

        bool readStr(char (& str)[65536]);
    };
}
