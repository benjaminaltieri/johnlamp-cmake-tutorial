#include <iostream>
#include <string>

#include <boost/program_options.hpp>

#include "ToDoCore/ToDo.h"

using namespace std;
using namespace boost::program_options;

int main(int argc, char** argv)
{
    options_description desc("Options");
    desc.add_options()
        ("help,h", "displat this help")
        ("add,a", value<string>(), "add a new entry to the To Do list")
        ;

    bool parseError = false;
    variables_map vm;
    try
    {
        store(parse_command_line(argc, argv, desc), vm);
        notify(vm);
    }
    catch (error& error)
    {
        cerr << "Error: " << error.what() << endl;
    }

    if (parseError || vm.count("help")) {
        cout << "todo: A simple To Do List program" << endl;
        cout << endl;
        cout << "Usage:" << endl;
        cout << "  " << argv[0] << " [options]" << endl;
        cout << endl;
        cout << desc << endl;

        if (parseError) {
            return 64;
        } else {
            return 0;
        }
    }

    ToDo list;

    list.addTask("write code");
    list.addTask("compile");
    list.addTask("test");

    if (vm.count("add")) {
        list.addTask(vm["add"].as<string>());
    }

    for (size_t i = 0; i < list.size(); i++)
    {
        cout << list.getTask(i) << endl;
    }

    return 0;
}

template <typename T1, typename T2>
int equalityTest(const T1 testValue,
                 const T2 expectedValue,
                 const char* testName,
                 const char* expectedName,
                 const char* fileName,
                 const int lineNumber
                )
{
    if (testValue != expectedValue) {
        cerr << fileName << ":" << lineNumber << ": "
             << "Expected " << testName << " "
             << "to equal " << expectedName << " (" << expectedValue << ") "
             << "but it was (" << testValue << ")" << endl;

        return 1;
    } else {
        return 0;
    }
}

