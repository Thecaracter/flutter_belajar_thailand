// ignore_for_file: prefer_const_constructors, unnecessary_overrides, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/data/model/kategoriclass_model.dart';
import 'package:veryzona/app/modules/book/views/kategori_angka_view.dart';
import 'package:veryzona/app/modules/book/views/kategori_konsonan_view.dart';
import 'package:veryzona/app/modules/book/views/kategori_nada_view.dart';
import 'package:veryzona/app/modules/book/views/kategori_simbol_view.dart';
import 'package:veryzona/app/modules/book/views/kategori_vokal_view.dart';
import 'package:veryzona/app/modules/utils/constant_color.dart';

class BookController extends GetxController {
  final RxList<KategoriClass> categories = [
    KategoriClass(nama: 'konsonan'),
    KategoriClass(nama: 'vokal'),
    KategoriClass(nama: 'nada'),
    KategoriClass(nama: 'angka'),
    KategoriClass(nama: 'simbol'),
  ].obs;

  final RxInt selectedCategoryIndex = 0.obs;
  final Rx<Widget> currentContent = Rx<Widget>(Container());

  void navigateToView(String category) {
    switch (category.toLowerCase()) {
      case 'konsonan':
        currentContent.value = KategoriKonsonanView();
        break;
      case 'vokal':
        currentContent.value = KategoriVokalView();
        break;
      case 'nada':
        currentContent.value = KategoriNadaView();
        break;
      case 'angka':
        currentContent.value = KategoriAngkaView();
        break;
      case 'simbol':
        currentContent.value = KategoriSimbolView();
        break;
      default:
        currentContent.value = Container(
          child: Center(
            child: Text(
              'Konten tidak tersedia',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    navigateToView(categories[index].nama);
  }

  final RxList<Map<String, String>> aksaraList = [
    {
      "aksara": "ก",
      "nama": "กอ ไก่",
      "pronounce": "ko kai",
      "detail":
          "Huruf pertama dalam alfabet Thai, dilafalkan seperti 'k' dalam 'kaki'"
    },
    {
      "aksara": "ข",
      "nama": "ขอ ไข่",
      "pronounce": "kho khai",
      "detail":
          "Huruf kedua dalam alfabet Thai, dilafalkan seperti 'k' dengan nafas"
    },
    {
      "aksara": "ฃ",
      "nama": "ฃอ ขวด",
      "pronounce": "kho khuat",
      "detail":
          "Huruf kuno yang sudah tidak digunakan lagi dalam bahasa Thai modern"
    },
    {
      "aksara": "ค",
      "nama": "คอ ควาย",
      "pronounce": "kho khwai",
      "detail": "Dilafalkan seperti 'k' dalam 'kopi'"
    },
    {
      "aksara": "ฅ",
      "nama": "ฅอ คน",
      "pronounce": "kho khon",
      "detail":
          "Huruf kuno yang sudah tidak digunakan lagi dalam bahasa Thai modern"
    },
    {
      "aksara": "ฆ",
      "nama": "ฆอ ระฆัง",
      "pronounce": "kho ra-khang",
      "detail": "Dilafalkan seperti 'k' dengan getaran"
    },
    {
      "aksara": "ง",
      "nama": "งอ งู",
      "pronounce": "ngo ngu",
      "detail": "Dilafalkan seperti 'ng' dalam 'ngilu'"
    },
    {
      "aksara": "จ",
      "nama": "จอ จาน",
      "pronounce": "cho chan",
      "detail": "Dilafalkan seperti 'j' dalam 'jalan'"
    },
    {
      "aksara": "ฉ",
      "nama": "ฉอ ฉิ่ง",
      "pronounce": "cho ching",
      "detail": "Dilafalkan seperti 'ch' dengan nafas"
    },
    {
      "aksara": "ช",
      "nama": "ชอ ช้าง",
      "pronounce": "cho chang",
      "detail": "Dilafalkan seperti 'ch' dalam 'chacha'"
    },
    {
      "aksara": "ซ",
      "nama": "ซอ โซ่",
      "pronounce": "so so",
      "detail": "Dilafalkan seperti 's' dalam 'saya'"
    },
    {
      "aksara": "ฌ",
      "nama": "ฌอ เฌอ",
      "pronounce": "cho choe",
      "detail": "Dilafalkan seperti 'ch' dengan getaran"
    },
    {
      "aksara": "ญ",
      "nama": "ญอ หญิง",
      "pronounce": "yo ying",
      "detail": "Dilafalkan seperti 'y' dalam 'yakin'"
    },
    {
      "aksara": "ฎ",
      "nama": "ฎอ ชฎา",
      "pronounce": "do cha-da",
      "detail": "Dilafalkan seperti 'd' dalam 'dada'"
    },
    {
      "aksara": "ฏ",
      "nama": "ฏอ ปฏัก",
      "pronounce": "to pa-tak",
      "detail": "Dilafalkan seperti 't' dalam 'tata'"
    },
    {
      "aksara": "ฐ",
      "nama": "ฐอ ฐาน",
      "pronounce": "tho than",
      "detail": "Dilafalkan seperti 'th' dengan nafas"
    },
    {
      "aksara": "ฑ",
      "nama": "ฑอ มณโฑ",
      "pronounce": "tho montho",
      "detail": "Dilafalkan seperti 'th' dengan getaran"
    },
    {
      "aksara": "ฒ",
      "nama": "ฒอ ผู้เฒ่า",
      "pronounce": "tho phu-thao",
      "detail": "Dilafalkan seperti 'th' dengan getaran"
    },
    {
      "aksara": "ณ",
      "nama": "ณอ เณร",
      "pronounce": "no nen",
      "detail": "Dilafalkan seperti 'n' dalam 'nanas'"
    },
    {
      "aksara": "ด",
      "nama": "ดอ เด็ก",
      "pronounce": "do dek",
      "detail": "Dilafalkan seperti 'd' dalam 'dada'"
    },
    {
      "aksara": "ต",
      "nama": "ตอ เต่า",
      "pronounce": "to tao",
      "detail": "Dilafalkan seperti 't' dalam 'tata'"
    },
    {
      "aksara": "ถ",
      "nama": "ถอ ถุง",
      "pronounce": "tho thung",
      "detail": "Dilafalkan seperti 'th' dengan nafas"
    },
    {
      "aksara": "ท",
      "nama": "ทอ ทหาร",
      "pronounce": "tho thahan",
      "detail": "Dilafalkan seperti 't' dalam 'tata'"
    },
    {
      "aksara": "ธ",
      "nama": "ธอ ธง",
      "pronounce": "tho thong",
      "detail": "Dilafalkan seperti 'th' dengan nafas"
    },
    {
      "aksara": "น",
      "nama": "นอ หนู",
      "pronounce": "no nu",
      "detail": "Dilafalkan seperti 'n' dalam 'nanas'"
    },
    {
      "aksara": "บ",
      "nama": "บอ ใบไม้",
      "pronounce": "bo bai-mai",
      "detail": "Dilafalkan seperti 'b' dalam 'babi'"
    },
    {
      "aksara": "ป",
      "nama": "ปอ ปลา",
      "pronounce": "po pla",
      "detail": "Dilafalkan seperti 'p' dalam 'padi'"
    },
    {
      "aksara": "ผ",
      "nama": "ผอ ผึ้ง",
      "pronounce": "pho phueng",
      "detail": "Dilafalkan seperti 'ph' dengan nafas"
    },
    {
      "aksara": "ฝ",
      "nama": "ฝอ ฝา",
      "pronounce": "fo fa",
      "detail": "Dilafalkan seperti 'f' dalam 'fajar'"
    },
    {
      "aksara": "พ",
      "nama": "พอ พาน",
      "pronounce": "pho phan",
      "detail": "Dilafalkan seperti 'p' dalam 'padi'"
    },
    {
      "aksara": "ฟ",
      "nama": "ฟอ ฟัน",
      "pronounce": "fo fan",
      "detail": "Dilafalkan seperti 'f' dalam 'fajar'"
    },
    {
      "aksara": "ภ",
      "nama": "ภอ สำเภา",
      "pronounce": "pho sam-phao",
      "detail": "Dilafalkan seperti 'ph' dengan nafas"
    },
    {
      "aksara": "ม",
      "nama": "มอ ม้า",
      "pronounce": "mo ma",
      "detail": "Dilafalkan seperti 'm' dalam 'mama'"
    },
    {
      "aksara": "ย",
      "nama": "ยอ ยักษ์",
      "pronounce": "yo yak",
      "detail": "Dilafalkan seperti 'y' dalam 'yoga'"
    },
    {
      "aksara": "ร",
      "nama": "รอ เรือ",
      "pronounce": "ro ruea",
      "detail": "Dilafalkan seperti 'r' dalam 'raja'"
    },
    {
      "aksara": "ล",
      "nama": "ลอ ลิง",
      "pronounce": "lo ling",
      "detail": "Dilafalkan seperti 'l' dalam 'lari'"
    },
    {
      "aksara": "ว",
      "nama": "วอ แหวน",
      "pronounce": "wo waen",
      "detail": "Dilafalkan seperti 'w' dalam 'warna'"
    },
    {
      "aksara": "ศ",
      "nama": "ศอ ศาลา",
      "pronounce": "so sala",
      "detail": "Dilafalkan seperti 's' dalam 'saya'"
    },
    {
      "aksara": "ษ",
      "nama": "ษอ ฤๅษี",
      "pronounce": "so rue-si",
      "detail": "Dilafalkan seperti 's' dalam 'saya'"
    },
    {
      "aksara": "ส",
      "nama": "สอ เสือ",
      "pronounce": "so suea",
      "detail": "Dilafalkan seperti 's' dalam 'saya'"
    },
    {
      "aksara": "ห",
      "nama": "หอ หีบ",
      "pronounce": "ho hip",
      "detail": "Dilafalkan seperti 'h' dalam 'hari'"
    },
    {
      "aksara": "ฬ",
      "nama": "ฬอ จุฬา",
      "pronounce": "lo chula",
      "detail": "Dilafalkan seperti 'l' dalam 'lari'"
    },
    {
      "aksara": "อ",
      "nama": "ออ อ่าง",
      "pronounce": "o ang",
      "detail": "Huruf vokal awal, dilafalkan seperti 'a' dalam 'ada'"
    },
    {
      "aksara": "ฮ",
      "nama": "ฮอ นกฮูก",
      "pronounce": "ho nok-huk",
      "detail": "Dilafalkan seperti 'h' dalam 'hari'"
    }
  ].obs;

  final RxList<Map<String, String>> vokalList = [
    {
      "aksara": "ะ",
      "nama": "สระอะ",
      "pronounce": "sara a",
      "detail": "Vokal pendek 'a', seperti dalam kata 'ada'"
    },
    {
      "aksara": "ิ",
      "nama": "สระอิ",
      "pronounce": "sara i",
      "detail": "Vokal pendek 'i', seperti dalam kata 'ini'"
    },
    {
      "aksara": "ึ",
      "nama": "สระอึ",
      "pronounce": "sara ue",
      "detail": "Vokal pendek 'ue'"
    },
    {
      "aksara": "ุ",
      "nama": "สระอุ",
      "pronounce": "sara u",
      "detail": "Vokal pendek 'u', seperti dalam kata 'buku'"
    },
    {
      "aksara": "เ-ะ",
      "nama": "สระเอะ",
      "pronounce": "sara e",
      "detail": "Vokal pendek 'e', seperti dalam kata 'enak'"
    },
    {
      "aksara": "แ-ะ",
      "nama": "สระแอะ",
      "pronounce": "sara ae",
      "detail": "Vokal pendek 'ae'"
    },
    {
      "aksara": "โ-ะ",
      "nama": "สระโอะ",
      "pronounce": "sara o",
      "detail": "Vokal pendek 'o', seperti dalam kata 'toko'"
    },
    {
      "aksara": "เ-าะ",
      "nama": "สระเอาะ",
      "pronounce": "sara o",
      "detail": "Vokal pendek 'o'"
    },
    {
      "aksara": "เ-อะ",
      "nama": "สระเออะ",
      "pronounce": "sara oe",
      "detail": "Vokal pendek 'oe'"
    },
    {
      "aksara": "า",
      "nama": "สระอา",
      "pronounce": "sara aa",
      "detail": "Vokal panjang 'aa', seperti dalam kata 'bapak'"
    },
    {
      "aksara": "ี",
      "nama": "สระอี",
      "pronounce": "sara ii",
      "detail": "Vokal panjang 'ii', seperti dalam kata 'pipi'"
    },
    {
      "aksara": "ื",
      "nama": "สระอือ",
      "pronounce": "sara uue",
      "detail": "Vokal panjang 'ue'"
    },
    {
      "aksara": "ู",
      "nama": "สระอู",
      "pronounce": "sara uu",
      "detail": "Vokal panjang 'uu', seperti dalam kata 'kuku'"
    },
    {
      "aksara": "เ",
      "nama": "สระเอ",
      "pronounce": "sara ee",
      "detail": "Vokal panjang 'ee'"
    },
    {
      "aksara": "แ",
      "nama": "สระแอ",
      "pronounce": "sara ae",
      "detail": "Vokal panjang 'ae'"
    },
    {
      "aksara": "โ",
      "nama": "สระโอ",
      "pronounce": "sara oo",
      "detail": "Vokal panjang 'oo'"
    },
    {
      "aksara": "เ-อ",
      "nama": "สระเออ",
      "pronounce": "sara oe",
      "detail": "Vokal panjang 'oe'"
    },
    {
      "aksara": "เ-ีย",
      "nama": "สระเอีย",
      "pronounce": "sara ia",
      "detail": "Vokal gabungan 'ia'"
    },
    {
      "aksara": "เ-ือ",
      "nama": "สระเอือ",
      "pronounce": "sara uea",
      "detail": "Vokal gabungan 'uea'"
    },
    {
      "aksara": "-ัว",
      "nama": "สระอัว",
      "pronounce": "sara ua",
      "detail": "Vokal gabungan 'ua'"
    },
    {
      "aksara": "ำ",
      "nama": "สระอำ",
      "pronounce": "sara am",
      "detail": "Vokal gabungan 'am'"
    },
    {
      "aksara": "ใ",
      "nama": "สระใอ",
      "pronounce": "sara ai",
      "detail": "Vokal gabungan 'ai'"
    },
    {
      "aksara": "ไ",
      "nama": "สระไอ",
      "pronounce": "sara ai",
      "detail": "Vokal gabungan 'ai'"
    },
    {
      "aksara": "เ-า",
      "nama": "สระเอา",
      "pronounce": "sara ao",
      "detail": "Vokal gabungan 'ao'"
    },
    {
      "aksara": "เ-ย",
      "nama": "สระเอย",
      "pronounce": "sara oei",
      "detail": "Vokal gabungan 'oei'"
    },
    {
      "aksara": "-อย",
      "nama": "สระออย",
      "pronounce": "sara oi",
      "detail": "Vokal gabungan 'oi'"
    },
    {
      "aksara": "-วย",
      "nama": "สระอวย",
      "pronounce": "sara uai",
      "detail": "Vokal gabungan 'uai'"
    },
    {
      "aksara": "แ-็ว",
      "nama": "สระแอ็ว",
      "pronounce": "sara aeo",
      "detail": "Vokal gabungan 'aeo'"
    },
    {
      "aksara": "เ-็ว",
      "nama": "สระเอ็ว",
      "pronounce": "sara eo",
      "detail": "Vokal gabungan 'eo'"
    },
    {
      "aksara": "ั",
      "nama": "ไม้หันอากาศ",
      "pronounce": "mai han akat",
      "detail": "Tanda vokal 'a' pendek"
    },
    {
      "aksara": "็",
      "nama": "ไม้ไต่คู้",
      "pronounce": "mai taikhu",
      "detail": "Tanda untuk memperpendek vokal"
    },
    {
      "aksara": "์",
      "nama": "การันต์",
      "pronounce": "karan",
      "detail": "Tanda untuk membuat huruf menjadi bisu"
    },
    {
      "aksara": "-ํ",
      "nama": "นิคหิต",
      "pronounce": "nikkhahit",
      "detail": "Tanda untuk suara 'ng' di akhir"
    },
    {
      "aksara": "ฤ",
      "nama": "ฤ",
      "pronounce": "rue",
      "detail": "Huruf spesial yang berfungsi sebagai vokal 'rue'"
    },
    {
      "aksara": "ฦ",
      "nama": "ฦ",
      "pronounce": "lue",
      "detail": "Huruf spesial yang berfungsi sebagai vokal 'lue'"
    }
  ].obs;
  void showAksaraDetail(BuildContext context, Map<String, String> aksara) {
    double screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: screenWidth * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: screenWidth * 0.45,
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      aksara['aksara']!,
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF757575),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        aksara['nama']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        aksara['pronounce']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        aksara['detail']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white60,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  RxList<Map<String, String>> toneMarksList = <Map<String, String>>[
    {'symbol': 'อิ', 'description': 'mai ek'},
    {'symbol': 'อี', 'description': 'mai tho'},
    {'symbol': 'อึ', 'description': 'mai tri'},
    {'symbol': 'อื', 'description': 'mai jattawa'},
  ].obs;

  RxList<Map<String, String>> toneSoundsList = <Map<String, String>>[
    {
      'symbol': '−',
      'character': 'อา',
      'description': 'Datar (rising saamaan)',
    },
    {
      'symbol': '\\',
      'character': 'อ่า',
      'description': 'Rendah (falling ek)',
    },
    {
      'symbol': '^',
      'character': 'อ้า',
      'description': 'Jatuh (high tho)',
    },
    {
      'symbol': '/',
      'character': 'อ๊า',
      'description': 'Tinggi (rising tri)',
    },
    {
      'symbol': 'V',
      'character': 'อ๋า',
      'description': 'Turun (falling jattawa)',
    },
  ].obs;

  void showToneDetail(BuildContext context, Map<String, String> tone) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ConstanColor.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: ConstanColor.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  tone['symbol']!,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: ConstanColor.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              tone['description']!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ConstanColor.primaryColor,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstanColor.primaryColor,
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Tutup',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void showToneSoundDetail(
      BuildContext context, Map<String, String> toneSound) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ConstanColor.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: ConstanColor.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      toneSound['symbol']!,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: ConstanColor.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    color: ConstanColor.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      toneSound['character']!,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: ConstanColor.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              toneSound['description']!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ConstanColor.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstanColor.primaryColor,
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Tutup',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  RxList<Map<String, String>> simbolList = <Map<String, String>>[
    {
      'symbol': 'อํ',
      'thai': 'กะ กัน',
      'pronunciation': '/ka/ /kan/',
      'description': '[nikhahit pada awal]',
    },
    {
      'symbol': 'อิ',
      'thai': 'เอะ เด็ด',
      'pronunciation': '/e/ /et/',
      'description': '[mai tai kuu]',
    },
    {
      'symbol': 'อี',
      'thai': 'การันต์',
      'pronunciation': '/kaaran(t)/',
      'description': '[mai thaikuu]',
    },
    {
      'symbol': 'ๆ',
      'thai': 'มาๆ',
      'pronunciation': '/maa maa/',
      'description': '[pengulangan]',
    },
    {
      'symbol': 'ๆ',
      'thai': 'อินโดๆ',
      'pronunciation': '/indo indo/',
      'description': '[pengulangan]',
    },
    {
      'symbol': 'ๆลๆ',
      'thai': '1 2 3 ๆลๆ',
      'pronunciation': '1,2,3 dst',
      'description': '[dan seterusnya]',
    },
  ].obs;

  void showSimbolDetail(BuildContext context, Map<String, String> simbol) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ConstanColor.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ConstanColor.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    simbol['symbol']!,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ConstanColor.primaryColor,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    simbol['thai']!,
                    style: TextStyle(
                      fontSize: 32,
                      color: ConstanColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                    color: ConstanColor.primaryColor.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    simbol['pronunciation']!,
                    style: TextStyle(
                      fontSize: 18,
                      color: ConstanColor.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    simbol['description']!,
                    style: TextStyle(
                      fontSize: 16,
                      color: ConstanColor.primaryColor.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstanColor.primaryColor,
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Tutup',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    currentContent.value = KategoriKonsonanView();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
