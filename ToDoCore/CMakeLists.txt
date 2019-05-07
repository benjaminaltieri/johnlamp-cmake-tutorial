add_library(ToDoCore ToDo.cpp)
# Include code-coverage settings:
target_link_libraries(ToDoCore PUBLIC coverage_config)

add_subdirectory(unit_test)
