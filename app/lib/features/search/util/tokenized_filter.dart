typedef ToString<T> = String? Function(T);

class TokenizedFilter<T> {
  final Iterable<T> original;
  final List<T> filtered;

  static List<String> _tokenize(String input) {
    return input
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '') // Remove punctuation
        .split(RegExp(r'\s+')) // Split on whitespace
        .where((word) => word.isNotEmpty)
        .toList();
  }

  static bool _matchTokens(
    List<String> queryTokens,
    List<String> targetTokens,
  ) {
    return queryTokens.every(
      (queryToken) =>
          targetTokens.any((targetToken) => targetToken.contains(queryToken)),
    );
  }

  factory TokenizedFilter({
    required Iterable<T> items,
    required ToString<T> toString,
    required String query,
  }) {
    final queryTokens = _tokenize(query);

    final filtered = items.where((item) {
      final itemString = toString(item);
      if (itemString == null || itemString.isEmpty) {
        return false;
      }

      final itemTokens = _tokenize(itemString);
      return _matchTokens(queryTokens, itemTokens);
    }).toList();

    return TokenizedFilter._(items, filtered);
  }

  const TokenizedFilter._(this.original, this.filtered);
}
