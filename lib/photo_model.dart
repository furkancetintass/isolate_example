class PhotoModel {
  final int id;
  final String title;
  final String url;

  PhotoModel({required this.id, required this.title, required this.url});

  factory PhotoModel.fromJson(Map json) {
    return PhotoModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
}