class ImageModel {
  final int id;
  final String sourceUrl;

  ImageModel({required this.id, required this.sourceUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      sourceUrl: json['source_url'],
    );
  }
}
