import UnityAds
import Flutter

public class BannerAdListener: NSObject,UADSBannerViewDelegate {
    private let mChannel: FlutterMethodChannel


    init(channel: FlutterMethodChannel) {
        self.mChannel = channel
    }


    public func bannerViewDidLoad (_ bannerView: UADSBannerView) {

      self.mChannel.invokeMethod(UnityAdsConstants.BANNER_LOADED_METHOD, arguments: bannerView.placementId);
    }
    public  func bannerViewDidClick (_ bannerView: UADSBannerView) {
          self.mChannel.invokeMethod(UnityAdsConstants.BANNER_CLICKED_METHOD, arguments: bannerView.placementId);

    }
    public func bannerViewDidLeaveApplication (_ bannerView: UADSBannerView) {

    }
   public func bannerViewDidError (_ bannerView: UADSBannerView, error:UADSBannerError) {
     self.mChannel.invokeMethod(UnityAdsConstants.BANNER_ERROR_METHOD, arguments:"");
    }
}