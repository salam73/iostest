import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    fetchAllPages();
  }

  final NotionService notionService;
  bool isLoading = false;
  bool isAscending = true;

  Future<void> fetchAllPages() async {
    isLoading = true;
    String? nextCursor;
    bool hasMore = true;

    while (hasMore) {
      final result =
          await notionService.fetchNotionPages(startCursor: nextCursor);
      state = [...state, ...result['notionPages']];
      hasMore = result['hasMore'];
      nextCursor = result['nextCursor'];
    }

    isLoading = false;
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
}
