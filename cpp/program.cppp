#include <string>

#include <ase.h>

static ase_window *window;
static ase_network *network;
static ase_file *file;

static char a[65536];
static int b = 0;

static const char *url = "https://raw.githubusercontent.com/Chai112/Chai112-s-Boeing-777-300ER/master/version";


void ase_start ()
{
    window = new ase_window();
    network = new ase_network();
    file = new ase_file();

    int network_succ = network->open_website(url);

    strcpy(a, " ");

    static char config_file[65536];
    int file_succ = file->read_str("chai112.cfg", config_file);

    if (file_succ == 1)
    {
        if (network_succ == 1)
        {
            if (strcmp(config_file, network->website_text) == 0)
                window->text = (char *)"clear";
            else
                window->text = (char *)"update required!";
        }
    }
    else
    {
        // mem.cfg missing, so assume user is new
        window->text = (char *)"welcome!";

        if (network_succ == 1)
            file->write_str("chai112.cfg", network->website_text);
    }

    /*while (readBuffer[i] != '\n' && readBuffer[i] != '\0')
    {
        out[i] = readBuffer[i];
        i++;
    }
    out[i] = '\0';*/
}

void ase_update ()
{
    /*window->text = a;
    strcat (a, "a");
    b++;
    if (b == 100)
    {
        b = 0;
        strcpy(a, " ");
    }*/
}

void ase_stop ()
{
}
