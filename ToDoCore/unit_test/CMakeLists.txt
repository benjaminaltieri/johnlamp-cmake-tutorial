if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    option(gtest_force_shared_crt
           "Use shared (DLL_ run-time lib even when Google Test is built as static lib."
           ON
           )
elseif (APPLE)
    add_definitions(-DTEST_USE_OWN_TR1_TUPLE=1)
endif()

add_subdirectory(googletest)
target_include_directories(gmock_main
  SYSTEM BEFORE INTERFACE
  "${gtest_SOURCE_DIR}/include"
  "${gmock_SOURCE_DIR}/include"
)

add_executable(ToDoTest ToDoTest.cpp)
target_link_libraries(ToDoTest ToDoCore gmock_main)

add_test(ToDoTest ToDoTest)
