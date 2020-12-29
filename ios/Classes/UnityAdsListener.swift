
import Flutter
import UIKit
import UnityAds


public class UnityAdsListener: NSObject, FlutterPlugin,UnityAdsDelegate{

    private var placementChannels: [String: FlutterMethodChannel ] = [String : FlutterMethodChannel]()
    private let defaultChannel: FlutterMethodChannel
    private let mMesseneger: FlutterBinaryMessenger

    init (channel:FlutterMethodChannel, messager:FlutterBinaryMessenger){
        self.defaultChannel = channel
        self.mMesseneger = messager
    }

    public func unityAdsReady(_ placementId: String) {

    }

    public func unityAdsDidError(_ error: UnityAdsError, withMessage message: String) {

    }

    public func unityAdsDidStart(_ placementId: String) {
    }

    public func unityAdsDidFinish(_ placementId: String, with state: UnityAdsFinishState) {

    }


    func onReady(placementId: String) {
    let arguments = [
    UnityAdsConstants.PLACEMENT_ID_PARAMETER: placementId
    ]
    invokeMethod(UnityAdsConstants.READY_METHOD, arguments, placementId);
    }
    func onStarted(placementId: String) {
     let arguments = [
        UnityAdsConstants.PLACEMENT_ID_PARAMETER: placementId
        ]
        invokeMethod(UnityAdsConstants.START_METHOD, arguments, placementId);
    }
    func onCompleted(placementId: String) {
         let arguments = [
            UnityAdsConstants.PLACEMENT_ID_PARAMETER: placementId
            ]
            invokeMethod(UnityAdsConstants.COMPLETE_METHOD, arguments, placementId);
    }
    func onSkipped(placementId: String) {
         let arguments = [
                    UnityAdsConstants.PLACEMENT_ID_PARAMETER: placementId
                    ]
                    invokeMethod(UnityAdsConstants.SKIPPED_METHOD, arguments, placementId);
    }
    func onError(_ placementId: String, error:UnityAdsError, errorMessage: String) {

        let arguments = [String: Any] ()
        if (placementId != nil) {
            arguments[UnityAdsConstants.PLACEMENT_ID_PARAMETER] = placementId
        }
         if (error != nil) {
            arguments["errorCode"] = String(describing: error)
        }
        if (errorMessage != nil) {
            arguments["errorMessage"] = errorMessage
        }
        invokeMethod(UnityAdsConstants.ERROR_METHOD, arguments, placementId);


    }


    func invokeMethod(_ methodName: String, args: [String: Any], String placementId){
        self.defaultChannel.invokeMethod(methodName, args);
        if(placementId != nil){
            findChannel(placementId).invokeMethod(methodName, args)
        }
    }

    func findChannel (placementId: String) -> FlutterMethodChannel {
        if(placementChannels[placementId] != nil) {
            return placementChannels[placementId]
        } else {
            return FlutterMethodChannel(name: UnityAdsConstants.VIDEO_AD_CHANNEL + "_" + placementId,binaryMessenger: mMesseneger)
        }

    }
}