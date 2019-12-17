#include <vector>

#include "include/xplane/XPLM/XPLMDisplay.h"
#include "include/xplane/XPLM/XPLMGraphics.h"

namespace ASE
{
    enum WinType
    {
        WtWindow,
        WtButton,
        WtInput,
    };

    struct Rect
    {
        Rect(int x, int y, int w, int h);
        int x, y, w, h;
    };

    struct Text
    {
        Text(int x, int y);
        Text(int x, int y, char* text);
        const int x, y;

        char text[65536];
        float color[3];
        int font;
    protected:
        void init();
    };

    struct WindowRef
    {
        WinType type;
        void* ref;
    };

    class Window
    {
    protected:
        XPLMWindowID window;
        void initWindow(WinType type, void* ref);
        void initText();

        WindowRef* winRef;
    public:
        Window(Rect transform); // automatically assumes WinType as WtWindow
        Window(Rect transform, WinType type);
        ~Window();

        const Rect transform;
        const WinType type;
        bool hidden;
        Text** texts;
        int textsLength;

        void addText(Text* text);
    };

    struct ButtonBehaviour : public Window
    {
        ButtonBehaviour(Rect transform);
        bool clicked;
        virtual void onClick();
    };

    struct InputBehaviour : public Window
    {
        InputBehaviour(Rect transform);
        virtual void onKeyPress();
    };
}
