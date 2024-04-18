game: src include ./lib .FORCE
	@./build_linux.sh

game.apk: src assets .FORCE
	@./build_android.sh

install:
	adb install game.apk
	adb shell am start -a android.intent.action.MAIN -n com.raylib.rGame/.NativeLoader

clean:
	rm -rf ./build/ game.apk ./game
	rm -rf android/build/{obj,dex,lib}

.FORCE:
