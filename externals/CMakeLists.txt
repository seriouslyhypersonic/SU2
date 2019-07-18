cmake_minimum_required(VERSION 3.10)
project(external)

message("---------------------------------------------------------------------")
message(" External dependencies                                               ")
message("---------------------------------------------------------------------")
if(ENABLE_CGNS)
    add_subdirectory(cgns)
    add_definitions(-DHAVE_CGNS=1) # SU2 flag
endif()

if(ENABLE_METIS)
    add_subdirectory(metis)
    add_definitions(-DHAVE_METIS=1) # SU2 flag
endif()

if(ENABLE_PARMETIS)
    add_subdirectory(parmetis)
    add_definitions(-DHAVE_PARMETIS=1) # SU2 flag
endif()

if(ENABLE_TECIO)
    add_subdirectory(tecio/teciosrc)
    add_definitions(-DHAVE_TECPLOT_API=1) # SU2 flag
endif()

# Summary
if (ENABLE_CGNS OR ENABLE_METIS OR ENABLE_PARMETIS)
    message(STATUS "Enabled the following libraries:")
endif ()
if(ENABLE_CGNS)
    message(STATUS "  CGNS     defined HAVE_CGNS")
endif()
if(ENABLE_METIS)
    message(STATUS "  METIS    defined HAVE_METIS")
endif()
if(ENABLE_PARMETIS)
    message(STATUS "  PARMETIS defined HAVE_PARMETIS")
endif()
if(ENABLE_TECIO)
    message(STATUS "  TECIO defined HAVE_TECPLOT_API")
endif()