cmake_minimum_required(VERSION 3.10)
project(su2_common)

set(CMAKE_CXX_STANDARD 17)

set(SU2_COMMON_SRC
        ${CMAKE_CURRENT_SOURCE_DIR}/include/datatypes/primitive_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/datatypes/primitive_structure.inl
#        ${CMAKE_CURRENT_SOURCE_DIR}/include/datatypes/complex_structure.hpp
#        ${CMAKE_CURRENT_SOURCE_DIR}/include/datatypes/complex_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/ad_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/ad_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/fem_cgns_elements.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/config_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/config_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/config_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/blas_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/dual_grid_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/dual_grid_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/fem_geometry_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/fem_geometry_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/fem_standard_element.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/fem_standard_element.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/geometry_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/geometry_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/graph_coloring_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/grid_adaptation_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/grid_adaptation_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/grid_movement_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/grid_movement_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/linear_solvers_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/linear_solvers_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/linear_solvers_structure_b.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/option_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/primal_grid_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/primal_grid_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/vector_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/vector_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/matrix_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/matrix_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/mpi_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/mpi_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/datatype_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/datatype_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/interpolation_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/fem_gauss_jacobi_quadrature.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/fem_gauss_jacobi_quadrature.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/gauss_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/gauss_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/element_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/element_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/adt_structure.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/adt_structure.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/include/wall_model.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/include/wall_model.inl
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fem_cgns_elements.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/config_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/blas_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/dual_grid_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fem_geometry_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fem_integration_rules.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fem_standard_element.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fem_wall_distance.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fem_work_estimate_metis.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/geometry_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/geometry_structure_fem_part.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/graph_coloring_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/grid_adaptation_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/grid_movement_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/linear_solvers_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/primal_grid_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/vector_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/matrix_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/mpi_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/linear_solvers_structure_b.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/ad_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fem_gauss_jacobi_quadrature.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/gauss_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/element_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/element_linear.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/interpolation_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/adt_structure.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/wall_model.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/toolboxes/printing_toolbox.cpp)

add_library(su2_common ${SU2_COMMON_SRC})

# Include
set(SU2_INCLUDE_DIRS
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${MPI_CXX_INCLUDE_PATH}
        ${MKL_INCLUDE_DIRS})

target_include_directories(su2_common PUBLIC ${SU2_INCLUDE_DIRS})
target_compile_options(su2_common PRIVATE ${MPI_CXX_COMPILE_FLAGS})
target_link_libraries(su2_common
        ${MPI_CXX_LIBRARIES}
        ${MPI_CXX_LINK_FLAGS}
        ${MKL_LIBRARIES}
        ${EXTERNAL_LIBRARIES})

