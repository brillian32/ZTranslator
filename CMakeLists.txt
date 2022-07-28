cmake_minimum_required(VERSION 3.16)

project(ZTranslater VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(3rd)
include_directories(3rd/src)

find_package(Qt6 6.2 COMPONENTS Quick Widgets REQUIRED)

source_group(Interface FILES
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
)

qt_add_qml_module(appTranslater
    URI Translater
    VERSION 1.0
    QML_FILES main.qml  MainWindow.qml    FullScreenWindow.qml Screenshot.qml
)

set_target_properties(appTranslater PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)


target_link_libraries(appTranslater
    PRIVATE Qt6::Quick
    Qt6::Widgets
    QOnlineTranslator

)

install(TARGETS appTranslater
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
