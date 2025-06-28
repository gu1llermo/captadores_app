class UserEntity {
  final int id;
  final String email;
  final String nombreAsesor;
  final String codigoAsesor;
  final String apiBaseUrl;
  final String token;

  const UserEntity({
    required this.id,
    required this.email,
    required this.nombreAsesor,
    required this.codigoAsesor,
    required this.apiBaseUrl,
    required this.token,
  });

  // get iniciales del usuario
  String get initials {
    final parts = nombreAsesor.split(' ');
    if (parts.length == 1) {
      if (parts[0].length >=2) {
        return parts[0].substring(0, 2).toUpperCase();
      }
      return parts[0][0].toUpperCase();
    }
    return parts.map((part) => part[0].toUpperCase()).join('');
  }

  String get hojaName => '$codigoAsesor-$token';

}