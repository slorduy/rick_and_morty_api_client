import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_api_client/src/datasouces/character_remote_datasource.dart';
import 'package:rick_and_morty_api_client/src/models/character_model.dart';
import 'package:rick_and_morty_api_client/src/models/character_response_model.dart';

/// URL base de la Rick and Morty API.
const String _baseUrl = 'https://rickandmortyapi.com/api';

/// Implementación concreta del datasource remoto.
/// Realiza las llamadas HTTP a la API de Rick and Morty.
class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  final http.Client client;

  const CharacterRemoteDatasourceImpl({required this.client});

  @override
  Future<CharacterResponseModel> getCharacters({int page = 1}) async {
    final uri = Uri.parse('$_baseUrl/character/?page=$page');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return CharacterResponseModel.fromJson(json);
    }

    throw Exception(
      'Error al obtener personajes: [${response.statusCode}] ${response.body}',
    );
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    final uri = Uri.parse('$_baseUrl/character/$id');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return CharacterModel.fromJson(json);
    }

    throw Exception(
      'Error al obtener personaje $id: [${response.statusCode}] ${response.body}',
    );
  }
}
