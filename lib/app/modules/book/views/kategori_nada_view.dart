// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/book/controllers/book_controller.dart';

class KategoriNadaView extends GetView<BookController> {
  const KategoriNadaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'วรรณยุกต์',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              'wannayuk / Nada Thai mempunyai 4 tanda nada dan 5 bunyi\nnada dalam sistem bahasa Thai.',
              style:
                  TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
            ),
            SizedBox(height: 20),
            Text(
              'รูปวรรณยุกต์',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              'ruup wannayuk / tanda nada',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            SizedBox(height: 8),
            GetX<BookController>(
              builder: (controller) => GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.9,
                ),
                itemCount: controller.toneMarksList.length,
                itemBuilder: (context, index) {
                  final tone = controller.toneMarksList[index];
                  return InkWell(
                    onTap: () => controller.showToneDetail(context, tone),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tone['symbol']!,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              tone['description']!,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'เสียงวรรณยุกต์',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              'siiang wannayuk / bunyi nada',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            SizedBox(height: 8),
            GetX<BookController>(
              builder: (controller) => Column(
                children: List.generate(
                  controller.toneSoundsList.length,
                  (index) {
                    final toneSound = controller.toneSoundsList[index];
                    return InkWell(
                      onTap: () =>
                          controller.showToneSoundDetail(context, toneSound),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                toneSound['symbol']!,
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      toneSound['character']!,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      toneSound['description']!,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
