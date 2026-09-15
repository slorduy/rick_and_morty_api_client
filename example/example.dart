import 'package:http/http.dart' as http;
import 'package:rick_and_morty_api_client/rick_and_morty_api_client.dart';

Future<void> main() async {
  final datasource = CharacterRemoteDatasourceImpl(client: http.Client());

  // --- Listado paginado ---
  final response = await datasource.getCharacters(page: 1);

  print('Total personajes: ${response.info.count}');
  print('Total páginas:    ${response.info.pages}');
  print('Siguiente página: ${response.info.next ?? "ninguna"}');
  print('');

  print('Primeros 3 personajes:');
  for (final character in response.results.take(3)) {
    print('  [${character.id}] ${character.name} — ${character.status} / ${character.species}');
  }

  print('');

  // --- Detalle por ID ---
  final rick = await datasource.getCharacterById(1);
  print('Detalle de ID 1:');
  print('  Nombre:    ${rick.name}');
  print('  Género:    ${rick.gender}');
  print('  Origen:    ${rick.origin.name}');
  print('  Ubicación: ${rick.location.name}');
  print('  Episodios: ${rick.episode.length}');
}
