import 'package:flutter/material.dart';

import 'package:get/get.dart';

class KategoriBahasaView extends GetView {
  const KategoriBahasaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KategoriBahasaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KategoriBahasaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
