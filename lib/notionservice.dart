import 'dart:convert';
import 'package:http/http.dart' as http;

import 'notionpagemoh.dart';

class NotionService {
  static const String proxyUrl = 'http://localhost:3000/notion';

  Future<List<NotionPageMoh>> fetchNotionPages() async {
    final response = await http.post(
      Uri.parse(proxyUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<NotionPageMoh> notionPages = [];

      for (var result in data['results']) {
        notionPages.add(NotionPageMoh.fromJson(result));
      }
      return notionPages;
    } else {
      throw Exception('Failed to load Notion pages');
    }
  }
}
