// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class KategoriAngkaView extends GetView {
  const KategoriAngkaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'จำนวน',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'jam nuan / angka Thai mempunya 10 tanda',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                _buildNumberCard("๑", "/neung/", "หนึ่ง", "satu", "1"),
                _buildNumberCard("๒", "/soong/", "สอง", "dua", "2"),
                _buildNumberCard("๓", "/saam/", "สาม", "tiga", "3"),
                _buildNumberCard("๔", "/sii/", "สี่", "empat", "4"),
                _buildNumberCard("๕", "/hok/", "หก", "enam", "6"),
                _buildNumberCard("๗", "/jet/", "เจ็ด", "tujuh", "7"),
                _buildNumberCard("๘", "/paet/", "แปด", "delapan", "8"),
                _buildNumberCard("๙", "/kao/", "เก้า", "sembilan", "9"),
                _buildNumberCard("0", "/hok/", "ศูนร์", "nol", "0"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberCard(String thaiNumber, String pronounce, String thaiWord,
      String meaning, String number) {
    return Container(
      width: 150,
      height: 100,
      child: Row(
        children: [
          // Bagian kiri (gelap)
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    thaiNumber,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    thaiWord,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    pronounce,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bagian kanan (terang)
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    number,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    meaning,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
