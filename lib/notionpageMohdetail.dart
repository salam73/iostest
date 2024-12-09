import 'package:flutter/material.dart';
import 'package:iostest/photo_gallery.dart';

import 'Cached_image_Placeholder.dart';
import 'notionpagemoh.dart';

class NotionPageMohDetail extends StatelessWidget {
  final NotionPageMoh page;

  const NotionPageMohDetail({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(page.title),
      ),
      body: Column(
        //important to know
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (page.pictureUrls != null &&
              page.pictureUrls!.isNotEmpty &&
              page.pictureUrls!.length > 1)
            SizedBox(
              height: 400,
              // width: 250,
              child:
                  PhotoGallery(photoUrls: page.pictureUrls!, notionPage: page),
            ),
          if (page.pictureUrls != null &&
              page.pictureUrls!.isNotEmpty &&
              page.pictureUrls!.length < 2)
            SizedBox(
              height: 400,
              //width: 250,
              child: CachedImageWithPlaceholder(
                picUrl: page.pictureUrls![0],
                notionPage: page,
              ),
            ),
          // Text(page.pictureUrls?.first??'asdfsa'),
          Text('النوع: ${page.category ?? 'No category'}'),
          Text('التاريخ: ${page.date ?? 'No date'}'),
          Text('الرقم: ${page.number?.toString() ?? 'No number'}'),
          if (page.pdfUrls != null && page.pdfUrls!.isNotEmpty)
            Column(
              children: page.pdfUrls!.map((pdfUrl) => Text(pdfUrl)).toList(),
            ),
          Text(page.description ?? 'No description available'),
        ],
      ),
    );
  }
}
