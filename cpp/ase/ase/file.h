#include <XPLMUtilities.h>

namespace ASE
{
    class File
    {
    private:
        FILE* fp;

    public:
        File(const char* filename);
        ~File();

        const char* filename;

        bool readStr(char (& str)[65536]);
        bool writeStr(const char* str);
    };
}
