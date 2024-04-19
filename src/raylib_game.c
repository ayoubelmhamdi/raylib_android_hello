#include "raylib.h"

#define BORDER_SIZE 2

#define TSODING CLITERAL(Color){0x18, 0x18, 0x18, 0xFF}

void DrawGameFrame(int w, int h) {
    ClearBackground(BLUE);
    DrawRectangle(BORDER_SIZE, BORDER_SIZE, w - 2 * BORDER_SIZE, h - 2 * BORDER_SIZE, TSODING);
    DrawCircle(w / 2, h / 2, w / 8, RED);
}

int main(void) {
    SetConfigFlags(FLAG_WINDOW_RESIZABLE);
    InitWindow(0, 0, "Ayoub");

    int w = GetScreenWidth();
    int h = GetScreenHeight();

    SetWindowSize(w, h);
    SetWindowPosition(w / 2, h / 2);

    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        w = GetScreenWidth();
        h = GetScreenHeight();
        BeginDrawing();
            DrawGameFrame(w, h);
        EndDrawing();
    }

    CloseWindow();
    return 0;
}

