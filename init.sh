#!/bin/bash

# https://github.com/raysan5/raylib/wiki/Working-for-Android
# https://github.com/gtrxAC/gxbuild

# ---------- CONFIG --------------

RAYLIB_PATH="${RAYLIB_PATH:-/tmp/raylib-5.0}"
APP_COMPANY_NAME="${APP_COMPANY_NAME:-raylib}"
PROJECT_NAME="${PROJECT_NAME:-raylib}"
APP_KEYSTORE_PASS="${APP_KEYSTORE_PASS:-raylib}"
GAME_NAME="${GAME_NAME:-rGame}"


# Uncomment this to build raylib for andoid from scratch.
# ANDROID_NDK=${ANDROID_SDK_ROOT}/ndk
# ANDROID_API_VERSION=29
# ANDROID_BUILD_TOOLS_VERSION=29.0.3
# ANDROID_BUILD_TOOLS=${ANDROID_SDK_ROOT}/build-tools/${ANDROID_BUILD_TOOLS_VERSION}
# ANDROID_PLATFORM_TOOLS=${ANDROID_SDK_ROOT}/platform-tools

# export ANDROID_SDK_ROOT=/data/sdk/android
# export ANDROID_SDK_HOME="/data/sdk/androidHome"
# export PATH="$PATH:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_PLATFORM_TOOLS}" # sdkmanager, adb ...


# sdkmanager --install "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" "platform-tools" "platforms;android-${ANDROID_API_VERSION}"
# pushd ${RAYLIB_PATH}/src && make PLATFORM=PLATFORM_ANDROID ANDROID_API_VERSION=${ANDROID_API_VERSION} ANDROID_NDK=${ANDROID_NDK} && popd

# ---------------------------------------------------------------

mkdir -p assets include src lib/{armeabi-v7a,arm64-v8a,x86,x86_64}
mkdir -p android/{sdk,build}

mkdir -p android/build/{obj,dex,assets}
mkdir -p android/build/{res/values,src/com/${APP_COMPANY_NAME}/${GAME_NAME}}
mkdir -p android/build/lib/{armeabi-v7a,arm64-v8a,x86,x86_64}
mkdir -p android/build/res/{drawable-ldpi,drawable-mdpi,drawable-hdpi,drawable-xhdpi}



# SHOULD copy arm-v8a version of libraylib.a
cp ${RAYLIB_PATH}/src/libraylib.a lib/arm64-v8a

cp $RAYLIB_PATH/logo/raylib_36x36.png assets/icon_ldpi.png
cp $RAYLIB_PATH/logo/raylib_48x48.png assets/icon_mdpi.png
cp $RAYLIB_PATH/logo/raylib_72x72.png assets/icon_hdpi.png
cp $RAYLIB_PATH/logo/raylib_96x96.png assets/icon_xhdpi.png

[ ! -f android/${PROJECT_NAME}.keystore ] && \
    keytool -genkeypair -validity 10000 -dname "CN=${APP_COMPANY_NAME},O=Android,C=ES" -keystore android/${PROJECT_NAME}.keystore -storepass ${APP_KEYSTORE_PASS} -keypass ${APP_KEYSTORE_PASS} -alias ${PROJECT_NAME}Key -keyalg RSA

cat > android/build/src/com/${APP_COMPANY_NAME}/${GAME_NAME}/NativeLoader.java << EOL
package com.${APP_COMPANY_NAME}.${GAME_NAME};
public class NativeLoader extends android.app.NativeActivity {
    static {
        System.loadLibrary("main");
    }
}
EOL


# TODO: check android.app.lib_name

cat > android/build/AndroidManifest.xml << EOL
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="com.${APP_COMPANY_NAME}.${GAME_NAME}"
        android:versionCode="1" android:versionName="1.0" >
    <uses-sdk android:minSdkVersion="23" android:targetSdkVersion="29"/>
    <uses-feature android:glEsVersion="0x00020000" android:required="true"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <application android:allowBackup="false" android:label="${GAME_NAME}" android:icon="@drawable/icon">
        <activity android:name="com.${APP_COMPANY_NAME}.${GAME_NAME}.NativeLoader"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
            android:configChanges="orientation|keyboardHidden|screenSize"
            android:screenOrientation="portrait" android:launchMode="singleTask"
            android:clearTaskOnLaunch="true">
            <meta-data android:name="android.app.lib_name" android:value="main"/>
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application> 
</manifest>
EOL
