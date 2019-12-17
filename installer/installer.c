#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>

#if __MACH__

char *xplaneDir;
char homedir[1024];
char direct = 0;

void exec (char cmd[1024])
{
    printf("\033[36m  executing \033[0m%s\n", cmd);
    system(cmd);
}

void cpyDir (const char *suffixdir, const char *fromdir, const char *todir)
{
    char cmd[1024];
    strcpy(cmd, "cp -rf ");
    strcat(cmd, suffixdir);
    strcat(cmd, "/");
    strcat(cmd, fromdir);
    strcat(cmd, " ");
    strcat(cmd, todir);
    exec(cmd);
}

void cpyAllDir (const char *fromdir, const char *todir)
{
    DIR *d;
    struct dirent *dir;
    char pfromdir[1024];
    strcpy(pfromdir, homedir);
    strcat(pfromdir, fromdir);
    char ptodir[1024];
    if (direct == 0)
        strcpy(ptodir, homedir);
    else
        strcpy(ptodir, "");
    strcat(ptodir, todir);
    d = opendir(pfromdir);
    if (d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            if (dir->d_name[0] != '.')
                cpyDir(pfromdir, dir->d_name, ptodir);
        }
        closedir(d);
    }
    else
    {
        printf("\033[35m%s is a missing directory! For help, please enquire at\n"
        "https://forums.x-plane.org/index.php?/profile/520176-chai112/&tab=activity\n\n\033[m", fromdir);
        abort();
    }
}

void rmDir (const char *suffixdir, const char *dir)
{
    char cmd[1024];
    strcpy(cmd, "rm ");
    strcat(cmd, suffixdir);
    strcat(cmd, "/");
    strcat(cmd, dir);
    exec(cmd);
}

void rmAllDir (const char *refdir, const char *fromdir)
{
    DIR *d;
    struct dirent *dir;
    char prefdir[1024];
    strcpy(prefdir, homedir);
    strcat(prefdir, refdir);
    char pfromdir[1024];
    strcpy(pfromdir, homedir);
    strcat(pfromdir, fromdir);
    d = opendir(prefdir);
    if (d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            if (dir->d_name[0] != '.')
                rmDir(pfromdir, dir->d_name);
        }
        closedir(d);
    }
    else
    {
        printf("\033[35m%s is a missing directory! For help, please enquire at\n"
        "https://forums.x-plane.org/index.php?/profile/520176-chai112/&tab=activity\n\n\033[m", refdir);
        abort();
    }
}

char checkDir (const char *fromdir)
{
    DIR *d;
    struct dirent *dir;
    d = opendir(fromdir);
    if (d)
    {
        closedir(d);
        return 1;
    }
    return 0;
}

// change all \ to spaces
char *parseInp (char inp[1024])
{
    static char out[1024];
    int i = 0;
    int j = 0;
    while (inp[i] != '\0')
    {
        if (inp[i] != '\\' && inp[i] != '\n')
        {
            out[j] = inp[i];
            j++;
        }
        i++;
    }
    return out;
}

// does opposite of parseIn function
char *parseOut (char inp[1024])
{
    static char out[1024];
    int i = 0;
    int j = 0;
    while (inp[i] != '\0')
    {
        if (inp[i] == ' ')
        {
            out[j] = '\\';
            j++;
        }
        out[j] = inp[i];
        j++;
        i++;
    }
    return out;
}

int main (int argc, char *argv[])
{
    char homecmd[1024];
    int i = 0;
    int j = 0;
    while (argv[0][i] != '\0')
    {
        if (argv[0][i] == '/' || argv[0][i] == '\\')
            j = i;
        i++;
    }

    for (int k = 0; k < j; k++)
        homedir[k] = argv[0][k];

    homedir[j + 1] = '\0';
    strcat(homedir, "/");
    printf("%s\n", homedir);

    printf("\n\n\n"
    "\033[1;14mChai112's Boeing 777-300ER Installer\n\033[m"
    "\n"
    "- https://github.com/Chai112/Chai112-s-Boeing-777-300ER\n"
    "- build date: %s\n"
    "- build time: %s\n"
    "- I am written by Chai112.\n"
    "\n"
    "\033[1;14mHello, thank you for downloading!\n"
    "I will automatically install the aircraft into your xplane directory.\n"
    "Please be aware that repo is NOT A STABLE prerelease.\n\033[m"
    "\n"
    "\033[35mNote: Installation will begin immediately after input. Proceed at your own risk (legal stuff).\n\033[m"
    "\n"
    "\033[35mPlease drag and drop (or type in) your x-plane directory\n\033[m", __DATE__, __TIME__);

    size_t size = 1024;
    xplaneDir = (char *)malloc (size); 
    //https://www.studymite.com/blog/strings-in-c#read_using_scanf
    getline(&xplaneDir, &size, stdin);
    printf("\n");

    if (xplaneDir[0] == '!')
    {
        direct = 1;
        for (int l = 0; xplaneDir[l] != '\0'; l++)
            xplaneDir[l] = xplaneDir[l + 1];
    }
    if (xplaneDir[1] == '@')
    {
        printf("\n\033[1;14mInstalling to X-Plane directory...\033[m\n");

        char cmd[1024];
        strcpy(cmd, "rsync -rva ");
        strcat(cmd, parseOut(xplaneDir));
        strcat(cmd, " ");
        strcat(cmd, homedir);
        strcat(cmd, "../src/base/B777-300ER");
        exec(cmd);
        printf("\033[1;14mFinished installing, begin cleanup...\033[m\n");
    }

    if (xplaneDir[0] == '`') // for my own purposes 
        strcpy(xplaneDir, "/Volumes/KINGSTON/X-Plane 10");

    for (int l = 0; xplaneDir[l] != '\0'; l++)
    {
        if (xplaneDir[l + 1] == '\0' && xplaneDir[l - 1] == ' ')
            xplaneDir[l - 1] = '\0';

    }

    char acfDir[1024];
    strcpy(acfDir, "../src/base");

    if (direct == 1)
        strcpy(acfDir, parseOut(xplaneDir));

    strcpy(xplaneDir, parseInp(xplaneDir));

    if (checkDir(xplaneDir) == 0)
    {
        printf("\033[35m%s is not a valid directory! For help, please enquire at\n"
        "https://forums.x-plane.org/index.php?/profile/520176-chai112/&tab=activity\n\n\033[m", xplaneDir);
        abort();
    }

    strcat(acfDir, "/Aircraft/Heavy\\ Metal/");
    strcat(xplaneDir, "/Aircraft/Heavy Metal");

    if (checkDir(xplaneDir) == 0)
    {
        printf("\033[35m%s is unrecognisably structured! Are you sure it is your X-Plane directory? For help, please enquire at\n" 
        "https://forums.x-plane.org/index.php?/profile/520176-chai112/&tab=activity\n\n\033[m", xplaneDir);
        abort();
    }

    char aDir[1024];
    printf("\033[35mBegin install at %s\n\033[m", acfDir);

    strcpy (aDir, acfDir);
    strcat (aDir, "/B777-300ER/plugins/SASLFree/data/modules/configuration/widgetResources");
    printf("copying audio...\n");
    cpyAllDir("../src/external/audio", aDir);

    strcpy (aDir, acfDir);
    strcat (aDir, "/B777-300ER/plugins/SASLFree/data/modules/Custom\\ Module");
    printf("copying code...\n");
    cpyAllDir("../src/external/code", aDir);

    strcpy (aDir, acfDir);
    strcat (aDir, "B777-300ER/objects");
    printf("copying objects...\n");
    cpyAllDir("../src/external/objects", aDir);

    strcpy (aDir, acfDir);
    strcat (aDir, "B777-300ER/objects");
    printf("copying textures...\n");
    cpyAllDir("../src/external/textures", aDir);
 
    if (direct == 0)
    {
        printf("\n\033[1;14mInstalling to X-Plane directory...\033[m\n");

        char cmd[1024];
        strcpy(cmd, "rsync -rva ");
        strcat(cmd, homedir);
        strcat(cmd, "../src/base/B777-300ER");
        strcat(cmd, " ");
        strcat(cmd, parseOut(xplaneDir));
        exec(cmd);
        printf("\033[1;14mFinished installing, begin cleanup...\033[m\n");
    
        printf("cleaning up audio...\n");
        rmAllDir("../src/external/audio",
        "../src/base/B777-300ER/plugins/SASLFree/data/modules/configuration/widgetResources");
        printf("cleaning up code...\n");
        rmAllDir("../src/external/code",
        "../src/base/B777-300ER/plugins/SASLFree/data/modules/Custom\\ Module");
        printf("cleaning up objects...\n");
        rmAllDir("../src/external/objects", "../src/base/B777-300ER/objects");
        printf("cleaning up textures...\n");
        rmAllDir("../src/external/textures", "../src/base/B777-300ER/objects");
    }
        printf("\n\n\033[35mInstallation finished. Thank you for downloading! Installed at %s/B777-300ER\n\n"
        "Please direct your enquries to\n"
        "https://forums.x-plane.org/index.php?/profile/520176-chai112/&tab=activity\n\n\033[m", xplaneDir);
    return 0;
}

#elif __WIN64__
#else
#error "unsupported OS"
#endif
