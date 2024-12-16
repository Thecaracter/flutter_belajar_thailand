import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/artikebookmark/controllers/artikebookmark_controller.dart';
import 'package:veryzona/app/modules/utils/constant_color.dart';

class ArtikelBookmarkView extends GetView<ArtikelBookmarkController> {
  const ArtikelBookmarkView({Key? key}) : super(key: key);

  Widget _buildImage(String? imageString) {
    if (imageString == null || imageString.isEmpty) {
      return const SizedBox(
        height: 120,
        child: Center(
          child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
        ),
      );
    }

    try {
      final String base64String = imageString.split(',').last;

      return Image.memory(
        base64Decode(base64String),
        width: double.infinity,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const SizedBox(
          height: 120,
          child: Center(
            child: Icon(Icons.error, size: 40, color: Colors.grey),
          ),
        ),
        gaplessPlayback: true,
      );
    } catch (e) {
      return const SizedBox(
        height: 120,
        child: Center(
          child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
        ),
      );
    }
  }

  Widget _buildCard(Map artikel, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 3 : 2;
    double cardWidth =
        (screenWidth - (32 + (16 * (crossAxisCount - 1)))) / crossAxisCount;

    return SizedBox(
      width: cardWidth,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Get.toNamed('/baca-artikel', arguments: {'id': artikel['id']});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(artikel['foto']),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          artikel['judul'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        flex: 3,
                        child: Text(
                          artikel['ringkasan'] ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.2,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.remove_red_eye,
                              size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 2),
                          Text(
                            '${artikel['view_count'] ?? 0}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.favorite,
                              size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 2),
                          Text(
                            '${artikel['like_count'] ?? 0}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ArtikelBookmarkController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Articles'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshArticles,
        color: ConstanColor.primaryColor,
        backgroundColor: Colors.white,
        displacement: 40.0,
        strokeWidth: 3.0,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: Obx(
          () => Stack(
            children: [
              if (controller.artikelList.isEmpty)
                ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: const Center(
                        child: Text(
                          'No bookmarked articles found\nPull down to refresh',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: controller.artikelList.length,
                      itemBuilder: (context, index) {
                        return _buildCard(
                            controller.artikelList[index], context);
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
