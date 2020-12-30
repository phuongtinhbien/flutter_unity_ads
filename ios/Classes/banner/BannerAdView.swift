import UnityAds
import Flutter


class UnityBanner : NSObject, FlutterPlatformView {

    private let channel: FlutterMethodChannel
    private let messeneger: FlutterBinaryMessenger
    private let frame: CGRect
    private let viewId: Int64
    private let args: [String: Any]
    private var bannerView: UADSBannerView
    private var mViewController: UIViewController?;

    init(frame: CGRect, viewId: Int64, args: [String: Any], messeneger: FlutterBinaryMessenger) {
        self.args = args
        self.messeneger = messeneger
        self.frame = frame
        self.viewId = viewId
        channel = FlutterMethodChannel(name: UnityAdsConstants.BANNER_AD_CHANNEL + "_" + String(describing: args[UnityAdsConstants.PLACEMENT_ID_PARAMETER]), binaryMessenger: messeneger)
        if self.mViewController == nil {
            self.mViewController = (UIApplication.shared.keyWindow?.rootViewController)!;
        }

        let size = CGSize(width: 320, height: 50)

        bannerView = UADSBannerView(placementId: args[UnityAdsConstants.PLACEMENT_ID_PARAMETER] as! String, size:size)
        bannerView.delegate = BannerAdListener(channel:channel)
        bannerView.load()

    }

    func view() -> UIView {
        return bannerView
    }






}