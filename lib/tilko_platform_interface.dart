import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tilko_method_channel.dart';

abstract class TilkoPlatform extends PlatformInterface {
  /// Constructs a TilkoPlatform.
  TilkoPlatform() : super(token: _token);

  static final Object _token = Object();

  static TilkoPlatform _instance = MethodChannelTilko();

  /// The default instance of [TilkoPlatform] to use.
  ///
  /// Defaults to [MethodChannelTilko].
  static TilkoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TilkoPlatform] when
  /// they register themselves.
  static set instance(TilkoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
