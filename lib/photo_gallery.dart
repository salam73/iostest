import 'package:flutter/material.dart';
import 'package:iostest/notionpagemoh.dart';

import 'Cached_image_Placeholder.dart';


class PhotoGallery extends StatefulWidget {
  final List<String> photoUrls;
  final NotionPageMoh notionPage; // Add NotionPage parameter

  PhotoGallery({required this.photoUrls, required this.notionPage});

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  late String _selectedPhotoUrl;

  @override
  void initState() {
    super.initState();
    // Initially display the first photo as the large photo
    _selectedPhotoUrl = widget.photoUrls[0];
  }

  void _onThumbnailTap(String photoUrl) {
    setState(() {
      _selectedPhotoUrl = photoUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display the large photo
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedImageWithPlaceholder(
              picUrl: _selectedPhotoUrl,
              notionPage: widget.notionPage,
              pictureIndex: widget.photoUrls.indexOf(_selectedPhotoUrl),
            ),
          ),
        ),
        // Display the thumbnails
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.photoUrls.length,
            itemBuilder: (context, index) {
              final photoUrl = widget.photoUrls[index];
              return GestureDetector(
                onTap: () => _onThumbnailTap(photoUrl),
                child: Container(
                  margin: EdgeInsets.all(4.0),
                  child: CachedImageWithPlaceholder(
                    picUrl: photoUrl,
                    notionPage: widget.notionPage,
                    pictureIndex: index,

                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
