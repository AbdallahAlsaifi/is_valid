import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'is_valid_method_channel.dart';

abstract class IsValidPlatform extends PlatformInterface {
  /// Constructs a IsValidPlatform.
  IsValidPlatform() : super(token: _token);

  static final Object _token = Object();

  static IsValidPlatform _instance = MethodChannelIsValid();

  /// The default instance of [IsValidPlatform] to use.
  ///
  /// Defaults to [MethodChannelIsValid].
  static IsValidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IsValidPlatform] when
  /// they register themselves.
  static set instance(IsValidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
