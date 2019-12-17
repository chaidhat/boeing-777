#include <stdio.h>
#include <stdlib.h>
#include <string>

#include "ui.h"

static void draw_window_callback (
                                   XPLMWindowID         inWindowID,    
                                   void *               inRefcon)
{
    ASE::WindowRef *winRef = (ASE::WindowRef*)inRefcon;
    ASE::Window* window;
    switch (winRef->type)
    {
        case ASE::WtWindow:
            window = (ASE::Window*)winRef->ref;
            break;
        case ASE::WtButton:
            window = (ASE::ButtonBehaviour*)winRef->ref;
            break;
        case ASE::WtInput:
            window = (ASE::InputBehaviour*)winRef->ref;
            break;
        default:
        break;

    }

    if (!window->hidden)
    {
        int		left, top, right, bottom;
        
        XPLMGetWindowGeometry(inWindowID, &left, &top, &right, &bottom);
        XPLMDrawTranslucentDarkBox(left, top, right, bottom);

        for (int i = 0; i < window->textsLength; i++)
        {
            int j = 0;
            int k = 0;
            int lines = 0;
            int fontHeight = 10;
            char textBuf[65536];

            ASE::Text* txt = window->texts[i];

            while (txt->text[j] != '\0')
            {
                if (txt->text[j] == '\n')
                {
                    textBuf[k] = '\0';
                    XPLMDrawString(txt->color, left+txt->x, top-txt->y-(lines*fontHeight), textBuf, NULL, xplmFont_Basic);
                    k = 0;
                    lines++;
                }
                else
                {
                    textBuf[k] = txt->text[j];
                    k++;
                }
                j++;
            }
            textBuf[k] = '\0';
            XPLMDrawString(txt->color, left+txt->x, top-txt->y-(lines*fontHeight), textBuf, NULL, xplmFont_Basic);

        }
        /*for (auto i = window->texts.begin(); i < window->texts.end(); ++i)
        {
        }*/
    }

		
}                                   

static void handle_key_callback (
        XPLMWindowID         inWindowID,    
        char                 inKey,    
        XPLMKeyFlags         inFlags,    
        char                 inVirtualKey,    
        void *               inRefcon,    
        int                  losingFocus)
{
}                                   

static int  handle_mouse_click_callback (
        XPLMWindowID         inWindowID,    
        int                  x,    
        int                  y,    
        XPLMMouseStatus      inMouse,    
        void *               inRefcon)
{
    ASE::WindowRef *winRef = (ASE::WindowRef*)inRefcon;
    ASE::Window* window;
    switch (winRef->type)
    {
        case ASE::WtWindow:
            window = (ASE::Window*)winRef->ref;
            break;
        case ASE::WtButton:
            window = (ASE::ButtonBehaviour*)winRef->ref;
            break;
        case ASE::WtInput:
            window = (ASE::InputBehaviour*)winRef->ref;
            break;
        default:
        break;

    }

    if (window->type == ASE::WtButton)
    {
        ASE::ButtonBehaviour* button = (ASE::ButtonBehaviour *)winRef->ref;

        if (inMouse == xplm_MouseDown && !button->clicked)
            button->onClick();

        if ((inMouse == xplm_MouseDown) || (inMouse == xplm_MouseUp))
            button->clicked = !button->clicked;

    }

    return 1;
}                                      

namespace ASE
{
    Rect::Rect(int x, int y, int w, int h) : x(x), y(y), w(w), h(h)
    {
    }

    ButtonBehaviour::ButtonBehaviour(Rect transform) : Window(transform, WtButton)
    {
        clicked = false;
        initWindow(WtButton, this);
        textsLength = 0;
    }

    void ButtonBehaviour::onClick()
    {
    }

    InputBehaviour::InputBehaviour(Rect transform) : Window(transform, WtInput)
    {
        initWindow(WtInput, this);
    }

    void InputBehaviour::onKeyPress()
    {
    }

    Window::Window(Rect transform) : transform(transform), type(WtWindow)
    {
        initWindow(WtWindow, this);
        initText();
    }

    Window::Window(Rect transform, WinType type) : transform(transform), type(type)
    {
        initText();
    }

    Window::~Window()
    {
        delete(winRef);
        XPLMDestroyWindow(window);
    }

    void Window::initWindow(WinType type, void* ref)
    {
        winRef = new WindowRef;
        winRef->type = type;
        winRef->ref = ref;

        hidden = false;
        window = XPLMCreateWindow(
                        transform.x, transform.y+transform.h, transform.x+transform.w, transform.y,			/* Area of the window. */
                        1,							/* Start visible. */
                        draw_window_callback,		/* Callbacks */
                        handle_key_callback,
                        handle_mouse_click_callback,
                        winRef);
    }

    void Window::initText()
    {
        texts = (Text**)malloc(sizeof(Text*));
        textsLength = 0;
    }

    void Window::addText(Text* text)
    {
        texts[textsLength] = text;
        textsLength++;
        texts = (Text**)realloc(texts, sizeof(Text*));
    }

    Text::Text(int x, int y) : x(x), y(y)
    {
        init();
    }

    Text::Text(int x, int y, char* text) : x(x), y(y)
    {
        init();
        strcpy(this->text, text);
    }

    void Text::init()
    {
        color[0] = 1.0;
        color[1] = 1.0;
        color[2] = 1.0;
    }
}
