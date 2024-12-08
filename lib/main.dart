import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'notionpagemoh.dart';
import 'notionpagemohlist.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotionPageMohAdapter());

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notion Pages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotionPageMohList(),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
