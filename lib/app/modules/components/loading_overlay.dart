import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingOverlay {
  static OverlayEntry? _overlay;

  static void show({
    required BuildContext context,
    required String lottieAsset,
    double opacity = 0.5,
  }) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) => Material(
          color: Colors.white.withOpacity(0.81),
          child: Center(
            child: Lottie.asset(
              lottieAsset,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
      Overlay.of(context).insert(_overlay!);
    }
  }

  static void hide() {
    _overlay?.remove();
    _overlay = null;
  }
}
