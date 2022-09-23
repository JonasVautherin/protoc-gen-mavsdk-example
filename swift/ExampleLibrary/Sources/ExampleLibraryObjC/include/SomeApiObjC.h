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

@interface SomeApiObjC : NSObject

- (void) poke;
- (nonnull NSString *) echo:(NSString * _Nonnull)sendValue;
- (int32_t) add:(TwoIntegersObjC)twoIntegers;
- (int32_t) multiply:(int32_t)first :(int32_t)second;
- (void) subscribeMode:(void(^_Nonnull)(ModeObjC))callback;

@end
