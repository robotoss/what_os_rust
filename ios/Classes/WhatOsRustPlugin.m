#import "WhatOsRustPlugin.h"
#if __has_include(<what_os_rust/what_os_rust-Swift.h>)
#import <what_os_rust/what_os_rust-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "what_os_rust-Swift.h"
#endif

@implementation WhatOsRustPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWhatOsRustPlugin registerWithRegistrar:registrar];
}
@end
