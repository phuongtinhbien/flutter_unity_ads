


class UnityBanner : NSObject, FlutterPlatformView {

    private let channel: FlutterMethodChannel
    private let messeneger: FlutterBinaryMessenger
    private let frame: CGRect
    private let viewId: Int64
    private let args: [String: Any]
    private var bannerView: UADSBannerView?

    init(frame: CGRect, viewId: Int64, args: [String: Any], messeneger: FlutterBinaryMessenger) {
        self.args = args
        self.messeneger = messeneger
        self.frame = frame
        self.viewId = viewId
        channel = FlutterMethodChannel(name: UnityAdsConstants.BANNER_AD_CHANNEL + "_" + viewId, binaryMessenger: messeneger)

        let width = args.get(UnityAdsConstants.WIDTH_PARAMETER) as Int
        let height = args.get(UnityAdsConstants.HEIGHT_PARAMETER) as Int

        let size = CGSize(width: 320, height: 50)
        bannerView = UADSBannerView(placementId: args[UnityAdsConstants.PLACEMENT_ID_PARAMETER] as String!, size)
        bannerView(BannerAdListener(channel))
        bannerView.load();
    }

    func view() -> UIView {
        return bannerView
    }






}