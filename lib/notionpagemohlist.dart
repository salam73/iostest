import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iostest/photo_gallery.dart';
import 'Cached_image_Placeholder.dart';
import 'notionpagemoh.dart';
import 'notionserviceprovider.dart';

class NotionPageMohList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notionPagesAsyncValue = ref.watch(notionPagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notion Pages'),
      ),
      body: notionPagesAsyncValue.when(
        data: (notionPages) {
          return ListView.builder(
            itemCount: notionPages.length,
            itemBuilder: (context, index) {
              final page = notionPages[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotionPageMohDetail(page: page),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        page.pictureUrls!.isNotEmpty&&page.pictureUrls!.length>1
                            ? SizedBox(
                          height: 300,
                              child: PhotoGallery(
                                  photoUrls: page.pictureUrls!,
                                  notionPage: page),
                            )
                            : page.pictureUrls!.isNotEmpty?
                            Image.network(page.pictureUrls![0], height: 100,):
                            SizedBox(),
                        Text(
                          page.title,
                        ),
                        Text(page.number!.toString()),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: SelectableText('Error: $error')),
      ),
    );
  }
}

class NotionPageMohDetail extends StatelessWidget {
  final NotionPageMoh page;

  NotionPageMohDetail({required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(page.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (page.pictureUrls != null && page.pictureUrls!.isNotEmpty&& page.pictureUrls!.length>1)
            SizedBox(
              height: 250,
              child:PhotoGallery(
    photoUrls: page.pictureUrls!,
        notionPage: page),

            ),
          if (page.pictureUrls != null && page.pictureUrls!.isNotEmpty&& page.pictureUrls!.length<2)
            CachedImageWithPlaceholder(
              picUrl: page.pictureUrls![0],
              notionPage: page,

            ),
          // Text(page.pictureUrls?.first??'asdfsa'),
          Text('النوع: ${page.category ?? 'No category'}'),
          Text('التاريخ: ${page.date ?? 'No date'}'),
          Text('الرقم: ${page.number?.toString() ?? 'No number'}'),
          if (page.pdfUrls != null && page.pdfUrls!.isNotEmpty)
            Column(
              children: page.pdfUrls!.map((pdfUrl) => SelectableText(pdfUrl)).toList(),
            ),
          Text(page.description ?? 'No description available'),
        ],
      ),
    );
  }
}
