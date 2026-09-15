import 'package:rick_and_morty_api_client/src/models/location_model.dart';

/// DTO de un personaje de la Rick and Morty API.
/// No depende de ningún dominio — cada app consumidora hace su propio mapeo.
class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationModel origin;
  final LocationModel location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      // La API puede devolver type vacío ("") pero nunca null.
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String,
      origin: LocationModel.fromJson(json['origin'] as Map<String, dynamic>),
      location: LocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      image: json['image'] as String,
      episode: List<String>.from(json['episode'] as List),
      url: json['url'] as String,
      created: DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'type': type,
    'gender': gender,
    'origin': origin.toJson(),
    'location': location.toJson(),
    'image': image,
    'episode': episode,
    'url': url,
    'created': created.toIso8601String(),
  };
}
