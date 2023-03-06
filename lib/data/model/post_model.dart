class PostModel {
  PostModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  factory PostModel.fromMap(Map<String, dynamic> map) => PostModel(
        albumId: map["albumId"],
        id: map["id"],
        title: map["title"],
        url: map["url"],
        thumbnailUrl: map["thumbnailUrl"],
      );
}

class Failure {
  final String message;
  final String code;

  const Failure({this.message = "", this.code = ""});
}
