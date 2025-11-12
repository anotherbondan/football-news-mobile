// To parse this JSON data, do
//
//     final newsEntry = newsEntryFromJson(jsonString);

import 'dart:convert';

NewsEntry newsEntryFromJson(String str) => NewsEntry.fromJson(json.decode(str));

String newsEntryToJson(NewsEntry data) => json.encode(data.toJson());

class NewsEntry {
  String id;
  String title;
  String content;
  String category;
  String thumbnail;
  int newsViews;
  DateTime createdAt;
  bool isFeatured;
  int userId;

  NewsEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.thumbnail,
    required this.newsViews,
    required this.createdAt,
    required this.isFeatured,
    required this.userId,
  });

  factory NewsEntry.fromJson(Map<String, dynamic> json) => NewsEntry(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    newsViews: json["news_views"],
    createdAt: DateTime.parse(json["created_at"]),
    isFeatured: json["is_featured"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "category": category,
    "thumbnail": thumbnail,
    "news_views": newsViews,
    "created_at": createdAt.toIso8601String(),
    "is_featured": isFeatured,
    "user_id": userId,
  };
}
