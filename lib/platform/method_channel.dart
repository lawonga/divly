import 'package:flutter/services.dart';

abstract class PlatformSpecific {
  MethodChannel getMethodChannel();
}
