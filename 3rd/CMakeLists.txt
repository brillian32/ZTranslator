cmake_minimum_required(VERSION 3.15.0)

project(QOnlineTranslator LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(AUTOMOC ON)

find_package(Qt6 COMPONENTS Multimedia StateMachine Network REQUIRED)
find_package(Doxygen)


#set(CMAKE_DEBUG_POSTFIX "D")
add_library(${PROJECT_NAME} SHARED
    src/qonlinetranslator.cpp
    src/qonlinetts.cpp
    src/qexample.cpp
    src/qoption.cpp
    src/qonlinetranslator.h
    src/qonlinetts.h
    src/qexample.h
    src/qoption.h
)
set(LIBRARY_OUTPUT_PATH ..)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt6::Network)
target_link_libraries(${PROJECT_NAME} PUBLIC Qt6::Multimedia Qt6::StateMachine)
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src)

add_subdirectory(hotkey)

if(DOXYGEN_FOUND)
    set(DOXYGEN_USE_MDFILE_AS_MAINPAGE README.md)

    doxygen_add_docs(${PROJECT_NAME}Documentation
        src/qonlinetranslator.h
        src/qonlinetts.h
        src/qexample.h
        src/qoption.h
        README.md
    )
endif()
