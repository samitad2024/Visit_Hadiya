import 'package:flutter/foundation.dart';

enum FavoriteType { festival, media, site }

@immutable
class Favorite {
  final String id;
  final FavoriteType type;
  final String title;
  final String? subtitle;
  final String thumbnailUrl;
  final DateTime addedDate;

  const Favorite({
    required this.id,
    required this.type,
    required this.title,
    this.subtitle,
    required this.thumbnailUrl,
    required this.addedDate,
  });

  // fromJson
  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      type: FavoriteType.values.firstWhere((e) => e.toString() == json['type']),
      title: json['title'],
      subtitle: json['subtitle'],
      thumbnailUrl: json['thumbnailUrl'],
      addedDate: DateTime.parse(json['addedDate']),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(),
      'title': title,
      'subtitle': subtitle,
      'thumbnailUrl': thumbnailUrl,
      'addedDate': addedDate.toIso8601String(),
    };
  }
}
