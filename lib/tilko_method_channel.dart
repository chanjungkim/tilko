import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tilko_platform_interface.dart';

/// An implementation of [TilkoPlatform] that uses method channels.
class MethodChannelTilko extends TilkoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tilko');
}
