// File: lib/app/services/connectivity_service.dart

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/components/loading_overlay.dart';
import 'package:veryzona/app/modules/utils/constant_color.dart';

class ConnectivityService extends GetxService {
  final _connectivity = Connectivity();
  final RxList<ConnectivityResult> connectionStatus =
      <ConnectivityResult>[].obs;
  bool _isOverlayShown = false;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<ConnectivityService> init() async {
    await _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    return this;
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      print('Couldn\'t check connectivity status: $e');
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    connectionStatus.value = result;
    print('Connectivity status: $result');

    if (!result.contains(ConnectivityResult.wifi) &&
        !result.contains(ConnectivityResult.mobile) &&
        !result.contains(ConnectivityResult.ethernet)) {
      // No connection
      if (!_isOverlayShown) {
        LoadingOverlay.show(
          context: Get.overlayContext!,
          lottieAsset: 'assets/animation/no-connection.json',
          text: 'Tidak ada koneksi internet',
          containerDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ConstanColor.primaryColor, ConstanColor.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
        _isOverlayShown = true;
      }
    } else {
      // Connection restored
      if (_isOverlayShown) {
        LoadingOverlay.hide();
        _isOverlayShown = false;
      }
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
