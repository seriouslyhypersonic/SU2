cmake_minimum_required(VERSION 3.10)
project(cgns)

set(CMAKE_CXX_STANDARD 17)

set(CGNS_SRC
        ${CMAKE_CURRENT_SOURCE_DIR}/cgnslib.h
        ${CMAKE_CURRENT_SOURCE_DIR}/cgns_header.h
        ${CMAKE_CURRENT_SOURCE_DIR}/cgns_io.h
        ${CMAKE_CURRENT_SOURCE_DIR}/cgnstypes.h
        ${CMAKE_CURRENT_SOURCE_DIR}/fortran_macros.h
        ${CMAKE_CURRENT_SOURCE_DIR}/adf/ADF.h
        ${CMAKE_CURRENT_SOURCE_DIR}/adf/ADF_fbind.h
        ${CMAKE_CURRENT_SOURCE_DIR}/adf/ADF_internals.h
        ${CMAKE_CURRENT_SOURCE_DIR}/cgns_error.c
        ${CMAKE_CURRENT_SOURCE_DIR}/cgns_internals.c
        ${CMAKE_CURRENT_SOURCE_DIR}/cgns_io.c
        ${CMAKE_CURRENT_SOURCE_DIR}/cgnslib.c
        ${CMAKE_CURRENT_SOURCE_DIR}/adf/ADF_interface.c
        ${CMAKE_CURRENT_SOURCE_DIR}/adf/ADF_internals.c)

add_library(cgns ${CGNS_SRC})
target_include_directories(cgns PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/adf)

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    target_compile_options(cgns PUBLIC -w)
endif()