#import <Foundation/Foundation.h>

typedef struct {
    int32_t first;
    int32_t second;
} TwoIntegersObjC;

typedef NS_ENUM(uint16_t, ModeObjC) {
    ModeObjCUnknown,
    ModeObjCIdle,
    ModeObjCActive
};

@interface SomeApiWrapper : NSObject

- (void) poke;
- (nonnull NSString *) echo:(NSString * _Nonnull)send_value;
- (int32_t) add:(TwoIntegersObjC)twoIntegers;
- (int32_t) multiply:(int32_t)first secondNumber:(int32_t)second;
- (void) subscribe_mode:(void(^)(ModeObjC))callback;

@end
