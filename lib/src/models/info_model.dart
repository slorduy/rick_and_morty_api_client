/// DTO de la metadata de paginación que devuelve la API en cada respuesta de listado.
/// [next] y [prev] son null cuando no hay página siguiente o anterior respectivamente.
class InfoModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const InfoModel({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      count: json['count'] as int,
      pages: json['pages'] as int,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'pages': pages,
    'next': next,
    'prev': prev,
  };
}
