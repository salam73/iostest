


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:iostest/notionpagemoh.dart';

import 'api_service.dart';



class CachedImageWithPlaceholder extends ConsumerWidget {
  final String picUrl;
  final NotionPageMoh? notionPage;
  final int? pictureIndex;

  const CachedImageWithPlaceholder({
    super.key,
    required this.picUrl,
    this.notionPage,
    this.pictureIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final imageUrlNotifier = ref.watch(imageUrlProvider(picUrl).notifier);
    final imageUrlState = ref.watch(imageUrlProvider(picUrl));

    return CachedNetworkImage(
      imageUrl: imageUrlState,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) {
        final Box<NotionPageMoh> hiveBox = Hive.box<NotionPageMoh>('notionPages');
        int index = hiveBox.values.toList().indexWhere((p) => p.pageId == notionPage!.pageId);

        ApiService().fetchNotionPage(notionPage?.pageId ?? '').then((fetchedNotionPage) {
          if (index != -1) {
            hiveBox.putAt(index, fetchedNotionPage);
            print('Updated Hive box at index $index with new data.');
            if (fetchedNotionPage.pictureUrls != null && fetchedNotionPage.pictureUrls!.length > pictureIndex!) {
              ref.read(imageUrlProvider(picUrl).notifier).updateUrl(fetchedNotionPage.pictureUrls![pictureIndex!]);
            }
          } else {
            print('Error: Could not update Hive box. Index not found or notionPage is null.');
          }
        }).catchError((e) {
          print('Error fetching Notion page: $e');
        });

        return const Center(
          child:  Column(
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.error),
              Text('اضغط هنا لتحميل الصورة')
            ],
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('pictureIndex', pictureIndex));
  }
}

// Define a StateNotifier to manage the image URL
class ImageUrlNotifier extends StateNotifier<String> {
  ImageUrlNotifier(String initialUrl) : super(initialUrl);

  // Method to update the image URL
  void updateUrl(String newUrl) {
    state = newUrl;
  }
}

// Create a provider for the ImageUrlNotifier
final imageUrlProvider = StateNotifierProvider.family<ImageUrlNotifier, String, String>((ref, initialUrl) {
  return ImageUrlNotifier(initialUrl);
});