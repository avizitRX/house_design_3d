class ImageModel {
  final int id;
  final String source_url;

  ImageModel({required this.id, required this.source_url});

  factory ImageModel.fromJson(json) {
    return ImageModel(
      id: json['id'],
      source_url: json['source_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "source_url": source_url,
      };
}
