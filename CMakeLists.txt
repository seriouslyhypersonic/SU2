cmake_minimum_required(VERSION 3.10)
project(su2)

set(CMAKE_CXX_STANDARD 17)

# ------------------------------------------------------------------------------
# Options
# ------------------------------------------------------------------------------

# SU2 modules
option(WITH_SU2_CFD "Build CFD module" ON)

# External dependencies
option(ENABLE_CGNS "Build with CFD General Notation System (CGNS) standard support (ADF only)" OFF)
option(ENABLE_METIS "Enable metis support" OFF)
option(ENABLE_PARMETIS "Enable parmetis support" OFF)
option(ENABLE_TECIO "Enable tecio support" OFF)

# Parallel build
option(ENABLE_MPI "Enable MPI message")

# MKL support
option(ENABLE_MKL "Build with Intel (R) MKL support" ON)

# Process options
if(ENABLE_MPI)
    # Need metis and parmetis for parallel build
    set(ENABLE_METIS  ON)
    set(ENABLE_PARMETIS ON)
endif()

if (ENABLE_MPI)
    message("---------------------------------------------------------------------")
    message(" MPI                                                                 ")
    message("---------------------------------------------------------------------")
    find_package(MPI REQUIRED)
    if(NOT MPI_CXX_FOUND)
        message(FATAL_ERROR "Cannot find MPI")
    endif()
    add_definitions(-DHAVE_MPI) # SU2 flag

    message(STATUS "MPI include       " ${MPI_CXX_INCLUDE_PATH})
    message(STATUS "MPI libraries     " ${MPI_CXX_LIBRARIES})
    message(STATUS "MPI compilers     "  ${MPI_CXX_COMPILER})
    message(STATUS "                  "  ${MPI_C_COMPILER})
    message(STATUS "MPI link flags    "  ${MPI_CXX_LINK_FLAGS})
    message(STATUS "MPI compile flags "  ${MPI_CXX_COMPILE_FLAGS})
    message(STATUS "SU2 define        HAVE_MPI")

    # Set the MPI compilers here
    set(THE_MPI_CXX_COMPILER ${MPI_CXX_COMPILER})
    set(THE_MPI_C_COMPILER ${MPI_C_COMPILER})
endif()

# ------------------------------------------------------------------------------
# External dependencies
# ------------------------------------------------------------------------------
set(EXTERNAL_LIBRARIES)
if (ENABLE_CGNS)
    list(APPEND EXTERNAL_LIBRARIES  cgns)
    add_definitions(-DHAVE_CGNS=1) # SU2 flag
endif ()
if (ENABLE_METIS)
    list(APPEND EXTERNAL_LIBRARIES  metis)
    add_definitions(-DHAVE_METIS=1) # SU2 flag
endif ()
if (ENABLE_PARMETIS)
    list(APPEND EXTERNAL_LIBRARIES  parmetis)
    add_definitions(-DHAVE_PARMETIS=1) # SU2 flag
endif ()
if (ENABLE_TECIO)
    list(APPEND EXTERNAL_LIBRARIES  tecio)
    add_definitions(-DHAVE_TECPLOT_API=1) # SU2 flag
endif ()

# Type sizes
include(CheckTypeSize)
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
if (ENABLE_MKL)
    if(NOT MKL_THREADING)
        # No execution mode provided, use intel as default
        set(MKL_THREADING intel)
    endif()
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
    find_package(MKL)
    if(MKL_FOUND)
        if(MKL_VERSION_MAJOR LESS 2019)
            message(FATAL_ERROR "SU2 requires MKL 2019 or newer")
        endif()
        add_definitions(-DHAVE_MKL)
        add_definitions(-DMKL_DIRECT_CALL_SEQ)
        message(STATUS "  SU2 define HAVE_MKL")
        message(STATUS "  SU2 define MKL_DIRECT_CALL_SEQ")
    endif()
endif ()

# ------------------------------------------------------------------------------
# Add modules
# ------------------------------------------------------------------------------

# External dependencies (if any)
if (ENABLE_CGNS OR ENABLE_METIS OR ENABLE_PARMETIS OR ENABLE_TECIO)
    add_subdirectory(externals)
endif ()

add_subdirectory(Common)

message("---------------------------------------------------------------------")
message(" SU2 modules                                                         ")
message("---------------------------------------------------------------------")
if(WITH_SU2_CFD)
    add_subdirectory(SU2_CFD)
    message(STATUS SU2_CFD)
endif()

# ------------------------------------------------------------------------------
# MPI compilers (this is changed somewhere along this script, an add_subdir?)
# todo fix the compiler change
# ------------------------------------------------------------------------------
message("---------------------------------------------------------------------")
message(" Compilers                                                           ")
message("---------------------------------------------------------------------")
if (ENABLE_MPI)
    set(CMAKE_CXX_COMPILER ${THE_MPI_CXX_COMPILER})
    set(CMAKE_C_COMPILER ${THE_MPI_C_COMPILER})
endif ()
message(STATUS "CXX compiler" ${CMAKE_CXX_COMPILER})
message(STATUS "C   compiler" ${CMAKE_C_COMPILER})
message("---------------------------------------------------------------------")
