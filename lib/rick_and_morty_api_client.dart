/// Cliente Dart para la Rick and Morty REST API.
library;

// Contrato del datasource — los consumidores dependen de la abstracción,
// no de la implementación concreta.
export 'src/datasouces/character_remote_datasource.dart';

// DTOs con serialización JSON
export 'src/models/character_model.dart';
export 'src/models/character_response_model.dart';
export 'src/models/info_model.dart';
export 'src/models/location_model.dart';
