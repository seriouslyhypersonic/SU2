cmake_minimum_required(VERSION 3.10)
project(parmetis)

set(CMAKE_CXX_STANDARD 17)

set(PARMETIS_SRC
        ${CMAKE_CURRENT_SOURCE_DIR}/include/parmetis.h  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/akwayfm.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/ametis.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/balancemylink.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/comm.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/csrmatch.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/ctrl.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/debug.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/defs.h  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/diffutil.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/frename.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/gkmetis.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/gkmpi.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/graph.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/initbalance.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/initmsection.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/initpart.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/kmetis.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/kwayrefine.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/macros.h  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/match.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/mdiffusion.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/mesh.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/mmetis.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/move.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/msetup.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/node_refine.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/ometis.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/parmetislib.h  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/proto.h  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/pspases.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/redomylink.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/remap.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/rename.h  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/renumber.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/rmetis.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/selectq.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/serial.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/stat.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/struct.h  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/timer.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/util.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/wave.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/weird.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/wspace.c  
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis/xyzpart.c
)

add_library(parmetis ${PARMETIS_SRC})

# Include
set(PARAMETIS_INCLUDE_DIRS
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${CMAKE_CURRENT_SOURCE_DIR}/libparmetis
        ${GKLIB_INCLUDE_DIRS}
        ${MPI_CXX_INCLUDE_PATH})
target_include_directories(parmetis PUBLIC ${PARAMETIS_INCLUDE_DIRS})

# PIC
set_target_properties(parmetis PROPERTIES POSITION_INDEPENDENT_CODE ON)

target_link_libraries(parmetis metis GKlib ${MPI_CXX_LIBRARIES})