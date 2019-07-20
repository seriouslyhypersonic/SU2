cmake_minimum_required(VERSION 3.10)
project(su2_cfd)

set(CMAKE_CXX_STANDARD 17)

# ------------------------------------------------------------------------------
# SU2 core
# ------------------------------------------------------------------------------

set(SU2_CORE_SCR
        ${CMAKE_CURRENT_SOURCE_DIR}/include/data_manufactured_solutions.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/definition_structure.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/fluid_model.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/fluid_model.inl  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/integration_structure.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/integration_structure.inl  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/driver_structure.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/iteration_structure.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/numerics_structure.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/numerics_structure.inl  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/output_structure.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/output_structure.inl  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/sgs_model.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/sgs_model.inl  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/solver_structure.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/solver_structure.inl  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/SU2_CFD.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/task_definition.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/task_definition.inl  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/transport_model.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/transport_model.inl  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/variable_structure.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/variable_structure.inl  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/transfer_structure.hpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/include/transfer_structure.inl  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/data_manufactured_solutions.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/definition_structure.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fluid_model.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fluid_model_pig.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fluid_model_pvdw.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fluid_model_ppr.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/fluid_model_inc.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/integration_structure.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/integration_time.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/driver_direct_multizone.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/driver_direct_singlezone.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/driver_structure.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/iteration_structure.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_adjoint_mean.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_adjoint_turbulent.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_direct_heat.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_direct_mean.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_direct_mean_inc.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_direct_transition.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_direct_turbulent.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_direct_elasticity_nonlinear.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_direct_elasticity_linear.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_direct_elasticity.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_structure.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/numerics_template.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/output_cgns.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/output_structure.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/output_physics.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/output_tecplot.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/output_fieldview.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/output_su2.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/output_paraview.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/python_wrapper_structure.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_adjoint_mean.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_adjoint_turbulent.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_adjoint_discrete.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_adjoint_elasticity.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_direct_heat.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_direct_mean.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_direct_mean_fem.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_direct_mean_inc.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_direct_transition.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_direct_turbulent.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_direct_elasticity.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_structure.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/solver_template.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/transfer_physics.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/transfer_structure.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/transport_model.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_adjoint_mean.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_adjoint_turbulent.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_adjoint_discrete.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_adjoint_elasticity.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_direct_heat.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_direct_mean.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_direct_mean_inc.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_direct_transition.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_direct_turbulent.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_direct_elasticity.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_structure.cpp  
        ${CMAKE_CURRENT_SOURCE_DIR}/src/variable_template.cpp)

add_library(su2_core ${SU2_CORE_SCR})

# Include
set(CGNS_INCLUDE_DIRS
        ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_include_directories(su2_core PUBLIC ${CGNS_INCLUDE_DIRS})

target_link_libraries(su2_core su2_common ${EXTERNAL_LIBRARIES})

# ------------------------------------------------------------------------------
# SU2_CFD
# ------------------------------------------------------------------------------

set(SU2_CFD_SRC
        ${CMAKE_CURRENT_SOURCE_DIR}/include/SU2_CFD.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/SU2_CFD.cpp)

add_executable(su2_cfd ${SU2_CFD_SRC})

# Include
target_include_directories(su2_cfd PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_link_libraries(su2_cfd su2_common su2_core)