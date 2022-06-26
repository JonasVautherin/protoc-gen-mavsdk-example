#include <example_library/some_api.h>
#include <pybind11/pybind11.h>

namespace py = pybind11;

PYBIND11_MODULE(example_library_py, m) {
    m.doc() = "Module corresponding to class SomeApi";

    py::class_<SomeApi> some_api(m, "SomeApi", "Example API for C++ meetup");
    some_api
        .def(py::init<>())
        .def("poke", &SomeApi::poke, "Call a function (that may have side effects)")
        .def("echo", &SomeApi::echo, "Send a value to be echoed back")
        .def("add", &SomeApi::add, "Add two numbers and return the result");

    py::class_<SomeApi::TwoIntegers> two_integers(some_api, "TwoIntegers");
    two_integers
        .def(py::init<>())
        .def_readwrite("first", &SomeApi::TwoIntegers::first, "First integer")
        .def_readwrite("second", &SomeApi::TwoIntegers::second, "Second integer");
}
