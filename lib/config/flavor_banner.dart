import "dart:io";
import "package:device_info_plus/device_info_plus.dart";
import "package:flutter/material.dart";
import "package:my_app/config/environment.dart";

// Flavor Banner. Displays running flavor (dev or stage, not prod)
// show information about device
// add qa screen?
class FlavorBanner extends StatelessWidget {
  final Widget child;

  const FlavorBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (env.appNamePostfix == "PROD") return child;

    return Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[child, const _BannerWidget()],
    );
  }
}

class _BannerWidget extends StatelessWidget {
  const _BannerWidget();

  @override
  Widget build(BuildContext context) {
    final BannerConfig config = BannerConfig(bannerName: env.appNamePostfix);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const _DeviseInfoDialog();
          },
        );
      },
      child: SizedBox(
        width: 75,
        height: 75,
        child: CustomPaint(
          painter: BannerPainter(
            message: config.bannerName,
            textDirection: Directionality.of(context),
            layoutDirection: Directionality.of(context),
            location: BannerLocation.topStart,
            color: config.getBannerColor(),
          ),
        ),
      ),
    );
  }
}

class BannerConfig {
  final String bannerName;
  BannerConfig({required this.bannerName});

  Color getBannerColor() {
    if (bannerName == "DEV") {
      return Colors.green;
    } else if (bannerName == "STAGE") {
      return Colors.amber;
    }
    {
      return Colors.transparent;
    }
  }
}

class _DeviseInfoDialog extends StatelessWidget {
  const _DeviseInfoDialog();

  @override
  Widget build(BuildContext context) {
    final BannerConfig config = BannerConfig(bannerName: env.appNamePostfix);
    return AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 10.0),
      title: Container(
        padding: const EdgeInsets.all(15.0),
        color: config.getBannerColor(),
        child: const Text(
          "Info",
          style: TextStyle(color: Colors.white),
        ),
      ),
      titlePadding: EdgeInsets.zero,
      content: _getContent(),
    );
  }

  Widget _getContent() {
    if (Platform.isAndroid) {
      return _androidContent();
    }
    if (Platform.isIOS) {
      return _iosContent();
    }
    return const Text("not ios or android device");
  }

  Widget _androidContent() {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return FutureBuilder<AndroidDeviceInfo>(
      future: deviceInfo.androidInfo,
      builder:
          (BuildContext context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        final AndroidDeviceInfo? device = snapshot.data;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _TileWidget(
                name: "Flavor:",
                value: env.appNamePostfix,
              ),
              _TileWidget(
                name: "Physical device?:",
                value: "${device?.isPhysicalDevice}",
              ),
              _TileWidget(
                name: "Manufacturer:",
                value: "${device?.manufacturer}",
              ),
              _TileWidget(
                name: "Model:",
                value: "${device?.model}",
              ),
              _TileWidget(
                name: "Android version:",
                value: "${device?.version.release}",
              ),
              _TileWidget(
                name: "Android SDK:",
                value: "${device?.version.sdkInt}",
              )
            ],
          ),
        );
      },
    );
  }

  Widget _iosContent() {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return FutureBuilder<IosDeviceInfo>(
      future: deviceInfo.iosInfo,
      builder: (BuildContext context, AsyncSnapshot<IosDeviceInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        final IosDeviceInfo? device = snapshot.data;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _TileWidget(name: "Flavor:", value: env.appNamePostfix),
              _TileWidget(
                name: "Physical device?:",
                value: "${device?.isPhysicalDevice}",
              ),
              _TileWidget(name: "Model:", value: "${device?.model}"),
              _TileWidget(
                name: "system version:",
                value: "${device?.systemVersion}",
              ),
              _TileWidget(
                name: "Device name:",
                value: "${device?.name}",
              ),
              _TileWidget(
                name: "Id vendor:",
                value: "${device?.identifierForVendor}",
              )
            ],
          ),
        );
      },
    );
  }
}

class _TileWidget extends StatelessWidget {
  const _TileWidget({required this.name, required this.value});
  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
