cmake_minimum_required(VERSION 3.10)
project(cgns)

set(CMAKE_CXX_STANDARD 17)

add_subdirectory(GKlib)

set(METIS_SRC
        ${CMAKE_CURRENT_SOURCE_DIR}/include/metis.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/b64.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/blas.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/csr.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/error.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/evaluate.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/fkvkselect.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/fs.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/getopt.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_arch.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_defs.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_externs.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_getopt.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_macros.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_mkblas.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_mkmemory.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_mkpqueue.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_mkpqueue2.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_mkrandom.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_mksort.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_mkutils.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_proto.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_struct.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gk_types.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/GKlib.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gkregex.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/gkregex.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/graph.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/htable.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/io.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/itemsets.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/mcore.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/memory.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/ms_inttypes.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/ms_stat.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/ms_stdint.h
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/omp.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/pdb.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/pqueue.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/random.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/rw.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/seq.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/sort.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/string.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/timers.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/tokenizer.c
        ${CMAKE_CURRENT_SOURCE_DIR}/GKlib/util.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/auxapi.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/balance.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/bucketsort.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/checkgraph.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/coarsen.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/compress.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/contig.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/debug.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/defs.h
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/fm.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/fortran.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/frename.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/gklib.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/gklib_defs.h
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/gklib_rename.h
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/graph.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/initpart.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/kmetis.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/kwayfm.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/kwayrefine.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/macros.h
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/mcutil.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/mesh.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/meshpart.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/metislib.h
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/minconn.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/mincover.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/mmd.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/ometis.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/options.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/parmetis.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/pmetis.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/proto.h
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/refine.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/rename.h
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/separator.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/sfm.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/srefine.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/stat.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/stdheaders.h
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/struct.h
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/timing.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/util.c
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis/wspace.c)

add_library(metis ${METIS_SRC})
target_include_directories(metis PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${CMAKE_CURRENT_SOURCE_DIR}/libmetis)

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    target_compile_options(metis PUBLIC -w)
endif()

target_link_libraries(metis GKlib)
