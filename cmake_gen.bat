mkdir VSProject
cd VSProject
del CMakeCache.txt
cmake.exe -G "Visual Studio 17 2022" -DCMAKE_TOOLCHAIN_FILE=C:/src/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_PREFIX_PATH=C:/Qt/6.2.4/msvc2019_64  -DQT_DECLARATIVE_DEBUG=true -DQT_QML_DEBUG=true -DCMAKE_BUILD_TYPE=Debug ..
pause