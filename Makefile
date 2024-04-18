game: src include ./lib .FORCE
	@./build_linux.sh

game.apk: src assets .FORCE
	@./build_android.sh

install:
	adb install game.apk
	adb shell am start -a android.intent.action.MAIN -n com.raylib.rGame/.NativeLoader

clean:
	rm -rf ./android/build ./build/ game.apk ./game

.FORCE:
