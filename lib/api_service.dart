import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iostest/notionpagemoh.dart';

class ApiService {
  final String baseUrl = 'https://api.notion.com/v1/pages/';

  Future<NotionPageMoh> fetchNotionPage(String pageId) async {
    // final response2 = await http.get(Uri.parse('$baseUrl$pageId'));
    const apiKey = 'secret_qC28KRlsKIdNPpySs0NKAW9y2YFvhqRhn64DKJRY2UU';

    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
    };


    final response = await http.get(
      Uri.parse('$baseUrl$pageId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return NotionPageMoh.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load page');
    }
  }

  // Future<NotionPage> fetchImageList(String pageId) async {
  //   NotionPage page = await fetchNotionPage(pageId);
  //   return page;
  // }
}
