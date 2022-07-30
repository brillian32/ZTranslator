cmake_minimum_required(VERSION 3.16)

project(ZTranslater VERSION 0.1 LANGUAGES CXX)

#set(CMAKE_TOOLCHAIN_FILE "C:/src/vcpkg/scripts/buildsystems/vcpkg.cmake")
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DQT_QML_DEBUG ")
#模块分组
set_property(GLOBAL PROPERTY USE_FOLDERS ON )
set_property(GLOBAL PROPERTY AUTOGEN_PARALLEL ON )

set(CMAKE_DEBUG_POSTFIX "D")

add_subdirectory(3rd)
include_directories(3rd/src)

find_package(Qt6 6.2 COMPONENTS Quick Concurrent Widgets REQUIRED)
find_package(Tesseract CONFIG REQUIRED)

source_group(Include FILES
   3rd/src/qonlinetranslator.h
)

source_group(QMLFile FILES
   main.qml
   MainWindow.qml
   FullScreenWindow.qml
   Screenshot.qml
)

qt_add_executable(appTranslater  
    main.cpp
    3rd/src/qonlinetranslator.h
    ztranslatertool.h
    ztranslatertool.cpp
    ZOcrProcess.h
    ZOcrProcess.cpp
    ${RESOURCES}
)

qt_add_qml_module(appTranslater
    URI Translater
    VERSION 1.0
    QML_FILES main.qml  MainWindow.qml    FullScreenWindow.qml Screenshot.qml   
   # RESOURCES
    #world.png
)

set_target_properties(appTranslater PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
 # WIN32_EXECUTABLE TRUE #取消终端
)

#release 模式下取消终端
message(${CMAKE_BUILD_TYPE})
if(CMAKE_BUILD_TYPE AND (CMAKE_BUILD_TYPE STREQUAL "Release"))
    set_target_properties(appTranslater PROPERTIES  WIN32_EXECUTABLE TRUE)
endif()

target_link_libraries(appTranslater
    PRIVATE Qt6::Quick 
    libtesseract
    Qt6::Widgets
    Qt6::Concurrent
    QOnlineTranslator
)

install(TARGETS appTranslater
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
