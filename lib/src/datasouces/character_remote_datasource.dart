import 'package:rick_and_morty_api_client/src/models/character_model.dart';
import 'package:rick_and_morty_api_client/src/models/character_response_model.dart';

/// Contrato del datasource remoto para personajes.
/// La implementación concreta será la responsable de hacer las llamadas HTTP.
abstract class CharacterRemoteDatasource {
  /// Obtiene la respuesta paginada de personajes desde la API.
  /// [page] es el número de página a solicitar.
  Future<CharacterResponseModel> getCharacters({int page = 1});

  /// Obtiene un personaje por su [id] desde la API.
  Future<CharacterModel> getCharacterById(int id);
}
