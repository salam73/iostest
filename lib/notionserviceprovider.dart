import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'notionpagemoh.dart';
import 'notionservice.dart';

final notionServiceProvider = Provider((ref) => NotionService());

final notionPagesProvider =
    StateNotifierProvider<NotionPagesNotifier, List<NotionPageMoh>>((ref) {
  final notionService = ref.watch(notionServiceProvider);
  return NotionPagesNotifier(notionService);
});

class NotionPagesNotifier extends StateNotifier<List<NotionPageMoh>> {
  NotionPagesNotifier(this.notionService) : super([]) {
    loadPages();
  }

  final NotionService notionService;
  bool isLoading = false;
  bool isAscending = true;
  String? filterCategory;
  List<NotionPageMoh> allPages = [];

  Future<void> loadPages() async {
    isLoading = true;
    final box = Hive.box<NotionPageMoh>('notionPages');

    if (box.isNotEmpty) {
      allPages = box.values.toList();
      state = allPages;
      isLoading = false;
    } else {
      await fetchAllPages();
    }
  }

  Future<void> fetchAllPages() async {
    String? nextCursor;
    bool hasMore = true;

    while (hasMore) {
      final result =
          await notionService.fetchNotionPages(startCursor: nextCursor);
      allPages = [...allPages, ...result['notionPages']];
      hasMore = result['hasMore'];
      nextCursor = result['nextCursor'];
      state = allPages;
    }

    isLoading = false;
    applyFilter();

    // Save the data to Hive
    final box = Hive.box<NotionPageMoh>('notionPages');
    await box.clear();
    await box.addAll(allPages);
  }

  void toggleSortOrder() {
    isAscending = !isAscending;
    sortPages();
  }

  void sortPages() {
    state = [
      ...state
        ..sort((a, b) => isAscending
            ? (a.number ?? 0).compareTo(b.number ?? 0)
            : (b.number ?? 0).compareTo(a.number ?? 0))
    ];
  }

  void setFilterCategory(String? category) {
    filterCategory = category;
    applyFilter();
  }

  void applyFilter() {
    if (filterCategory != null && filterCategory!.isNotEmpty) {
      state = [...allPages.where((page) => page.category == filterCategory)];
    } else {
      state = allPages;
    }
  }
}
