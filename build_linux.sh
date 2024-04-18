#!/bin/sh
CFLAGS="-Wall -Wextra -pedantic -std=c99 -ggdb -O0"
INCLUDES="-I. -Iinclude -I../include"
LIBS="-lm -lglfw -ldl -lpthread ./lib/linux/libraylib.a"


mkdir -p build/
gcc $CFLAGS $INCLUDES ./src/raylib_game.c -o ./game $LIBS

