import 'package:flutter/material.dart';

import 'package:get/get.dart';

class KategoriBudayaView extends GetView {
  const KategoriBudayaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KategoriBudayaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KategoriBudayaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
