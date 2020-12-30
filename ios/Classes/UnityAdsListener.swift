
import Flutter
import UnityAds


public class UnityAdsListener: NSObject, UnityAdsDelegate{

    private var placementChannels: [String: FlutterMethodChannel ] = [String : FlutterMethodChannel]()
    private let defaultChannel: FlutterMethodChannel
    private let mMesseneger: FlutterBinaryMessenger

    init (channel:FlutterMethodChannel, messager:FlutterBinaryMessenger){
        self.defaultChannel = channel
        self.mMesseneger = messager
    }

    public func unityAdsReady(_ placementId: String) {
        onReady(placementId:placementId)
    }

    public func unityAdsDidError(_ error: UnityAdsError, withMessage message: String) {
        onError ("",error:error,errorMessage: message )
    }

    public func unityAdsDidStart(_ placementId: String) {
        onStarted(placementId:placementId)
    }

    public func unityAdsDidFinish(_ placementId: String, with state: UnityAdsFinishState) {
    if(state == UnityAdsFinishState.skipped) {
        onSkipped(placementId:placementId)
    } else if (state == UnityAdsFinishState.completed) {
        onCompleted(placementId:placementId)
    } else if (state == UnityAdsFinishState.error) {
         onError(placementId, error: nil, errorMessage:"")
    }


    }


    func onReady(placementId: String) {
    let arguments = [
    UnityAdsConstants.PLACEMENT_ID_PARAMETER: placementId
    ]
    invokeMethod(UnityAdsConstants.READY_METHOD,args:  arguments, placementId:placementId);
    }
    func onStarted(placementId: String) {
     let arguments = [
        UnityAdsConstants.PLACEMENT_ID_PARAMETER: placementId
        ]
        invokeMethod(UnityAdsConstants.START_METHOD,args: arguments, placementId:placementId);
    }
    func onCompleted(placementId: String) {
         let arguments = [
            UnityAdsConstants.PLACEMENT_ID_PARAMETER: placementId
            ]
            invokeMethod(UnityAdsConstants.COMPLETE_METHOD,args: arguments, placementId:placementId);
    }
    func onSkipped(placementId: String) {
         let arguments = [
                    UnityAdsConstants.PLACEMENT_ID_PARAMETER: placementId
                    ]
                    invokeMethod(UnityAdsConstants.SKIPPED_METHOD,args:  arguments,placementId: placementId);
    }
    func onError(_ placementId: String, error:UnityAdsError?, errorMessage: String?) {

        var arguments = [String: Any] ()


               arguments[UnityAdsConstants.PLACEMENT_ID_PARAMETER] = placementId

         if (error != nil) {
            arguments["errorCode"] = String(describing: error)
        }
        if (errorMessage != nil) {
            arguments["errorMessage"] = errorMessage
        }
        invokeMethod( UnityAdsConstants.ERROR_METHOD,args: arguments,placementId: placementId);


    }


    func invokeMethod(_ methodName: String, args: [String: Any],placementId:String){
        self.defaultChannel.invokeMethod(methodName,arguments: args);

        findChannel(placementId).invokeMethod(methodName,arguments: args)

    }

    func findChannel (_ placementId: String) -> FlutterMethodChannel {
    if(placementChannels.index(forKey: placementId) == nil){
    placementChannels[placementId] = FlutterMethodChannel(name: UnityAdsConstants.VIDEO_AD_CHANNEL + "_" + placementId,binaryMessenger: mMesseneger)
        }
    return placementChannels[placementId]!
    }


}