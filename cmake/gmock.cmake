set(GMOCK_DIR "${CMAKE_SOURCE_DIR}/googletest"
    CACHE PATH "The path to the GoogleMock test framework.")

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    option(gtest_force_shared_crt
           "Use shared (DLL_ run-time lib even when Google Test is built as static lib."
           ON
           )
elseif (APPLE)
    add_definitions(-DTEST_USE_OWN_TR1_TUPLE=1)
endif()

add_subdirectory("${GMOCK_DIR}")
target_include_directories(gmock_main
  SYSTEM BEFORE INTERFACE
  "${gtest_SOURCE_DIR}/include"
  "${gmock_SOURCE_DIR}/include"
)

#
#  add_gmock_test(<target> <sources>...)
#
#  Adds a Google Mock based test executable, <target>, built from <sources> and
#  adds the test so that CTest will run it. Both the executable and the test
#  will be named <target>.
#
function(add_gmock_test target)
    add_executable(${target} ${ARGN})
    target_link_libraries(${target} gmock_main)

    add_test(${target} ${target})

    add_custom_command(TARGET ${target}
                       POST_BUILD
                       COMMAND ${target}
                       WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                       COMMENT "Running ${target}" VERBATIM)
endfunction()

