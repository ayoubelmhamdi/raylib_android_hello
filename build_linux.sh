#!/bin/sh

DEBUG_CFLAGS="-ggdb -O0"
RELEASE_CFLAGS="-O3"

CFLAGS="-Wall -Wextra -pedantic -std=c99"
INCLUDES="-I. -Iinclude -I../include"
LIBS="-lm -lglfw -ldl -lpthread ./lib/linux/libraylib.a"


mkdir -p build/
if [ $RELEASE ];then
    echo "Release mode"
    set -x
    gcc $CFLAGS $RELEASE_CFLAGS $INCLUDES ./src/raylib_game.c -o ./game $LIBS
else
    echo "Debug mode"
    set -x
    gcc $CFLAGS $DEBUG_CFLAGS   $INCLUDES ./src/raylib_game.c -o ./game $LIBS -lX11
fi

