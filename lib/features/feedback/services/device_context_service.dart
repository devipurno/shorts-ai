import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final deviceContextServiceProvider = Provider<DeviceContextService>((ref) {
  return DeviceContextService();
});

class DeviceContextService {
  DeviceContextService({
    DeviceInfoPlugin? deviceInfo,
    Future<PackageInfo> Function()? packageInfoLoader,
  })  : _deviceInfo = deviceInfo ?? DeviceInfoPlugin(),
        _packageInfoLoader = packageInfoLoader ?? PackageInfo.fromPlatform;

  final DeviceInfoPlugin _deviceInfo;
  final Future<PackageInfo> Function() _packageInfoLoader;

  Future<Map<String, String>> collect() async {
    final packageInfo = await _packageInfoLoader();
    final appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';

    if (kIsWeb) {
      final info = await _deviceInfo.webBrowserInfo;
      return {
        'appVersion': appVersion,
        'platform': 'web',
        'deviceModel': info.browserName.name,
        'osVersion': info.platform ?? 'web',
      };
    }

    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return {
        'appVersion': appVersion,
        'platform': 'android',
        'deviceModel': '${info.manufacturer} ${info.model}'.trim(),
        'osVersion':
            'Android ${info.version.release} (SDK ${info.version.sdkInt})',
      };
    }

    if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return {
        'appVersion': appVersion,
        'platform': 'ios',
        'deviceModel': info.utsname.machine,
        'osVersion': '${info.systemName} ${info.systemVersion}',
      };
    }

    return {
      'appVersion': appVersion,
      'platform': Platform.operatingSystem,
      'deviceModel': Platform.localHostname,
      'osVersion': Platform.operatingSystemVersion,
    };
  }
}
