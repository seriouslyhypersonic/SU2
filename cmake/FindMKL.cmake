# Copyright (c) Nuno Alves de Sousa 2019
#
# Use, modification and distribution is subject to the Boost Software License,
# Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)
#
# Find Intel(R) Math Kernel Library (64 bit)
#
# Useful references:
#     https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor
#     https://software.intel.com/en-us/mkl-linux-developer-guide-linking-with-threading-libraries
#
# To find, include and link with MKL:
# MKL_FOUND                   - System has MKL
# MKL_VERSION                 - MKL version (full)
# MKL_VERSION_MAJOR           - Major MKL version
# MKL_INCLUDE_DIRS            - MKL include directories
# MKL_LIBRARIES               - The MKL libraries and link advisor dependecies
#
# For optional detection summary:
# MKL_INTERFACE_LIBRARY       - MKL interface library
# MKL_CORE_LIBRARY            - MKL core library
# MKL_THREADING_LAYER_LIBRARY - MKL threaing layer library
#
# Requires one of the following envirnment variables:
#     - MKLROOT points to the MKL root
#     todo: remove - INTEL   points to the parent directory of MKLROOT
#
# Execution mode is selected with -DMKL_THREADING=<intel | gnu | sequential>
#     - intel      uses Intel(R) OpenMP libraries
#     - gnu        uses GNU OpenMP libraries
#     - sequential no parallel execution
#
# Basic usage:
# find_package(MKL)
# if(MKL_FOUND)
#     target_include_directories(TARGET PRIVATE ${MKL_INCLUDE_DIRS})
#     target_link_libraries(TARGET ${MKL_LIBRARIES})
# endif()

# ------------------------------------------------------------------------------
# Options
# ------------------------------------------------------------------------------
if(NOT MKL_LINKING)
    set(MKL_STATIC ON)
    set(MKL_LINKING static)
elseif(MKL_LINKING STREQUAL static)
    set(MKL_STATIC ON)
elseif(NOT MKL_LINKING STREQUAL dynamic)
    message(FATAL_ERROR "Invalid MKL_LINKING value '${MKL_LINKING}'")
endif()

message("---------------------------------------------------------------------")
message("Intel(R) Math Kernel libraries                                       ")
message("---------------------------------------------------------------------")
message(STATUS "MKL linking                    ${MKL_LINKING}")
# If already in cache, be silent
#if (MKL_INCLUDE_DIRS
#        AND MKL_LIBRARIES
#        AND MKL_INTERFACE_LIBRARY
#        AND MKL_CORE_LIBRARY
#        AND MKL_THREADING_LAYER_LIBRARY)
#    set (MKL_FIND_QUIETLY TRUE)
#endif()
if (NOT DEFINED ENV{MKLROOT})
    message(FATAL_ERROR
            "No hints for MKL were found, please set MKLROOT "
            "environment variable")
endif ()

# --- Detect execution mode
if (MKL_THREADING STREQUAL "intel")
    message(STATUS "MKL execution mode             parallel (Intel(R) OpenMP library)")
    set(MKL_THREADING_INTEL TRUE)
elseif (MKL_THREADING STREQUAL "gnu")
    if (APPLE)
        message(FATAL_ERROR
                "On MacOS X, the GNU threading layer is unsupported.\n"
                "You can select Intel(R) instead")
    endif ()

    message(STATUS "MKL execution mode             parallel (GNU OpenMP library)")
    set(MKL_THREADING_GNU TRUE)
elseif (MKL_THREADING STREQUAL "sequential")
    message(STATUS "MKL execution mode             sequential")
    set(MKL_THREADING_SEQUENTIAL TRUE)
elseif(MKL_THREADING)
    message(FATAL_ERROR
            "invalid usage -DMKL_THREADING=${MKL_THREADING}\n"
            "usage -DMKL_THREADING=< intel | gnu | sequential >")
else()
    message(WARNING "No MKL_THREADING option selected. Using default (sequential)\n"
            "usage -DMKL_THREADING=< intel | gnu | sequential >")
endif()

# --- Generate appropriate filenames for MKL libraries
# (prefix)libname(sufix)

if(MKL_STATIC)
    set(MKL_LIB_PREFIX ${CMAKE_STATIC_LIBRARY_PREFIX})
    set(MKL_LIB_SUFFIX ${CMAKE_STATIC_LIBRARY_SUFFIX})
elseif()
    set(MKL_LIB_PREFIX ${MKL_LIB_PREFIX})
    set(MKL_LIB_SUFFIX ${CMAKE_STATIC_LIBRARY_SUFFIX})
endif()

    # MKL Interface layer library - mkl_intel_ilp64 (always 64 bit integer)
    set(INT_LIB "${MKL_LIB_PREFIX}")
    set(INT_LIB "${INT_LIB}mkl_intel_ilp64")
    set(INT_LIB "${INT_LIB}${MKL_LIB_SUFFIX}")

    # MKL Core library - mkl_core
    set(COR_LIB "${MKL_LIB_PREFIX}")
    set(COR_LIB "${COR_LIB}mkl_core")
    set(COR_LIB "${COR_LIB}${MKL_LIB_SUFFIX}")

    # MKL threading layer library
    set(THR_LIB "${MKL_LIB_PREFIX}")
    if (MKL_THREADING_INTEL)
        # use - mkl_intel_thread
        set(THR_LIB "${THR_LIB}mkl_intel_thread")
    elseif (MKL_THREADING_GNU)
        # use - mkl_gnu_thread
        set(THR_LIB "${THR_LIB}mkl_gnu_thread")
    else()
        # use - mkl_sequential
        set(THR_LIB "${THR_LIB}mkl_sequential")
    endif()
    set(THR_LIB "${THR_LIB}${MKL_LIB_SUFFIX}")

    # TODO: handle this in the future noting that on windows libname_dll.dll

# --- Generate appropriate filename for run-time threading library
set(RTL_LIB "${CMAKE_SHARED_LIBRARY_PREFIX}")
if (MKL_THREADING_INTEL)
    set(RTL_LIB "${RTL_LIB}iomp5")
elseif(MKL_THREADING_GNU)
    set(RTL_LIB "${RTL_LIB}gomp")
endif()
set(RTL_LIB "${RTL_LIB}${CMAKE_SHARED_LIBRARY_SUFFIX}")

if (MKL_THREADING_SEQUENTIAL)
    set(RTL_LIB "")
endif ()

# --- Find MKL summary
message(STATUS "Looking for:")
message(STATUS "  MKL interface library        ${INT_LIB}")
message(STATUS "  MKL core library             ${COR_LIB}")
message(STATUS "  MKL threading layer library  ${THR_LIB}")
message(STATUS "  Run-time threading library   ${RTL_LIB}")

# --- Search libraries and includes
find_library(MKL_INTERFACE_LIBRARY NAMES ${INT_LIB}
        PATHS $ENV{MKLROOT}/lib/
              $ENV{MKLROOT}/lib/intel64
              $ENV{INTEL}/mkl/lib/intel64
        NO_DEFAULT_PATH)
if(NOT MKL_INTERFACE_LIBRARY)
    message(STATUS $ENV{MKLROOT})
    message(FATAL_ERROR "Cannot find MKL interface library: ${INT_LIB}")
endif()

find_library(MKL_CORE_LIBRARY  NAMES ${COR_LIB}
        PATHS $ENV{MKLROOT}/lib/
              $ENV{MKLROOT}/lib/intel64
              $ENV{INTEL}/mkl/lib/intel64
        NO_DEFAULT_PATH)
if(NOT MKL_CORE_LIBRARY)
    message(FATAL_ERROR "Cannot find MKL core library: ${COR_LIB}")
endif()

find_library(MKL_THREADING_LAYER_LIBRARY
        NAMES ${THR_LIB}
        PATHS $ENV{MKLROOT}/lib/
              $ENV{MKLROOT}/lib/intel64
              $ENV{INTEL}/mkl/lib/intel64
        NO_DEFAULT_PATH)
if(NOT MKL_THREADING_LAYER_LIBRARY)
    message(FATAL_ERROR "Cannot find MKL threading layer library: ${THR_LIB}")
endif()

find_path(MKL_INCLUDE_DIR NAMES mkl.h
        PATHS $ENV{MKLROOT}/include
              $ENV{INTEL}/mkl/include
        NO_DEFAULT_PATH)
if(NOT MKL_INCLUDE_DIR)
    message(FATAL_ERROR "Cannot find MKL include directory")
endif()

# --- Search was successful
set(MKL_LIBRARIES ${MKL_INTERFACE_LIBRARY}
        ${MKL_THREADING_LAYER_LIBRARY}
        ${MKL_CORE_LIBRARY})
set(MKL_INCLUDE_DIRS ${MKL_INCLUDE_DIR})

# --- Detect MKL version
file(STRINGS ${MKL_INCLUDE_DIRS}/mkl_version.h MKL_VERSION_LINE REGEX "INTEL_MKL_VERSION")
string(REGEX MATCH "[(0-9)]+" MKL_VERSION ${MKL_VERSION_LINE})

file(STRINGS ${MKL_INCLUDE_DIRS}/mkl_version.h MKL_VERSION_MAJOR_LINE REGEX "__INTEL_MKL__")
string(REGEX MATCH "[(0-9)]+" MKL_VERSION_MAJOR ${MKL_VERSION_MAJOR_LINE})


# --- Generate links to MKL libraries and its dependencies
# todo: other platforms
# GNU
if (UNIX)
    # Choose required RTL
    if(MKL_THREADING_INTEL)
        set(MKL_LINK_OPTIONS ${MKL_LINK_OPTIONS} -liomp5)
    elseif(MKL_THREADING_GNU)
        set(MKL_LINK_OPTIONS ${MKL_LINK_OPTIONS} -lgomp)
    endif()

    # Always required
    set(MKL_LINK_OPTIONS "${MKL_LINK_OPTIONS} -lpthread -lm -ldl")

    if (MKL_STATIC)
        # Static linking
        if (UNIX AND NOT APPLE)
            # Must add --start-group --end-group required
            set(MKL_LIBRARIES
                    "-Wl,--start-group"  ${MKL_LIBRARIES}  "-Wl,--end-group")
        endif ()
    else()
        # Dynamic linking

        # Linux / macOS specific
        if (UNIX AND NOT APPLE)
            set(MKL_LIBRARIES "-L$ENV{MKLROOT}/lib/intel64 -Wl,--no-as-needed ${MKL_LIBRARIES}")
        elseif(APPLE)
            # todo: test this on macOS
            set(MKL_LIBRARIES "-L$ENV{MKLROOT}/lib -Wl,-rpath,${MKLROOT}/lib ${MKL_LIBRARIES}")
        endif()
    endif()


    set(MKL_LIBRARIES ${MKL_LIBRARIES} ${MKL_LINK_OPTIONS})
endif ()

# --- Set compiler options
if (MKL_INCLUDE_DIR AND
        MKL_INTERFACE_LIBRARY AND
        MKL_CORE_LIBRARY AND
        MKL_THREADING_LAYER_LIBRARY)

    if (NOT DEFINED ENV{CRAY_PRGENVPGI}
            AND NOT DEFINED ENV{CRAY_PRGENVGNU}
            AND NOT DEFINED ENV{CRAY_PRGENVCRAY}
            AND NOT DEFINED ENV{CRAY_PRGENVINTEL})
      set(ABI "-m64")
    endif()

    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DMKL_ILP64 ${ABI}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DMKL_ILP64 ${ABI}")
else()
    set(MKL_LIBRARIES "")
    set(MKL_INTERFACE_LIBRARY "")
    set(MKL_SEQUENTIAL_LAYER_LIBRARY "")
    set(MKL_CORE_LIBRARY "")
    set(MKL_INCLUDE_DIRS "")
endif()

# Report success
message(STATUS Result:)
message(STATUS "  Found MKL version " ${MKL_VERSION})

# Handle the QUIETLY and REQUIRED arguments and set MKL_FOUND to TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MKL REQUIRED_VARS
        MKL_LIBRARIES
        MKL_INTERFACE_LIBRARY
        MKL_CORE_LIBRARY
        MKL_THREADING_LAYER_LIBRARY
        MKL_INCLUDE_DIRS
        VERSION_VAR
        MKL_VERSION)

mark_as_advanced(MKL_LIBRARIES
        MKL_INTERFACE_LIBRARY
        MKL_CORE_LIBRARY
        MKL_THREADING_LAYER_LIBRARY
        MKL_INCLUDE_DIRS
        MKL_VERSION)
