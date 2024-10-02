DEBUG_CFLAGS=-ggdb -O0
RELEASE_CFLAGS=-O3
CFLAGS=-Wall -Wextra -pedantic -std=c99 -Wno-unused-variable
INCLUDES=-I. -Iinclude -I../include
LIBS=-lm -lglfw -ldl -lpthread ./lib/linux/libraylib.a

.PHONY: game gamedebug

game: src include ./lib .FORCE
	@mkdir -p build/
	@gcc $(CFLAGS) $(DEBUG_CFLAGS) $(INCLUDES) ./src/raylib_game.c -o ./game $(LIBS) -lX11

release: src include ./lib .FORCE
	@mkdir -p build/
	@gcc $(CFLAGS) $(RELEASE_CFLAGS) $(INCLUDES) ./src/raylib_game.c -o ./game $(LIBS)


game.apk: src assets .FORCE
	@./build_android.sh

install:
	adb install game.apk
	adb shell am start -a android.intent.action.MAIN -n com.raylib.rGame/.NativeLoader

clean:
	rm -rf ./build/ game.apk ./game
	rm -rf android/build/{obj,dex,lib}

tags: include/raylib.h include/raymath.h
	ctags -R --c++-kinds=+p --fields=+iaS --extras=+q --language-force=C include/*.h
.FORCE:
