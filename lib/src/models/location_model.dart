/// DTO de una ubicación referenciada en un personaje (origin / location).
class LocationModel {
  final String name;
  final String url;

  const LocationModel({required this.name, required this.url});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}
