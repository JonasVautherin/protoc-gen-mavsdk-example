#include <functional>
#include <string>

class SomeApi {
public:
    enum class Mode {
        Unknown, // Mode unknown
        Idle, // Mode 'idle'
        Active, // Mode 'active'
    };

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

    // Multiply two numbers and return the result
    int32_t multiply(int32_t first, int32_t second);

    // Subscribe to 'mode' updates.
    void subscribe_mode(const std::function<void(Mode mode)>& mode_callback);
};
