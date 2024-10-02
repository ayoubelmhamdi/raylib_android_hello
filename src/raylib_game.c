#include "raylib.h"

int main(void) {
    const int w = 800;
    const int h = 400;


    InitWindow(w, h, "raylib [models] example - model animation");
    SetTargetFPS(60);

    Camera camera = {0};
    camera = (Camera){
        .position = (Vector3){10.0f, 0.0f, 0.0f},
        .target = (Vector3){0.0f, 0.0f, 0.0f},
        .up = (Vector3){0.0f, 1.0f, 0.0f},
        .fovy =90.0f,
        .projection = CAMERA_PERSPECTIVE
    };


    Model model = LoadModel("raylib-5.0/examples/models/resources/models/iqm/guy.iqm");
    Texture2D texture = LoadTexture("raylib-5.0/examples/models/resources/models/iqm/guytex.png");
    SetMaterialTexture(&model.materials[0], MATERIAL_MAP_DIFFUSE, texture);

    Vector3 model_position = {0.0f, 0.0f, 0.0f};
    Vector3 model_rotation = {0.0f, 90.0f, 90.0f};
    Vector3 model_scale    = {2.0f, 2.0f, 2.0f};
    float   model_ang      = 360.0f;

    while (!WindowShouldClose()) {
        UpdateCamera(&camera, CAMERA_FREE);
        BeginDrawing();
            ClearBackground(BLUE);
            BeginMode3D(camera);
                DrawModelEx(model, model_position, model_rotation, model_ang, model_scale, RED);
                DrawGrid(5, 5.0f);
            EndMode3D();
            DrawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, 10, 20, MAROON);
            DrawText("(c) Guy IQM 3D model by @culacant", w - 200, h - 20, 10, RED);
        EndDrawing();
    }

    CloseWindow();
    return 0;
}

