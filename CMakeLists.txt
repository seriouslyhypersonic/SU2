cmake_minimum_required(VERSION 3.10)
project(su2)

set(CMAKE_CXX_STANDARD 17)

# ------------------------------------------------------------------------------
# Options
#   External:
#       - ENABLE_CGNS

option(ENABLE_CGNS "Enable CGNS support" OFF)
option(ENABLE_METIS "Enable metis support" OFF)

# Follows the spirit of configure.ac

# Type sizes
INCLUDE (CheckTypeSize)
check_type_size("short" SIZE_OF_SHORT)
check_type_size("int" SIZE_OF_INT)
check_type_size("unsigned int" SIZE_OF_UINT)
check_type_size("long" SIZE_OF_LONG)
check_type_size("float" SIZE_OF_FLOAT)
check_type_size("double" SIZE_OF_DOUBLE)
check_type_size("void *" SIZE_OF_VOID_P)
message("---------------------------------------------------------------------")
message(" Check for important type sizes                                      ")
message("---------------------------------------------------------------------")
message("short        " ${SIZE_OF_SHORT} " bytes")
message("int:         " ${SIZE_OF_INT}       " bytes")
message("unsigned int " ${SIZE_OF_UINT}      " bytes")
message("long         " ${SIZE_OF_LONG}      " bytes")
message("float        " ${SIZE_OF_FLOAT}     " bytes")
message("double       " ${SIZE_OF_DOUBLE}    " bytes")
message("void *       " ${SIZE_OF_VOID_P}    " bytes")
message(" ")

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
