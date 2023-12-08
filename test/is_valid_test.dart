import 'package:flutter_test/flutter_test.dart';
import 'package:is_valid/is_valid_platform_interface.dart';
import 'package:is_valid/is_valid_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIsValidPlatform
    with MockPlatformInterfaceMixin
    implements IsValidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IsValidPlatform initialPlatform = IsValidPlatform.instance;

  test('$MethodChannelIsValid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIsValid>());
  });

  // test('getPlatformVersion', () async {
  //   IsValid isValidPlugin = IsValid();
  //   MockIsValidPlatform fakePlatform = MockIsValidPlatform();
  //   IsValidPlatform.instance = fakePlatform;
  //
  //   expect(await isValidPlugin.getPlatformVersion(), '42');
  // });
}
