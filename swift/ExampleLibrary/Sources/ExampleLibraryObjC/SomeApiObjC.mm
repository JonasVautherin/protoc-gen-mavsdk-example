#include <example_library/some_api.h>

#import "SomeApiObjC.h"

@implementation SomeApiObjC {
    SomeApi someApi;
}

- (NSString *) strCppToObjC:(std::string&)cpp_string {
    return [NSString
            stringWithCString:cpp_string.c_str()
            encoding:NSUTF8StringEncoding];
}

- (ModeObjC) modeCppToObjC:(SomeApi::Mode)mode {
    switch (mode) {
        case SomeApi::Mode::Unknown:
            return ModeObjCUnknown;
        case SomeApi::Mode::Idle:
            return ModeObjCIdle;
        case SomeApi::Mode::Active:
            return ModeObjCActive;
    }
}

- (SomeApi::TwoIntegers) twoIntegersObjCToCpp:(TwoIntegersObjC)twoIntegers {
    SomeApi::TwoIntegers two_integers;
    two_integers.first = twoIntegers.first;
    two_integers.second = twoIntegers.second;
    return two_integers;
}

- (void) poke {
    someApi.poke();
}

- (NSString *) echo:(NSString *)sendValue {
    auto result = someApi.echo(std::string([sendValue UTF8String]));
    return [self strCppToObjC:result];
}

- (int32_t) add:(TwoIntegersObjC)twoIntegers {
    auto result = someApi.add([self twoIntegersObjCToCpp:twoIntegers]);
    return result;
}

- (int32_t) multiply:(int32_t)first :(int32_t)second {
    auto result = someApi.multiply(first, second);
    return result;
}

- (void) subscribeMode:(void(^)(ModeObjC))callback {
    someApi.subscribe_mode([self, callback](SomeApi::Mode mode) {
        callback([self modeCppToObjC:mode]);
    });
}

@end
