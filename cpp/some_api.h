#include <string>

class SomeApi {
public:
    // Struct containing integers to add
    struct TwoIntegers {
        int32_t first{}; // First integer
        int32_t second{}; // Second integer
    };

    // Call a function (that may have side effects)
    void poke();

    // Send a value to be echoed back
    std::string echo(std::string send_value);

    // Add two numbers and return the result
    int32_t add(TwoIntegers two_integers);

    // Subscribe to 'mode' updates.
};
