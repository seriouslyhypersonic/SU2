cmake_minimum_required(VERSION 3.10)
project(su2)

set(CMAKE_CXX_STANDARD 17)

# ------------------------------------------------------------------------------
# Options
# ------------------------------------------------------------------------------
option(ENABLE_CGNS "Build with CFD General Notation System (CGNS) standard support (ADF only)" OFF)
option(ENABLE_METIS "Enable metis support" OFF)
option(ENABLE_PARMETIS "Enable parmetis support" OFF)
option(ENABLE_TECIO "Enable tecio support" OFF)

# Process options
if (ENABLE_PARMETIS)
message("---------------------------------------------------------------------")
message(" MPI                                                                 ")
message("---------------------------------------------------------------------")
    find_package(MPI)
    if(NOT MPI_CXX_FOUND)
        message(FATAL_ERROR "Cannot find MPI")
    endif()
    message(STATUS "MPI include   " ${MPI_CXX_INCLUDE_PATH})
    message(STATUS "MPI libraries " ${MPI_CXX_LIBRARIES})
endif()

# Follows the spirit of configure.ac

# Type sizes
INCLUDE (CheckTypeSize)
message("---------------------------------------------------------------------")
message(" Check for important type sizes                                      ")
message("---------------------------------------------------------------------")
check_type_size("short" SIZE_OF_SHORT)
check_type_size("int" SIZE_OF_INT)
check_type_size("unsigned int" SIZE_OF_UINT)
check_type_size("long" SIZE_OF_LONG)
check_type_size("float" SIZE_OF_FLOAT)
check_type_size("double" SIZE_OF_DOUBLE)
check_type_size("void *" SIZE_OF_VOID_P)
message(STATUS "short        " ${SIZE_OF_SHORT} " bytes")
message(STATUS "int:         " ${SIZE_OF_INT}       " bytes")
message(STATUS "unsigned int " ${SIZE_OF_UINT}      " bytes")
message(STATUS "long         " ${SIZE_OF_LONG}      " bytes")
message(STATUS "float        " ${SIZE_OF_FLOAT}     " bytes")
message(STATUS "double       " ${SIZE_OF_DOUBLE}    " bytes")
message(STATUS "void *       " ${SIZE_OF_VOID_P}    " bytes")

# ------------------------------------------------------------------------------
# MKL
# ------------------------------------------------------------------------------
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
find_package(MKL)
if(MKL_FOUND)
    if(MKL_VERSION_MAJOR LESS 2019)
        message(FATAL_ERROR "SU2 requires MKL 2019 or newer")
    endif()
endif()

add_subdirectory(externals)
add_subdirectory(Common)