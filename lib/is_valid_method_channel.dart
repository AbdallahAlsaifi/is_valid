import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'is_valid_platform_interface.dart';

/// An implementation of [IsValidPlatform] that uses method channels.
class MethodChannelIsValid extends IsValidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('is_valid');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
