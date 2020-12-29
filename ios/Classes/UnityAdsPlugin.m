#import "UnityAdsPlugin.h"
#import <unity_ads_plugin/unity_ads_plugin-Swift.h>

@implementation UnityAdsPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [UnityAdsPluginImpl registerWithRegistrar:registrar];
}

@end
