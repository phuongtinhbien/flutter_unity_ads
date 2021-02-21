import UnityAds
import Flutter


class UnityBanner : NSObject, FlutterPlatformView {

    private let channel: FlutterMethodChannel
    private let messeneger: FlutterBinaryMessenger
    private let frame: CGRect
    private let viewId: Int64
    private let args: [String: Any]
    private var bannerView: UADSBannerView?
    private var mViewController: UIViewController?;

    init(frame: CGRect, viewId: Int64, args: [String: Any], messeneger: FlutterBinaryMessenger) {
        self.args = args
        self.messeneger = messeneger
        self.frame = frame
        self.viewId = viewId
        self.channel = FlutterMethodChannel(name: UnityAdsConstants.BANNER_AD_CHANNEL + "_" + String(viewId), binaryMessenger: messeneger)

    }

    func view() -> UIView {
        let size = CGSize(width: 320, height: 50)
        if (
        bannerView = UADSBannerView(placementId: args[UnityAdsConstants.PLACEMENT_ID_PARAMETER] as! String, size:size)
        bannerView?.frame = CGRect(x: 0, y: 0, width: 320, height: 50.0)
        channel.setMethodCallHandler { [weak self] (flutterMethodCall: FlutterMethodCall, flutterResult: FlutterResult) in
                switch flutterMethodCall.method {
                case UnityAdsConstants.BANNER_SET_LISTENER:
                    self?.bannerView?.delegate = self
                case "dispose":
                    self?.dispose()
                default:
                    flutterResult(FlutterMethodNotImplemented)
                }
            }
        bannerView?.load()
        return bannerView!
    }

      private func dispose() {
            bannerView?.removeFromSuperview()
            bannerView = nil
            channel.setMethodCallHandler(nil)
        }


}

extension UnityBanner: UADSBannerViewDelegate {

    public func bannerViewDidLoad (_ bannerView: UADSBannerView) {
     channel.invokeMethod(UnityAdsConstants.BANNER_LOADED_METHOD, arguments: bannerView.placementId);
    }
    public  func bannerViewDidClick (_ bannerView: UADSBannerView) {
         channel.invokeMethod(UnityAdsConstants.BANNER_CLICKED_METHOD, arguments: bannerView.placementId);
    }
    public func bannerViewDidLeaveApplication (_ bannerView: UADSBannerView) {
    }
   public func bannerViewDidError (_ bannerView: UADSBannerView, error:UADSBannerError) {
     channel.invokeMethod(UnityAdsConstants.BANNER_ERROR_METHOD, arguments: bannerView.placementId);
    }

    }
