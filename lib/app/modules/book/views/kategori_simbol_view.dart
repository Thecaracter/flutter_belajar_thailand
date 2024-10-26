import 'package:flutter/material.dart';

import 'package:get/get.dart';

class KategoriSimbolView extends GetView {
  const KategoriSimbolView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KategoriSimbolView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KategoriSimbolView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
