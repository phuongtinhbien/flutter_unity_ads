public class UnityAdsPlugin:FlutterPlugin {

    let mChannel: FlutterMethodChannel;
    var mViewController: UIViewController?;
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: UnityAdsConstants.MAIN_CHANNEL, binaryMessenger: registrar.messenger())
        let instance = UnityAdsPlugin(methodChannel: channel);

        registrar.addMethodCallDelegate(instance, channel: channel)
         registrar.register(
                BannerFactory(messeneger: registrar.messenger()),
                withId: UnityAdsConstants.BANNER_AD_CHANNEL
            )
    }


    init(methodChannel: FlutterMethodChannel){
        self.mViewController = nil;
        self.mChannel  = methodChannel;
    }

     public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var args: Dictionary<String,Any> = [:];
        if call.arguments != nil{
            args = (call.arguments as! NSDictionary) as! Dictionary<String,Any>
        }
            if (call.method == UnityAdsConstants.INIT_METHOD) {
                result(UnityAds.getDebugMode());
            } else if(call.method == "getDefaultPlacementState") {
                result(UnityAds.getPlacementState().rawValue);
            } else if(call.method == "getPlacementState" && args["placementId"] != nil) {
                result(UnityAds.getPlacementState(args["placementId"] as! String).rawValue);
            } else if(call.method == "getVersion"){
                result(UnityAds.getVersion());
            } else if(call.method == "initialize" && args["gameId"] != nil && args["testMode"] != nil){
                UnityAds.initialize(args["gameId"] as! String, delegate: self, testMode: args["testMode"] as! Bool)
                result(nil);


             if(call.method == UnityAdsConstants.INIT_METHOD) {
                result(initialize(args))
             } else if (call.method == UnityAdsConstants.IS_READY_METHOD) {

             } else if (call.method == UnityAdsConstants.SHOW_VIDEO_METHOD) {

             }

      }

     func initialize (args: [:])  -> Bool {
        var gameId = args[UnityAdsConstants.GAME_ID_PARAMETER] as String
        var testMode = args[UnityAdsConstants.TEST_MODE_PARAMETER] as Bool

        if(testMode == nil){
           testMode = false
        }

         UnityAds.initialize(gameId,testMode )

         return true

     }

     func isReady (args: [:]) -> Bool {

     }



}