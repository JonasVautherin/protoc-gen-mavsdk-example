#include <example_library/some_api.h>

#import "SomeApiWrapper.h"

@implementation SomeApiWrapper {
    SomeApi someApi;
}

- (void) poke {
    return someApi.poke();
}

- (NSString *) echo:(NSString *)sendValue {
    std::string send_value = std::string([sendValue UTF8String]);
    std::string echoMessage = someApi.echo(send_value);

    return [NSString
            stringWithCString:echoMessage.c_str()
            encoding:NSUTF8StringEncoding];
}

- (int32_t) add:(TwoIntegersObjC)twoIntegers {
    SomeApi::TwoIntegers two_integers{twoIntegers.first, twoIntegers.second};
    return someApi.add(two_integers);
}

- (int32_t) multiply:(int32_t)first secondNumber:(int32_t)second {
    return someApi.multiply(first, second);
}

- (ModeObjC) cpp_mode_to_mode:(SomeApi::Mode)mode {
    switch (mode) {
        case SomeApi::Mode::Unknown:
            return ModeObjCUnknown;
        case SomeApi::Mode::Idle:
            return ModeObjCIdle;
        case SomeApi::Mode::Active:
            return ModeObjCActive;
    }
}

- (void) subscribe_mode:(void(^)(ModeObjC))callback {
    someApi.subscribe_mode([callback, self](SomeApi::Mode mode) {
        callback([self cpp_mode_to_mode:mode]);
    });
}

@end
