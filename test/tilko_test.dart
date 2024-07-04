import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tilko/tilko_method_channel.dart';
import 'package:tilko/tilko_platform_interface.dart';

class MockTilkoPlatform
    with MockPlatformInterfaceMixin
    implements TilkoPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TilkoPlatform initialPlatform = TilkoPlatform.instance;

  test('$MethodChannelTilko is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTilko>());
  });
}
