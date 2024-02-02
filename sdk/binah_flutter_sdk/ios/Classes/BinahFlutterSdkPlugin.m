#import "BinahFlutterSdkPlugin.h"
#if __has_include(<binah_flutter_sdk/binah_flutter_sdk-Swift.h>)
#import <binah_flutter_sdk/binah_flutter_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "binah_flutter_sdk-Swift.h"
#endif

@implementation BinahFlutterSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBinahFlutterSdkPlugin registerWithRegistrar:registrar];
}
@end
