import 'dart:convert';
import 'package:http/http.dart' as http;
import 'notionpagemoh.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

const apiKey = 'secret_qC28KRlsKIdNPpySs0NKAW9y2YFvhqRhn64DKJRY2UU';
//const apiKey = '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';
const databaseId = '82566198aca9482c87ff3e2bdb7f484c';
//const databaseId = '10ce0378975180fca450d95e71f88232';
//  'd19292eead6644f4a11502e983ff4902';
const baseUrl = 'https://api.notion.com/v1';

class NotionService {
  static const String proxyUrl = 'http://localhost:3000/notion';
  static const int pageSize = 50; // Number of items to fetch per request
  // ignore: prefer_typing_uninitialized_variables
  var response;
  // static const NOTION_API_KEY = 'secret_7CQMiRICnGUqslPXXTx2fkamkPzel2k3DFpZiqDpICH';
  // static const NOTION_DATABASE_ID = '82566198aca9482c87ff3e2bdb7f484c';

  Future<Map<String, dynamic>> fetchNotionPages({String? startCursor}) async {
    final requestBody = startCursor != null
        ? jsonEncode({'start_cursor': startCursor, 'page_size': pageSize})
        : jsonEncode({'page_size': pageSize});

    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
    };

    // final response = await http.post(
    //   Uri.parse('$baseUrl/databases/$databaseId/query'),
    //   headers: headers,
    //   body: requestBody,
    // );
    if (kIsWeb) {
      response = await http.post(
        Uri.parse(proxyUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );
    } else {
      response = await http.post(
        Uri.parse('$baseUrl/databases/$databaseId/query'),
        headers: headers,
        body: requestBody,
      );
    }

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<NotionPageMoh> notionPages = [];

      for (var result in data['results']) {
        notionPages.add(NotionPageMoh.fromJson(result));
      }

      return {
        'notionPages': notionPages,
        'hasMore': data['has_more'] == true,
        'nextCursor': data['next_cursor']
      };
    } else {
      throw Exception('Failed to load Notion pages');
    }
  }
}
