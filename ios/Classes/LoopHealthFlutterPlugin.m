#import "LoopHealthFlutterPlugin.h"
#if __has_include(<loop_health_flutter/loop_health_flutter-Swift.h>)
#import <loop_health_flutter/loop_health_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "loop_health_flutter-Swift.h"
#endif

@implementation LoopHealthFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLoopHealthFlutterPlugin registerWithRegistrar:registrar];
}
@end
