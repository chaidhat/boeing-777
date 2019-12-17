#include <stdio.h>
#include <string.h>

#include "network.h"

static char datBuf[65536];

static size_t handleWriteCallback (void *contents, size_t size, size_t nmemb, void *userp)
{ 
    size_t realsize = size * nmemb;
    strcat(datBuf, (char *)contents);
    return realsize;
}

namespace ASE
{
    Network::Network(const char* url) : url(url)
    {
    }

    Network::~Network()
    {
    }

    bool Network::readStr(char (& str)[65536])
    {
        CURL *curl;
        CURLcode res;
        curl = curl_easy_init();
        if (curl) 
        {
            strcpy(datBuf, " ");
            curl_easy_setopt(curl, CURLOPT_URL, url);
            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, handleWriteCallback);
            res = curl_easy_perform(curl);
            if (res != 0)
                return false;
            strcpy(str, datBuf);
            curl_easy_cleanup(curl);
        }
        else
            return false;

        return true;
    }
}

