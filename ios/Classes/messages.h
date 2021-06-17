// Autogenerated from Pigeon (v0.2.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class LHVersion;

@interface LHVersion : NSObject
@property(nonatomic, copy, nullable) NSString * string;
@end

@protocol LHApi
-(nullable LHVersion *)getPlatformVersion:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void LHApiSetup(id<FlutterBinaryMessenger> binaryMessenger, id<LHApi> _Nullable api);

NS_ASSUME_NONNULL_END