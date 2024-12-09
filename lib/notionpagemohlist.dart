import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iostest/notionpageMohdetail.dart';
import 'package:iostest/photo_gallery.dart';
import 'notionserviceprovider.dart';

class NotionPageMohList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notionPages = ref.watch(notionPagesProvider);
    final notionPagesNotifier = ref.read(notionPagesProvider.notifier);
    final isLoading = notionPagesNotifier.isLoading;
    final categories = notionPagesNotifier.allPages
        .map((page) => page.category)
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('اهل ')),
        actions: [
          ElevatedButton(
              onPressed: () {
                notionPagesNotifier.toggleSortOrder();
              },
              child: Text('ok'))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Column(
            children: [
              if (isLoading) LinearProgressIndicator(),
              SizedBox(
                height: 48.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected =
                        notionPagesNotifier.filterCategory == category;

                    return GestureDetector(
                      onTap: () {
                        notionPagesNotifier.setFilterCategory(category);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.grey[200],
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Text(
                          category ?? "No Category",
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
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
                                    notionPage: page,
                                  ),
                                )
                              : page.pictureUrls!.isNotEmpty
                                  ? Image.network(
                                      page.pictureUrls![0],
                                      height: 100,
                                    )
                                  : SizedBox(),
                          Text(page.title),
                          Text(page.category ?? 'No category'),
                          Text(page.number?.toString() ?? 'No number'),
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
