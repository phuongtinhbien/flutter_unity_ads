import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/ad/unity_banner_ad.dart';
import 'package:unity_ads_plugin/unity_ads.dart';

void main() {
  runApp(UnityAdsExampleApp());
}

class UnityAdsExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unity Ads Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Unity Ads Example'),
        ),
        body: UnityAdsExample(),
      ),
    );
  }
}

class UnityAdsExample extends StatefulWidget {
  @override
  _UnityAdsExampleState createState() => _UnityAdsExampleState();
}

class _UnityAdsExampleState extends State<UnityAdsExample> {
  bool _showBanner = false;

  @override
  void initState() {
    super.initState();

    UnityAds.init(
      gameId: AdManager.gameId,
      testMode: true,
      listener: (state, args) => print('Init Listener: $state => $args'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _showBanner = !_showBanner;
                  });
                },
                child: Text(_showBanner ? 'Hide Banner' : 'Show Banner'),
              ),
              RaisedButton(
                onPressed: () {
                  UnityAds.showVideoAd(
                    placementId: AdManager.rewardedVideoAdPlacementId,
                    listener: (state, args) =>
                        print('Rewarded Video Listener: $state => $args'),
                  );
                },
                child: Text('Show Rewarded Video'),
              ),
              RaisedButton(
                onPressed: () {
                  UnityAds.showVideoAd(
                    placementId: AdManager.interstitialVideoAdPlacementId,
                    listener: (state, args) =>
                        print('Interstitial Video Listener: $state => $args'),
                  );
                },
                child: Text('Show Interstitial Video'),
              ),
            ],
          ),
          if (_showBanner)
            UnityBannerAd(
              placementId: AdManager.bannerAdPlacementId,
              listener: (state, args) {
                print('Banner Listener: $state => $args');
              },
            ),
        ],
      ),
    );
  }
}

class AdManager {
  static String get gameId {
    if (Platform.isAndroid) {
      return '3954207';
    }
    if (Platform.isIOS) {
      return '3954206';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdPlacementId {
    return 'banner_placement';
  }

  static String get interstitialVideoAdPlacementId {
    return 'video';
  }

  static String get rewardedVideoAdPlacementId {
    return 'rewardedVideo';
  }
}
