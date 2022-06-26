#include "some_api.h"

#include <iostream>

void SomeApi::poke() {
    std::cout << "Got poked" << std::endl;
}

std::string SomeApi::echo(std::string send_value) {
    return send_value;
}

int32_t SomeApi::add(SomeApi::TwoIntegers two_integers) {
    return two_integers.first + two_integers.second;
}

