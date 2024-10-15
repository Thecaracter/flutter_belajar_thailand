// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingOverlay {
  static OverlayEntry? _overlay;

  static void show({
    required BuildContext context,
    required String lottieAsset,
    String? text,
    double opacity = 0.8,
    double? width,
    double? height,
    TextStyle? textStyle,
    BoxDecoration? containerDecoration,
    double borderRadius = 10,
  }) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) => Material(
          color: Colors.black.withOpacity(opacity),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  lottieAsset,
                  width: width ?? MediaQuery.of(context).size.width * 0.5,
                  height: height ?? MediaQuery.of(context).size.width * 0.5,
                  fit: BoxFit.contain,
                ),
                if (text != null) ...[
                  SizedBox(height: 20),
                  Container(
                    width: width ?? MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: containerDecoration ??
                        BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                    child: Text(
                      text,
                      style: textStyle ??
                          TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
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
