#import "UnityAdsPlugin.h"
#import "UnityAdsPluginImpl-Swift.h"

@implementation UnityAdsPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [UnityAdsPluginImpl registerWithRegistrar:registrar];
}

@end
