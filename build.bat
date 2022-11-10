@echo off

cls

echo Clean all
CALL flutter clean
CALL flutter pub get
echo Done clean all

echo Testing on Windows
CALL flutter run -d windows
echo Done testing on Windows

echo Resolving IDE warnings
cd autofill_service
CALL dart pub add --dev lints
CALL flutter pub upgrade lints
cd ..
echo Done resolving IDE warnings

echo Building AAB
CALL flutter build appbundle
echo Done building AAB

echo Building APK(s)
CALL flutter build apk --target-platform android-arm64 --split-per-abi
CALL flutter build apk --target-platform android-arm --split-per-abi
CALL flutter build apk --target-platform android-x64 --split-per-abi
echo Done building APK(s)

echo Building Windows EXE
CALL flutter build windows
echo Done building Windows EXE

@echo on