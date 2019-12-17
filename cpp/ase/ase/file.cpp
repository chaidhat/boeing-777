#include <stdio.h>
#include <string.h>

// thank you to https://www.programiz.com/c-programming/c-file-input-output 
// for the write/read code

#include "file.h"


namespace ASE
{
    File::File(const char *filename) : filename(filename)
    {
    }

    File::~File()
    {
    }

    // reads files
    bool File::readStr(char (& str)[65536])
    {
        fp = fopen(filename, "r"); // read mode
        bool succ = false;

        if(fp != NULL)
        {
            succ = true;

            char inp;
            for (int i = 0; (inp = fgetc(fp)) != EOF; i++)
                str[i] = inp;
        }

        fclose(fp);

        return succ;
    }

    // write files
    bool File::writeStr(const char *str)
    {
        fp = fopen(filename, "w"); // write mode
        bool succ = false;

        if(fp != NULL)
        {
            succ = true;

            fprintf(fp,"%s",str);
        }

        fclose(fp);

        return succ;
    }
}
