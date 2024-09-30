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

    int w = GetScreenWidth()/2;
    int h = GetScreenHeight()/2;

    SetWindowSize(w, h);
    SetWindowPosition(w / 2, h / 2);

    SetTargetFPS(60);

    Camera camera = {0};
    camera = (Camera){
        .position = (Vector3){10.0f, 10.0f, 10.0f},
        .target = (Vector3){0.0f, 0.0f, 0.0f},
        .up = (Vector3){0.0f, 0.0f, 0.0f},
        .fovy = 45.0f,
        .projection = CAMERA_PERSPECTIVE
    };
    Model model = LoadModel("raylib-5.0/examples/models/resources/models/iqm/guy.iqm");
    Texture2D texture = LoadTexture("raylib-5.0/examples/models/resources/models/iqm/guy.png");
    SetMaterialTexture(&model.materials[0], MATERIAL_MAP_DIFFUSE, texture);
    Vector3 position = {0.0f, 0.0f, 0.0f};

    while (!WindowShouldClose()) {
        w = GetScreenWidth();
        h = GetScreenHeight();
        BeginDrawing();
            ClearBackground(BLUE);
            DrawRectangle(BORDER_SIZE, BORDER_SIZE, w - 2 * BORDER_SIZE, h - 2 * BORDER_SIZE, WHITE);
            // DrawCircle(w / 2, h / 2, w / 8, RED);
            BeginMode3D(camera);
                DrawModel(model, position, 1.0f, TSODING);
                DrawGrid(10, 1.0f);
            EndMode3D();
        EndDrawing();
    }

    CloseWindow();
    return 0;
}

