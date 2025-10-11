import 'package:flutter/foundation.dart';

enum MediaType { audio, video, photo }

@immutable
class MediaCategory {
  final String id;
  final String titleKey; // localization key
  final MediaType type;
  final String? imageUrl; // optional cover image

  const MediaCategory({
    required this.id,
    required this.titleKey,
    required this.type,
    this.imageUrl,
  });
}

@immutable
class MediaItem {
  final String id;
  final String title;
  final String? subtitle;
  final String thumbnailUrl; // could be network or asset path
  final MediaType type;
  final String?
  mediaUrl; // audio/video url or asset; for photos this may be the same as thumbnail
  final String categoryId; // reference to MediaCategory.id

  const MediaItem({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.type,
    required this.categoryId,
    this.subtitle,
    this.mediaUrl,
  });
}
