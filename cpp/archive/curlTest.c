
// gcc curlTest.c -o bin/mac -lcurl
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "curl/curl.h"

static char readBuffer[65536];
static size_t WriteCallback(void *contents, size_t size, size_t nmemb, void *userp)
{ 
    size_t realsize = size * nmemb;
    strcat(readBuffer, (char *)contents);
    return realsize;
}

int main(void) {
    CURL *curl;
    CURLcode res;
    char *url = "https://raw.githubusercontent.com/Chai112/Chai112-s-Boeing-777-300ER/master/License.txt";
    curl = curl_easy_init();
    if (curl) {
        strcpy(readBuffer, " ");
        printf("w\n");
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        res = curl_easy_perform(curl);
        printf("w\n");
        /* always cleanup */
        curl_easy_cleanup(curl);
    }

    char out[2048];
    for (int i = 0; readBuffer[i] != '\n' && readBuffer[i] != '\0'; i++)
        out[i] = readBuffer[i];
    printf("ww %s\n", out);
    return 0;
}

/*int main ()
{
    CURL *curl;
    CURLcode result;

    curl = curl_easy_init();
    curl_easy_setopt(curl, CURLOPT_URL, "https://raw.githubusercontent.com/Chai112/Chai112-s-Boeing-777-300ER/master/License.txt");

    result = curl_easy_perform(curl);

    printf("in %d\n", result);

    curl_easy_cleanup(curl);

    return 0;
}*/
