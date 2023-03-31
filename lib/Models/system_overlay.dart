import 'package:flutter/services.dart';

SystemUiOverlayStyle darkIconSystemOverlay() {
  return const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light, // For iOS (dark icons))
  );
}
