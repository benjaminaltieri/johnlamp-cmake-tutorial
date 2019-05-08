add_gmock_test(ToDoTest ToDoTest.cpp)
target_link_libraries(ToDoTest ToDoCore)
target_code_coverage(ToDoTest AUTO ALL)
