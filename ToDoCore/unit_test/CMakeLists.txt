add_subdirectory(googletest)
target_include_directories(gmock_main SYSTEM BEFORE INTERFACE
  "${gtest_SOURCE_DIR}/include" "${gmock_SOURCE_DIR}/include")

add_executable(ToDoTest ToDoTest.cpp)
target_link_libraries(ToDoTest ToDoCore gmock_main)

add_test(ToDoTest ToDoTest)
