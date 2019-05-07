add_gmock_test(ToDoTest ToDoTest.cpp)
add_coverage(ToDoTest)
target_link_libraries(ToDoTest ToDoCore)
