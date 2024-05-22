#include "GlfwGeneral.hpp"

int main()
{
    if (!InitializeWindow({ 1920, 1080 }))
        return -1;
    while (!glfwWindowShouldClose(pWindow)) {

        

        glfwPollEvents();
        TitleFps();
    }
    TerminateWindow();

	return 0;
}