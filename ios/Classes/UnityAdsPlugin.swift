import Flutter
import UnityAds

public class UnityAdsPlugin:NSObject,FlutterPlugin {

    let mChannel: FlutterMethodChannel;
    var mViewController: UIViewController?;
    private var mMesseneger: FlutterBinaryMessenger
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: UnityAdsConstants.MAIN_CHANNEL, binaryMessenger: registrar.messenger())
        let instance = UnityAdsPlugin(methodChannel: channel, mMesseneger:registrar.messenger());

        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.register(
                BannerFactory(messeneger: registrar.messenger()),
                withId: UnityAdsConstants.BANNER_AD_CHANNEL
            )
    }


    init(methodChannel: FlutterMethodChannel, mMesseneger: FlutterBinaryMessenger){
        self.mViewController = nil
        self.mChannel  = methodChannel
        self.mMesseneger = mMesseneger
    }

     public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var args: Dictionary<String,Any> = [:];
        if call.arguments != nil{
            args = (call.arguments as! NSDictionary) as! Dictionary<String,Any>
        }


             if(call.method == UnityAdsConstants.INIT_METHOD) {
                result(initialize(args: args))
             } else if (call.method == UnityAdsConstants.IS_READY_METHOD) {

             } else if (call.method == UnityAdsConstants.SHOW_VIDEO_METHOD) {

             }

      }

     func initialize (args: [String : Any])  -> Bool {
        let gameId:String = args[UnityAdsConstants.GAME_ID_PARAMETER] as! String
        let testMode:Bool = args[UnityAdsConstants.TEST_MODE_PARAMETER] as! Bool


         UnityAds.initialize(gameId,testMode: testMode)
         UnityAds.add(UnityAdsListener(channel: mChannel, messager:mMesseneger))
         return true

     }

     func isReady (args: [String : Any]) -> Bool {
        return true
     }



}