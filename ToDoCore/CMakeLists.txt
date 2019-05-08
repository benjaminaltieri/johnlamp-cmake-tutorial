add_library(ToDoCore ToDo.cpp)
target_code_coverage(ToDoCore AUTO ALL)

add_subdirectory(unit_test)
