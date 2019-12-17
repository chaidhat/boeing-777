#include <ase.h>

class MyButton : public ASE::ButtonBehaviour
{
public:
    ASE::Window* window;

    MyButton(ASE::Rect transform) : ASE::ButtonBehaviour (transform)
    {
    }

    void onClick()
    {
        window->hidden = true;
        hidden = true;
    }
};

class Sandbox : public ASE::PluginBehaviour
{
public:
    Sandbox() :
    ASE::PluginBehaviour(
        "Sandbox",
        "ase.chai112.sandbox",
        "This is a sample program for the ASE.")
    {

    }

    ~Sandbox()
    {

    }

    void Start()
    {
        ASE::File file("chai112.cfg");
        ASE::Network network("https://raw.githubusercontent.com/Chai112/Chai112-s-Boeing-777-300ER/master/version");

        char fileBuffer[65536];
        char netBuffer[65536];

        bool networkSucc = network.readStr(netBuffer);
        if (!networkSucc)
        {
            // network failure
            ASE::Window* window = new ASE::Window(ASE::Rect(440,40,200,100));
            MyButton* button = new MyButton(ASE::Rect(450,50,180,30));
            button->window = window;

            ASE::Text* text = new ASE::Text(10,20);
            strcpy(text->text, 
            "network failure\n"
            "\n"
            "plugin cannot check\n"
            "for updates\n");
            window->addText(text);

            ASE::Text* buttonText = new ASE::Text(70,15,(char *)"dismiss");
            button->addText(buttonText);
        }

        if (!file.readStr(fileBuffer))
        {
            // welcome message
            ASE::Window* window = new ASE::Window(ASE::Rect(30,40,400,150));
            MyButton* button = new MyButton(ASE::Rect(40,50,180,30));
            button->window = window;

            ASE::Text* text = new ASE::Text(10,20);
            strcpy(text->text,
            "Thank you for downloading\n"
            "Chai112's B777-300ER\n"
            "\n"
            "For questions and queries goto\n"
            "https://forums.x-plane.org/index.php?/profile/520176-chai112/\n"
            "or read the manual\n"
            "\n"
            "Have a great flight! :)\n"
            );
            window->addText(text);

            ASE::Text* buttonText = new ASE::Text(70,15,(char *)"dismiss");
            button->addText(buttonText);

            if (networkSucc)
                file.writeStr(netBuffer);
        }
        else if (networkSucc && strcmp(fileBuffer, netBuffer) != 0)
        {
            // outdated
            ASE::Window* window = new ASE::Window(ASE::Rect(30,40,400,150));
            MyButton* button = new MyButton(ASE::Rect(40,50,180,30));
            button->window = window;

            ASE::Text* text = new ASE::Text(10,20);
            strcpy(text->text, 
            "Update required\n"
            "A new version of this aircraft has been released\n"
            "\n"
            "Current version: "
            ); 
            strcat(text->text, fileBuffer);
            strcat(text->text, "Latest version: ");
            strcat(text->text, netBuffer);
            strcat(text->text, "\n"
            "Please download at\n"
            "https://forums.x-plane.org/index.php?/profile/520176-chai112/\n"
            );
            window->addText(text);

            ASE::Text* buttonText = new ASE::Text(70,15,(char *)"dismiss");
            button->addText(buttonText);
        }




    }

    void Update()
    {

    }
};

ASE::PluginBehaviour* ASE::PluginManager::RegisterPlugin()
{
    return new Sandbox();
}

