import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iostest/notionpagemohlist.dart';
import 'notionpagemoh.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotionPageMohAdapter());
  await Hive.openBox<NotionPageMoh>('notionPages');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
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
      ),
    );
  }
}
