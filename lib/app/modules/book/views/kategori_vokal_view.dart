// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:veryzona/app/modules/book/controllers/book_controller.dart';

class KategoriVokalView extends GetView {
  const KategoriVokalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.find<BookController>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'สระไทย',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Sara Thai/ Vokal Thai mempunya 32 jumlah secara total namun ada beberapa tambahan di aplikasi ini yang menjadi 40 total.',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 20),
            GetX<BookController>(
              builder: (controller) => GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.vokalList.length,
                itemBuilder: (context, index) {
                  final aksara = controller.vokalList[index];
                  return InkWell(
                    onTap: () => controller.showAksaraDetail(context, aksara),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          aksara['aksara']!,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
