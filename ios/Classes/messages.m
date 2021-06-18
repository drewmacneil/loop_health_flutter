// Autogenerated from Pigeon (v0.2.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "messages.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString*, id>* wrapResult(NSDictionary *result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ? error.code : [NSNull null]),
        @"message": (error.message ? error.message : [NSNull null]),
        @"details": (error.details ? error.details : [NSNull null]),
        };
  }
  return @{
      @"result": (result ? result : [NSNull null]),
      @"error": errorDict,
      };
}

@interface LHStoredGlucoseSample ()
+(LHStoredGlucoseSample*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface LHStoredGlucoseResponse ()
+(LHStoredGlucoseResponse*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface LHStoredGlucoseRequest ()
+(LHStoredGlucoseRequest*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end

@implementation LHStoredGlucoseSample
+(LHStoredGlucoseSample*)fromMap:(NSDictionary*)dict {
  LHStoredGlucoseSample* result = [[LHStoredGlucoseSample alloc] init];
  result.timestamp = dict[@"timestamp"];
  if ((NSNull *)result.timestamp == [NSNull null]) {
    result.timestamp = nil;
  }
  result.quantity = dict[@"quantity"];
  if ((NSNull *)result.quantity == [NSNull null]) {
    result.quantity = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.timestamp ? self.timestamp : [NSNull null]), @"timestamp", (self.quantity ? self.quantity : [NSNull null]), @"quantity", nil];
}
@end

@implementation LHStoredGlucoseResponse
+(LHStoredGlucoseResponse*)fromMap:(NSDictionary*)dict {
  LHStoredGlucoseResponse* result = [[LHStoredGlucoseResponse alloc] init];
  result.serializedStoredGlucoseValues = dict[@"serializedStoredGlucoseValues"];
  if ((NSNull *)result.serializedStoredGlucoseValues == [NSNull null]) {
    result.serializedStoredGlucoseValues = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.serializedStoredGlucoseValues ? self.serializedStoredGlucoseValues : [NSNull null]), @"serializedStoredGlucoseValues", nil];
}
@end

@implementation LHStoredGlucoseRequest
+(LHStoredGlucoseRequest*)fromMap:(NSDictionary*)dict {
  LHStoredGlucoseRequest* result = [[LHStoredGlucoseRequest alloc] init];
  result.startTimestamp = dict[@"startTimestamp"];
  if ((NSNull *)result.startTimestamp == [NSNull null]) {
    result.startTimestamp = nil;
  }
  result.endTimestamp = dict[@"endTimestamp"];
  if ((NSNull *)result.endTimestamp == [NSNull null]) {
    result.endTimestamp = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.startTimestamp ? self.startTimestamp : [NSNull null]), @"startTimestamp", (self.endTimestamp ? self.endTimestamp : [NSNull null]), @"endTimestamp", nil];
}
@end

@interface LHCallbackApi ()
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger>* binaryMessenger;
@end

@implementation LHCallbackApi
- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger>*)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}

- (void)newSample:(LHStoredGlucoseSample*)input completion:(void(^)(NSError* _Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.CallbackApi.newSample"
      binaryMessenger:self.binaryMessenger];
  NSDictionary* inputMap = [input toMap];
  [channel sendMessage:inputMap reply:^(id reply) {
    completion(nil);
  }];
}
@end
void LHApiSetup(id<FlutterBinaryMessenger> binaryMessenger, id<LHApi> api) {
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.Api.listenForHealthData"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api listenForHealthData:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.Api.getGlucoseSamples"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        LHStoredGlucoseRequest *input = [LHStoredGlucoseRequest fromMap:message];
        [api getGlucoseSamples:input completion:^(LHStoredGlucoseResponse *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult([output toMap], error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
