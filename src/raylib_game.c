#include "raylib.h"

int main(void)
{
    InitWindow(800, 600, "Ayoub Android");

    while (!WindowShouldClose()){
        BeginDrawing();
            ClearBackground(RED);
        EndDrawing();
    }

    CloseWindow();
    return 0;
}
