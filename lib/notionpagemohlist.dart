import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iostest/photo_gallery.dart';
import 'notionpageMohdetail.dart';
import 'notionserviceprovider.dart';

class NotionPageMohList extends ConsumerWidget {
  const NotionPageMohList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notionPages = ref.watch(notionPagesProvider);
    final notionPagesNotifier = ref.read(notionPagesProvider.notifier);
    final isLoading = notionPagesNotifier.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notion Pages'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              notionPagesNotifier.toggleSortOrder();
            },
          ),
        ],
        bottom: isLoading
            ? const PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: Column(
                  children: [LinearProgressIndicator(), Text('loading')],
                ),
              )
            : null,
      ),
      body: notionPages.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                          page.pictureUrls!.isNotEmpty &&
                                  page.pictureUrls!.length > 1
                              ? SizedBox(
                                  height: 300,
                                  child: PhotoGallery(
                                      photoUrls: page.pictureUrls!,
                                      notionPage: page),
                                )
                              : page.pictureUrls!.isNotEmpty
                                  ? Image.network(
                                      page.pictureUrls![0],
                                      height: 100,
                                    )
                                  : SizedBox(),
                          Text(page.title),
                          Text(page.category!),
                          Text(page.number!.toString()),
                          Text(index.toString()),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
