
import UnityAds

public class BannerAdListener: NSObject,UADSBannerViewDelegate {
    private let mChannel: FlutterMethodChannel

    init(channel: FlutterMethodChannel) {
    self.mChannel = channel
    }


    func bannerViewDidLoad (_ bannerView: UADSBannerView) {

      self.mChannel.invokeMethod(UnityAdsConstants.BANNER_LOADED_METHOD, arguments: placementId);
    }
    func bannerViewDidClick (_ bannerView: UADSBannerView) {
          self.mChannel.invokeMethod(UnityAdsConstants.BANNER_CLICKED_METHOD, arguments: placementId);

    }
    func bannerViewDidLeaveApplication (_ bannerView: UADSBannerView) {

    }
    func bannerViewDidError (_ bannerView: UADSBannerView, error:UADSBannerError) {
     self.mChannel.invokeMethod(UnityAdsConstants.BANNER_ERROR_METHOD,);
    }
}