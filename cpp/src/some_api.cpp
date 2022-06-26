#include "some_api.h"

#include <chrono>
#include <iostream>
#include <thread>

void SomeApi::poke() {
    std::cout << "Got poked" << std::endl;
}

std::string SomeApi::echo(std::string send_value) {
    return send_value;
}

int32_t SomeApi::add(SomeApi::TwoIntegers two_integers) {
    return two_integers.first + two_integers.second;
}

void SomeApi::subscribe_mode(const std::function<void(Mode mode)>& mode_callback) {
    std::thread([mode_callback]() {
        for (size_t i = 0; i < 5; i++) {
            mode_callback(SomeApi::Mode::Active);
            std::this_thread::sleep_for(std::chrono::seconds(1));
        }
    }).detach();
}

