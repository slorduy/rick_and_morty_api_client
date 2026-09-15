import 'package:rick_and_morty_api_client/src/models/character_model.dart';
import 'package:rick_and_morty_api_client/src/models/info_model.dart';

/// DTO que representa la respuesta completa de la API paginada de personajes.
/// Encapsula tanto la metadata de paginación (info) como la lista de personajes (results).
class CharacterResponseModel {
  final InfoModel info;
  final List<CharacterModel> results;

  const CharacterResponseModel({required this.info, required this.results});

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterResponseModel(
      info: InfoModel.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List)
          .map((item) => CharacterModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'info': info.toJson(),
    'results': results.map((c) => c.toJson()).toList(),
  };
}
