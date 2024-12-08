import 'package:hive/hive.dart';

part 'notionpagemoh.g.dart';

@HiveType(typeId: 0)
class NotionPageMoh {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final String? area;
  @HiveField(3)
  final num? price;
  @HiveField(4)
  final String? category;
  @HiveField(5)
  final List<String>? pictureUrls;
  @HiveField(6)
  final String? pageId;
  @HiveField(7)
  final String? lastEditedTime;
  @HiveField(8)
  final String? date;
  @HiveField(9)
  final num? number;
  @HiveField(10)
  final List<String>? pdfUrls;

  NotionPageMoh({
    required this.title,
    this.description,
    this.price,
    this.area,
    this.category,
    this.pictureUrls,
    this.pageId,
    this.lastEditedTime,
    this.date,
    this.number,
    this.pdfUrls,
  });

  factory NotionPageMoh.fromJson(Map<String, dynamic> json) {
    final titleList = json['properties']['title']['title'] as List<dynamic>;
    final title = titleList.isNotEmpty ? titleList[0]['plain_text'] as String : 'no name';

    final area = json['properties']['area']?['select']?['name'] ?? 'No area';

    final descriptionList = json['properties']['description']['rich_text'] as List<dynamic>;
    final description = descriptionList.isNotEmpty
        ? descriptionList[0]['plain_text'] as String
        : 'No description available';

    final price = json['properties']['price']?['number'] as num?;
    final category = json['properties']['category']?['select']?['name'];

    final pictureFiles = json['properties']?['pic']?['files'] as List<dynamic>? ?? [];
    final pictureUrls = pictureFiles.map((file) => file['file']?['url'] as String? ?? '').where((url) => url.isNotEmpty).toList();

    final pdfFiles = json['properties']?['pdf']?['files'] as List<dynamic>? ?? [];
    final pdfUrls = pdfFiles.map((file) => file['external']?['url'] as String? ?? '').where((url) => url.isNotEmpty).toList();

    final date = json['properties']['date']?['date']?['start'];

    final number = json['properties']['number']?['number'];

    final pageId = json['id'];
    final lastEditedTime = json['last_edited_time'];

    return NotionPageMoh(
      title: title,
      description: description,
      price: price,
      area: area,
      category: category,
      pictureUrls: pictureUrls,
      pageId: pageId,
      lastEditedTime: lastEditedTime,
      date: date,
      number: number,
      pdfUrls: pdfUrls,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'area': area,
    'price': price,
    'category': category,
    'pictureUrls': pictureUrls,
    'pageId': pageId,
    'lastEditedTime': lastEditedTime,
    'date': date,
    'number': number,
    'pdfUrls': pdfUrls,
  };
}
