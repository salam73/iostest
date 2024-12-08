import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notionpagemoh.dart';
import 'notionservice.dart';

final notionServiceProvider = Provider((ref) => NotionService());

final notionPagesProvider = FutureProvider<List<NotionPageMoh>>((ref) async {
  final notionService = ref.read(notionServiceProvider);
  return await notionService.fetchNotionPages();
});
