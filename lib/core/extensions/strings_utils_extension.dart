import 'package:diacritic/diacritic.dart';

extension StringsUtilsExtension on String {
  String getInitials() {
    
    final parts = split(' ');
    if (parts.length == 1) {
      if (parts[0].length >=2) {
        return parts[0].substring(0, 2).toUpperCase();
      }
      return parts[0][0].toUpperCase();
    }
    return parts.map((part) => part[0].toUpperCase()).join('').substring(0, 2);
  
   
  }
  bool searchFlexible(
    // String text,
    String searchTerm, {
    double matchThreshold = 0.7, // Umbral de coincidencia
    bool partialMatch = true, // Permitir coincidencia parcial
    int minWordLength = 1, // Longitud mínima de palabra para coincidir
  }) {
    // Normalizar texto y término de búsqueda
    final normalizedText = removeDiacritics(toLowerCase());
    final normalizedSearchTerm = removeDiacritics(searchTerm.toLowerCase());

    // Dividir en palabras
    final textWords =
        normalizedText
            .split(' ')
            .where((word) => word.length >= minWordLength)
            .toList();
    final searchWords =
        normalizedSearchTerm
            .split(' ')
            .where((word) => word.length >= minWordLength)
            .toList();

    // Si no hay términos de búsqueda válidos, retornar falso
    if (searchWords.isEmpty) return false;

    // Contador de coincidencias
    int matchCount = 0;

    for (final searchWord in searchWords) {
      bool wordMatched = false;

      for (final textWord in textWords) {
        // Coincidencia exacta
        if (textWord == searchWord) {
          matchCount++;
          wordMatched = true;
          break;
        }

        // Coincidencia parcial si está habilitada
        if (partialMatch && textWord.contains(searchWord)) {
          matchCount++;
          wordMatched = true;
          break;
        }
      }

      // Si no se encontró coincidencia para alguna palabra, verificar umbral
      if (!wordMatched && searchWords.length > 1) {
        // Calcular porcentaje de coincidencia
        final percentageMatch = matchCount / searchWords.length;
        return percentageMatch >= matchThreshold;
      }
    }

    // Verificar si se cumple el umbral de coincidencia
    final percentageMatch = matchCount / searchWords.length;
    return percentageMatch >= matchThreshold;
  }
}